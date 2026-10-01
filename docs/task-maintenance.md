# Maintaining shared tasks

`gwenwindflower/_tool` collects task-system patterns learned in real projects. Improvements flow in both directions; consistency means sharing useful behavior while preserving each project's contracts.

- When changing inherited behavior, evolve the corresponding regression tests in the same change. Generalize reusable fixes and upstream the task and tests together.
- When adding a useful generic task, consider contributing it to `_tool`, with tests, declared tools, documentation, and any workflow wiring it needs. Language-specific patterns belong in the `project-workflows` language kit; application-specific behavior stays local.
- Generic task suites belong in `_tool`'s `template/tests/`. Project suites test integration with their language, version files, packaging, and application. Keep a local regression test while behavior intentionally differs from upstream.
- During task-system maintenance, after a significant upstream change, or before a release following a long gap, compare the template with local tasks. Review history and diffs, adopt relevant fixes with their tests, and record retained differences and the reviewed upstream commit in the project's ledger. Do not overwrite local adaptations wholesale.

Before moving coverage upstream, run it against the generalized implementation and verify that the project still meets the same contract. Remove a local suite only after its shared behavior is covered upstream; retain assertions that depend on project-specific wiring. Tests use temporary fixtures and fake external commands, never live provisioning or publication.

The template's maintenance suite runs with `mise -C template run check` and `.github/workflows/template.yml`. Bootstrap excludes `template/` and that workflow; GitHub's template button cannot exclude paths, so remove both during manual bootstrap. Generated projects run their own `test:*` tasks.

Both CI workflows gate checks and tests on a separate online audit job with a read-only GitHub token. Use `needs: audit` on checks and preserve the test job's dependency on checks, so an audit failure skips downstream work. Commit hooks run `zizmor --offline`; the dedicated audit job runs online checks, including known vulnerabilities.

The template matrix runs `mise -C template run lint ::: test` after the audit succeeds; the local maintenance gate includes audits too. Multiple mise tasks require `:::` between invocations. Quote the command in YAML because the separator contains a colon followed by whitespace.

Online zizmor audits write an HTTP cache. Restrict the TOML task to that directory:

```toml
[tasks."ci-audit:zizmor"]
description = "Audit the GitHub Actions workflows for security issues"
run = "zizmor ."
allow_write = ["~/.cache/zizmor"]
```

`allow_write` restricts other writes without a separate `deny_write` setting. A bare `deny_write = true` blocks the cache and can make the vulnerability audit fail before producing findings. Mise applies this policy only when running the task; a direct `zizmor --format github .` CI step does not inherit it. Validate the exact CI command as well as the local gate, and verify online audits with a token: an offline pass does not exercise the cache.
