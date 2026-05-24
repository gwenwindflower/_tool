# {{TOOL_NAME}} — Spec

<!--
  SPEC.md is the project-level entry point for *what we're building and why*.
  It indexes the domain specs (`specs/<dom>-<slug>.md`) and carries any
  cross-cutting project-level requirements.

  Requirement IDs are stable, soft-immutable identifiers:
    - Project-level: `R<NNN>` (e.g. `R001`)
    - Domain-level: `<dom>-R<NNN>` (e.g. `sk-R007`)
  Never reuse an ID once retired.

  When SPEC and TODO disagree, the spec wins. Update the spec first;
  point TODO at the new IDs.
-->

## What we're building

{{ONE_OR_TWO_PARAGRAPHS_ON_THE_TOOL_AND_THE_USER_PROBLEM_IT_SOLVES}}

## Why

{{ONE_OR_TWO_PARAGRAPHS_ON_THE_MOTIVATION_AND_OUTCOMES_THIS_TOOL_DELIVERS}}

## Domain specs

Each durable domain gets its own file under `specs/`. Cross-link from here so
future readers (and Planners) find them.

| Domain | Prefix | Spec |
| --- | --- | --- |
| {{DOMAIN_NAME}} | `{{dom}}` | [`specs/{{dom}}-{{slug}}.md`](./specs/{{dom}}-{{slug}}.md) |

## Project-level requirements

Cross-cutting requirements that don't belong to a single domain.

- **R001** — {{ONE_LINE_REQUIREMENT_DESCRIPTION}}
- **R002** — {{ONE_LINE_REQUIREMENT_DESCRIPTION}}
