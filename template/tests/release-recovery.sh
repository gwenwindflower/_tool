#!/usr/bin/env bash
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
sandbox="$(mktemp -d "${TMPDIR:-/tmp}/tool-recovery-test.XXXXXX")"
trap 'rm -rf "$sandbox"' EXIT
mkdir -p "$sandbox/bin"
cat >"$sandbox/bin/gh" <<'SCRIPT'
#!/usr/bin/env bash
set -euo pipefail
case "$1 $2" in
  'api repos/example/widget/actions/runs/123')
    printf '%s\t%s\t%s\t%s\tabc\n' "${TEST_EVENT:-release}" "${TEST_STATUS:-completed}" "${TEST_WORKFLOW:-.github/workflows/release-build.yml}" "${TEST_TAG:-v0.0.1}" ;;
  'api repos/example/widget/commits/v0.0.1')
    printf '%s\n' "${TEST_COMMIT:-abc}" ;;
  'release view') printf '%s\n' "${TEST_DRAFT:-false}" ;;
  'run download')
    target="${7#widget-}"
    archive="widget-$target-v0.0.1.tgz"
    printf 'test binary\n' >"$9/$archive"
    (cd "$9" && shasum -a 256 "$archive" >"$archive.sha256")
    if [[ "${TEST_CORRUPT:-0}" == 1 ]]; then printf 'corrupt\n' >>"$9/$archive"; fi ;;
  'release upload')
    [[ "$3" == v0.0.1 && "$4" == --repo && "$5" == example/widget && "$#" == 13 ]]
    printf 'uploaded\n' >"$TEST_UPLOAD" ;;
  *) printf 'Unexpected command: %s\n' "$*" >&2; exit 1 ;;
esac
SCRIPT
chmod +x "$sandbox/bin/gh"
export TEST_UPLOAD="$sandbox/upload"
sed -e 's|@@GH_OWNER@@|example|g' -e 's|@@TOOL_NAME@@|widget|g' \
  "$repo_root/mise-tasks/release/recover-assets" >"$sandbox/recover-assets"
run_recovery() {
  PATH="$sandbox/bin:$PATH" MISE_PROJECT_ROOT="$sandbox" bash "$sandbox/recover-assets" 123
}
run_recovery
[[ -f "$TEST_UPLOAD" ]]
rm "$TEST_UPLOAD"
for failure in TEST_EVENT=workflow_dispatch TEST_STATUS=in_progress TEST_WORKFLOW=.github/workflows/ci.yml TEST_TAG=main TEST_COMMIT=wrong TEST_DRAFT=true TEST_CORRUPT=1; do
  export "${failure?}"
  if run_recovery >"$sandbox/output" 2>&1; then
    printf 'Recovery accepted %s\n' "$failure" >&2
    exit 1
  fi
  [[ ! -e "$TEST_UPLOAD" ]]
  unset "${failure%%=*}"
done
printf 'Release artifact recovery tests passed.\n'
