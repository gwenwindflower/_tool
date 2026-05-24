# {{TOOL_NAME}} DONE

<!--
  Shipped work, with rationale. See AGENTS.md for the SPOT overview.

  How entries land here:
    - When a Task completes, REMOVE the unchecked bullet from TODO.md and
      ADD it to its Objective below with the box checked. Don't edit the
      original wording — the historical record stays honest, planned vs.
      actually-shipped side by side.
    - Optionally append indented sub-bullets — decisions, gotchas, links,
      or why a non-obvious approach was taken. Append-only; don't rewrite.
    - When a Phase's last requirement is met and its Tasks are all checked,
      promote it: update the Phase header to ✅, and (if the Phase started
      in TODO.md) delete it from TODO.md. Phases are added here Phase-first;
      Tasks accumulate under them as they're closed.

  This file holds the *why* — specs hold the *what*, code holds the *how*.
  When something surprising or non-obvious shapes a Phase, capture it in
  an "Implementation notes" subsection so future readers don't have to
  reconstruct it from commits.

  Order: reverse-chronological by Phase completion (newest at the top).

  The example Phase below shows the expected shape. Overwrite it as you
  complete real Phases.
-->

## Phase 0: ✅ Repo bootstrap (example entry — overwrite when you ship your first real Phase)

**Requirements**: R001

Stood up the repo from `tool-template`: README, AGENTS, SPEC/specs/TODO/DONE
scaffolding, issue and PR templates, and a first run of `provision-repo.ts`
to align labels and Discussions with the org standard.

### Repo scaffolding from template

Cloned `supermodellabs/tool-template`, replaced placeholders, and committed the baseline.

- [x] Replace `{{TOOL_NAME}}` and other placeholders across README, AGENTS, SPEC, TODO, DONE
- [x] Confirm `.github/ISSUE_TEMPLATE/` and `PULL_REQUEST_TEMPLATE.md` render correctly on GitHub
- [x] First green CI run on `main`

### Org standard provisioning

- [x] #user Run `provision-repo.ts {{TOOL_NAME}}` to reconcile labels and Discussion categories
- [x] #user Enable Discussions and verify Announcements / Ideas / Help / Share categories exist
- [x] #user Confirm inheritance of `CONTRIBUTING.md` and `SECURITY.md` from `supermodellabs/.github`

### Implementation notes

{{ANY_DECISIONS_TRADEOFFS_OR_SURPRISES_WORTH_REMEMBERING_LATER}}

For example: which name we picked and why, any deviations from the standard
org baseline, the shape of the first Phase 1 we're now starting in `TODO.md`.
