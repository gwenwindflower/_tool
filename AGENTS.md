# {{TOOL_NAME}} — Agent Context

Welcome. This file is the entry point for agents working on {{TOOL_NAME}}. Read it first; it points at everything else.

## What this project is

{{TOOL_NAME}} is a [Supermodel Labs](https://github.com/supermodellabs) tool — part of a small family of source-available and open source CLIs for **agentic analytics engineering**. The brand brief, in short:

- Single portable binary, distributed via Homebrew (`supermodellabs/tap`) and Linux package managers.
- Friendly, ergonomic CLI UX: pretty output, helpful errors that link to docs, agent-friendly verbose modes, and just enough delight (animated splash screens, ASCII art, tasteful color) to make the command line feel alive without tipping into gimmick.
- Tools compose where it makes sense — assume a user may have several Supermodel tools installed and lean on shared conventions.

Edit `README.md` for the user-facing pitch; this file is for collaborators and agents.

## Repo baseline

Every Supermodel Labs repo ships with the same baseline. Rely on it; don't reinvent it locally.

| Surface | Where | Notes |
| --- | --- | --- |
| Issue templates | `.github/ISSUE_TEMPLATE/` | Two forms: bug + suggestion. Everything else routes to Discussions via `config.yml`. |
| PR template | `.github/PULL_REQUEST_TEMPLATE.md` | Conventional Commits title, summary, related, testing, checklist. |
| Discussion categories | Provisioned by `provision-repo.ts` | Announcements 🤗, Ideas 🧐, Help 🤠, Share 😍. |
| Labels | Provisioned by `provision-repo.ts` | `type:`, `status:`, plus `good first issue`, `help wanted`, `duplicate`. |
| Workflows | `.github/workflows/` | Standard CI, release, and homebrew-tap publish flows. |
| Contributing guide | Inherited from `supermodellabs/.github` | Don't add a per-repo `CONTRIBUTING.md` unless this tool genuinely diverges. |
| Security policy | Inherited from `supermodellabs/.github` | Same — only override if this tool has a meaningfully different threat model. |

When in doubt, prefer to update the org-level defaults over forking them per repo.

## How we plan and track work

This project uses the **SPOT (Spec, Phases, Objectives, Tasks)** system. The full spec lives in the user's rules at `~/.agents/rules/projects.md` and the `spot-project-management` skill; the summary below is enough to be productive.

**Files:**

| File | Scope | Job |
| --- | --- | --- |
| `SPEC.md` | Project | What we're building and why; indexes the domain specs |
| `specs/<dom>-<slug>.md` | Domain | Durable per-domain requirements with stable IDs |
| `TODO.md` | Project | Active work; each Phase lists the requirement IDs it must satisfy |
| `DONE.md` | Project | Shipped work, with rationale |
| `docs/` | Project | How the system works *now* |

**Hierarchy:**

| Level | Markdown | Role | Execution |
| --- | --- | --- | --- |
| **Phase** | `## Phase N: description` + optional `**Dependencies**:` / `**Requirements**:` lines | Checkpoint, sized for one team's worth of work | Parallel where independent; sequenced where dependencies declare it |
| **Objective** | `### description` | Declarative goal (well-scoped, like a PR) | Parallel within a Phase — one subagent's lane |
| **Task** | `- [ ] description` | Imperative step inside an Objective | Sequential within an Objective |

**Status markers on Phases:** 🌀 active, ✅ completed, no marker = unstarted. Multiple Phases may be 🌀 at once when none of them blocks another. Phase numbers are stable IDs, not sequence — order between Phases comes from the `**Dependencies**:` line.

**Phase metadata:** the header carries up to two optional lines, in this order:

- `**Dependencies**: <N>, <N>, ...` — bare Phase numbers this Phase depends on. Omit when empty. A Phase is **unblocked** once every listed dependency is fully promoted to DONE.
- `**Requirements**: <id>, <id>, ...` — IDs from `SPEC.md` (`R<NNN>`) or domain specs (`<dom>-R<NNN>`, e.g. `cli-R007`). Manager treats this as the focus checklist: every Task done **and** every listed requirement met before the Phase moves to DONE. IDs are soft-immutable — never reused once retired.

**Task lifecycle:** when a Task is finished, (1) remove the unchecked bullet from `TODO.md`, (2) add it to its Objective in `DONE.md` with the box checked, (3) optionally append indented sub-bullets — decisions, gotchas, links, why a non-obvious approach was taken. **Never edit the original Task text** — the historical record stays honest, planned vs. actually-shipped side by side.

**Roles:** Planner owns *what* (specs and TODO). Manager owns *execution* (coordinates a Phase, moves it to DONE). Subagent owns one Objective and commits — never rebases.

**A few rules that matter:**

- **When TODO and a spec disagree, the spec wins.** Flag the mismatch.
- `#user`-tagged items are for the human (deploys, manual installs, account changes). Don't attempt them — if one blocks you, **stop and alert the user**.
- **Subagents commit, never rebase.** Manager folds bookkeeping into substantive commits (checking off a Task is a fixup into the subagent's commit, not a standalone commit).
- **Phase boundary is a hard checkpoint.** Last Phase fully promoted to DONE and committed before the next starts on the same thread of work.
- **Spec-only commits should be rare.** Use `chore(specs)` only when the change carries something a future reader can't get from the surrounding behavior commits (e.g. threading a learning back into specs after a Phase).
- If wording is ambiguous, an approach feels risky, or a task looks low-value — pause, flag it, agree on the change, persist to the spec or `TODO.md`, *then* do the work.

See the existing entries in `SPEC.md`, `specs/`, `TODO.md`, and `DONE.md` for shape — they're written as worked examples for a fresh project.
