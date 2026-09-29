# {{TOOL_NAME}}

> {{ONE_LINE_TAGLINE}}

{{TOOL_NAME}} is {{SHORT_DESCRIPTION_ONE_OR_TWO_SENTENCES}}.

## Install

{{TOOL_NAME}} ships as a single static binary per platform.

```bash
{{INSTALL_COMMANDS}}

# Homebrew (macOS / Linux)
brew install {{GH_OWNER}}/tap/{{TOOL_NAME}}

# Release binary
# https://github.com/{{GH_OWNER}}/{{TOOL_NAME}}/releases
```

Verify the install:

```bash
{{TOOL_BINARY}} --version
{{TOOL_BINARY}} --help
```

## Quick start

```bash
# 1. {{STEP_ONE_DESCRIPTION}}
{{TOOL_BINARY}} {{STEP_ONE_COMMAND}}

# 2. {{STEP_TWO_DESCRIPTION}}
{{TOOL_BINARY}} {{STEP_TWO_COMMAND}}
```

## Commands

| Command | What it does |
| --- | --- |
| `{{TOOL_BINARY}} {{EXAMPLE_COMMAND_ONE}}` | {{ONE_LINE_DESCRIPTION}} |
| `{{TOOL_BINARY}} {{EXAMPLE_COMMAND_TWO}}` | {{ONE_LINE_DESCRIPTION}} |

Run `{{TOOL_BINARY}} <command> --help` for full flags and examples.

## Local development

```bash
mise trust && mise install   # toolchain
mise tasks                   # every task with its description
mise run check               # the same gate CI runs
```

Already have some of those tools on your `PATH`? Copy `mise.local.toml.example` to `mise.local.toml` (gitignored) and list them under `disable_tools`. mise then skips installing them here and tasks use whatever `command -v` finds; CI installs whatever `mise.toml` resolves, so keep yours current.

Releases run from `main` through `mise run release`; `mise run release:rehearse` is the side-effect-free dry run.

## Issues vs. Discussions

Discussions are for ideas, questions, and "what if {{TOOL_NAME}} did X?". Issues are for concrete, reproducible change requests: a bug with a repro, a missing flag with a clear shape, a doc inaccuracy. Start in Discussions if you're not sure.

## License

This template is unlicensed. Projects created from it must select a license: GPL 3.0 by default, AGPL 3.0 for network services, or FSL on request. Use the option files and [bootstrap instructions](docs/bootstrap.md#license-and-community-files); the option files do not license `_tool` itself.
