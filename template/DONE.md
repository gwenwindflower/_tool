# Template maintenance ledger

## Phase 1: Shared task regression coverage

**Requirements**: R001, R002, R003, R004, R005

### Shared task ownership

- [x] Port label and ruleset fixes with regression tests
- [x] Generalize artifact recovery and its tests
- [x] Run template-only suites in CI and exclude them during bootstrap
- [x] Document the audit and bidirectional maintenance rules
- [x] Verify the template suites and workflow audits

Heraldr supplied label reconciliation, CI-only ruleset discovery, and verified artifact recovery. `audit.md` records source commits and the coverage retained in Heraldr. The neutral version suite moved into template maintenance; generated projects keep their language and application contracts. The project-workflows bootstrap removes maintenance files on creation and skips them during alignment, with a sandbox regression test for both modes.

The template gate passed on macOS: four shared shell suites, file checks, and workflow audits. Both provisioning suites failed against the original tasks before their fixes were ported. CI runs the same gate on Linux and macOS; hosted results remain to be checked after publication. wtherdr's Rust exclusion prevents crate attributes from triggering the executable-shebang hook. Pin audits use an explicit token or anonymous access, without extracting stored credentials.
