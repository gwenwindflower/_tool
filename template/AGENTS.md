# Template maintenance

This directory belongs only to `gwenwindflower/_tool`. The bootstrap removes `template/` and `.github/workflows/template.yml` from new projects and skips them when aligning existing projects. GitHub's template button copies everything; manual bootstrap must remove both paths.

`mise -C template run check` tests shared tasks with temporary repositories and fake external commands. Tests must never provision GitHub repositories, publish artifacts, or require a language kit. Keep project-specific integration tests in the consuming project.

Use `template/SPEC.md`, `template/TODO.md`, and `template/DONE.md` for maintenance planning; the root planning files are project scaffolds. `mise -C template run check` includes tests, file checks, and workflow audits. Worktrunk selects this gate when `template/mise.toml` exists; generated projects use their application gate.
