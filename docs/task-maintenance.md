# Maintaining shared tasks

`gwenwindflower/_tool` collects task-system patterns learned in real projects. Improvements flow in both directions; consistency means sharing useful behavior while preserving each project's contracts.

- When changing inherited behavior, evolve the corresponding regression tests in the same change. Generalize reusable fixes and upstream the task and tests together.
- When adding a useful generic task, consider contributing it to `_tool`, with tests, declared tools, documentation, and any workflow wiring it needs. Language-specific patterns belong in the `project-workflows` language kit; application-specific behavior stays local.
- Generic task suites belong in `_tool`'s `template/tests/`. Project suites test integration with their language, version files, packaging, and application. Keep a local regression test while behavior intentionally differs from upstream.
- During task-system maintenance, after a significant upstream change, or before a release following a long gap, compare the template with local tasks. Review history and diffs, adopt relevant fixes with their tests, and record retained differences and the reviewed upstream commit in the project's ledger. Do not overwrite local adaptations wholesale.

Before moving coverage upstream, run it against the generalized implementation and verify that the project still meets the same contract. Remove a local suite only after its shared behavior is covered upstream; retain assertions that depend on project-specific wiring. Tests use temporary fixtures and fake external commands, never live provisioning or publication.

The template's maintenance suite runs with `mise -C template run check` and `.github/workflows/template.yml`. Bootstrap excludes `template/` and that workflow; GitHub's template button cannot exclude paths, so remove both during manual bootstrap. Generated projects run their own `test:*` tasks.

Both CI workflows gate checks and tests on a separate online audit job. The template matrix runs only lint and tests after the audit succeeds; the local maintenance gate includes all three. Commit hooks run zizmor offline for checks that do not need GitHub access. Online audits need a writable cache.
