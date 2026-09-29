# Shared task system

- **R001** — Shared task regression suites run in the template on Linux and macOS without a language kit or external writes.
- **R002** — Project bootstrap excludes template maintenance files and its CI workflow from generated and aligned projects.
- **R003** — Label reconciliation creates missing declarations, preserves existing declared labels, and removes undeclared labels only after successful discovery and creation; an empty declaration fails without deleting labels.
- **R004** — Required checks come only from the latest completed CI push run on main; absent or empty CI results prevent ruleset writes.
- **R005** — Artifact recovery uploads only checksum-verified archives from a completed release build whose source commit matches an existing published release tag.

Shared behavior and its regression coverage evolve together. Projects contribute reusable fixes and tasks back here; intentional local contracts remain in their own suites.
