# Template maintenance ledger

## Phase 2: Gate CI on workflow audits

**Requirements**: R006, R007

### Audit before checks and tests

- [x] Gate application and template checks on dedicated audit jobs
- [x] Allow online audit cache writes and make commit hooks explicitly offline
- [x] Validate workflows and run the template maintenance gate

Application checks depend on the workflow audit; tests depend on checks. Template maintenance runs one audit job before its Linux and macOS matrix, avoiding duplicate online audits. Commit hooks run offline, and the explicit audit task permits cache writes needed by online checks.

`mise -C template run check` passed all four regression suites, file checks, offline zizmor, and the online pin verification. GitHub-hosted job skipping and authenticated zizmor remain to be verified in CI. Workflow wiring is validated with the existing checks rather than tests that assert YAML structure.

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
