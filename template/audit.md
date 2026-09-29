# Heraldr task audit

Audited Heraldr's task suites against `_tool` at `afe5f47` on 2026-09-29.

| Suite or pattern | Owner | Decision |
| --- | --- | --- |
| Label reconciliation | `_tool` | Port the implementation and tests from Heraldr `d123199`; preserve declared existing labels and remove undeclared labels only after successful creation. |
| Required-check discovery | `_tool` | Port the CI-only discovery fix and tests from Heraldr `5d4930a`; release jobs must not become branch requirements. |
| Artifact recovery | `_tool` | Port Heraldr `b1570c1` with owner/name placeholders; the four targets match the template release matrix. Adapt this task with the matrix when targets differ. |
| Neutral version hooks and release commit guard | `_tool` | Keep the existing fake-language-kit suite in template maintenance, excluded from generated projects. |
| Cargo and Herdr version synchronization | Heraldr | Retain tests of Cargo.toml, Cargo.lock, and herdr-plugin.toml synchronization. |
| Crate publishing guards | Heraldr | Retain the release-asset and OIDC contract tests; the neutral template has no crate publication tasks. A reusable Cargo publishing kit should carry these together. |
| Automated task selection | Heraldr | Retain checks of its actual Cargo, packaging, and Herdr task graph. |
| Plugin manifest and binary installer | Heraldr | Retain application-specific installer and manifest contracts. |
| Rust crate attributes and executable checks | Template and Rust guidance | Adopt wtherdr's `exclude_types = ["rust"]` on the shebang-executable hook; Rust `#![...]` attributes are not scripts. |

The shared test suite exercises fake GitHub commands and temporary repositories. It does not need credentials or write to GitHub. Remaining local suites protect intentional project integration, rather than copies of generic task behavior.
