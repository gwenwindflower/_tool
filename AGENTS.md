# {{TOOL_NAME}}

{{ONE_SENTENCE_ON_WHAT_THE_TOOL_DOES}}. Written in {{LANGUAGE}} and distributed as a single binary.

## Run work through tasks

[mise](https://mise.jdx.dev) owns the toolchain and the task list. `mise tasks` lists every task with its description; `mise tasks info <task>` prints one task's definition, arguments, and source. Prefer a task over the command it wraps, and add a task rather than running a one-off. CI installs mise and runs these same tasks, so a task definition is the only place a check lives. `mise run check` is the full local gate.

Task scripts live in `mise-tasks/`, grouped into directories that become the `version:`, `release:`, and `repo:` prefixes. Each is plain bash that runs standalone, and they compose by calling each other through those paths. `mise.toml` holds one-line wrappers, pipelines, and tool versions.

`depends` runs in parallel, so order-sensitive steps belong in a sequential `run` array. `deny_net` and `deny_write` are honored only on TOML tasks.

## Releases are human-gated

Never run `release`, `release:push`, or `release:create`. They push commits and create public GitHub releases behind mise `confirm` gates that default to no. `release:rehearse` is the dry run: it exercises every read-only step and prints the notes that would ship. Run it when the project looks ready, report what it says, and stop.

`version:read` reports the version's single source of truth. Never hand-edit the files it derives; report drift with `version:check` and repair it with `version:sync`. `version:bump` belongs to a release, not to ordinary work.

## Hooks guard commits, tasks guard merges

prek runs file hygiene on every commit (staged files only) and rejects commit subjects git-cliff cannot parse; `mise run hooks:install` wires it into a fresh clone. `wt merge` runs one gate after the rebase: `release:check` into the default branch, `check` into any other. Never commit with `--no-verify`; fix what the hook reports.

## Workflow changes

Every `uses:` under `.github/workflows/` stays pinned to a commit SHA with a trailing version comment, and every change passes `mise run ci-audit`.

Publishing jobs use `environment: release`. Registry trusted publishers bind the repository, workflow filename, and environment; grant `id-token: write` only to jobs that use OIDC.

## Planning

This project uses SPOT: `SPEC.md` and `specs/` hold requirements with stable IDs, `TODO.md` holds active Phases, `DONE.md` is the ledger of shipped work. The `projects` rule and the `spot-project-management` skill define the system. Commit bodies carry `Completes <Objective> in Phase N` and `Closes Phase N` lines after any body bullets and before trailers.

## Docs

- `docs/bootstrap.md` — placeholders, language-kit hooks, and provisioning steps. Delete once bootstrap is complete.
