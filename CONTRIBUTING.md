# Contributing

Pull requests are open to invited collaborators only. If you're eager to work on this project, start a Discussion describing what interests you and what you'd like to contribute. Collaborator invitations are considered case by case; please wait for an invitation before opening a PR.

## Issues and Discussions

Questions, ideas, and exploratory proposals belong in Discussions. Use issues for reproducible bugs and concrete change requests: include the version, relevant environment, steps to reproduce, and expected and actual behavior. For suggestions, explain the use case and proposed change.

## Working on a change

Read the README for setup and `AGENTS.md` for project conventions. Keep each change focused, agree on larger changes before implementation, and add tests for behavior changes. Update the docs and CLI help when behavior changes affect users.

Run `mise run check` before submitting. Workflow changes also require `mise run ci-audit`. Keep the commit hooks enabled and fix any failures they report.

## Commits and pull requests

Use [Conventional Commits](https://www.conventionalcommits.org/) for commits and PR titles: `type(scope): imperative subject`, with no trailing period and at most 70 characters. Group commits by purpose; add a short body only when the rationale needs explanation.

Describe the problem, resulting behavior, and how you tested the change in the PR. Link related issues. Keep history linear by rebasing your own branch; maintainers normally squash PRs when merging.

Contributions use the license in this repository's `LICENSE` file.
