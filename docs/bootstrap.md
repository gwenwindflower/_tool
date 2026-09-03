# Bootstrap

Everything a new repository needs before its first release. Delete this file when the checklist is done; `AGENTS.md` links here until then.

## Placeholders

Markdown files use `{{NAME}}`. YAML, TOML, and scripts use `@@NAME@@` so the template itself stays parseable by zizmor, pinact, and tombi. Fill both forms.

| Placeholder | Meaning |
| --- | --- |
| `TOOL_NAME` | Repository and package name (`heraldr`) |
| `TOOL_BINARY` | Installed executable name; usually the same |
| `GH_OWNER` | GitHub user or org that owns the repo and the Homebrew tap |
| `AUTHOR` | Copyright holder in `LICENSE` |
| `YEAR` | Copyright year in `LICENSE` |
| `LANGUAGE` | Named once in `AGENTS.md` |

Prose placeholders (`{{ONE_LINE_TAGLINE}}`, `{{INSTALL_COMMANDS}}`, and the like) are filled by hand. Find what remains:

```bash
rg -n '\{\{[A-Z_]+' --glob '!docs/bootstrap.md'
rg -n '@@[A-Z_]+@@' --glob '!docs/bootstrap.md'
```

## Language kit

The template is language-neutral. A kit (installed by the `bootstrap-tool` skill) adds the toolchain to `mise.toml` at the `LANG_TOOLS` and `LANG_TASKS` markers, appends ignore rules at `LANG_IGNORES` in `.gitignore`, and provides these tasks:

| Task | Contract |
| --- | --- |
| `build` | Produce the release binary at `dist/bin/@@TOOL_BINARY@@` for the host target. |
| `lint:*` | Every formatter and linter, each as its own task; CI runs `mise run 'lint:*'`. |
| `test:*` | Every test suite; CI runs `mise run 'test:*'` on Linux and macOS. |
| `version:read` | Print the declared version (`1.2.3`) and nothing else. Executable at `mise-tasks/version/read`. |
| `version:write <version>` | Set the declared version and rewrite every file derived from it. |
| `version:files` | Print, one per line, every file `version:write` may touch. |
| `version:verify` | Optional. Exit non-zero when a derived file disagrees with the declared version. |

Release archives are named `<name>-<target>-v<version>.tgz` with Rust-style target triples for every language (`aarch64-apple-darwin`, `x86_64-apple-darwin`, `aarch64-unknown-linux-gnu`, `x86_64-unknown-linux-gnu`). The build matrix in `release-build.yml` maps runners to those triples; `build` only ever compiles for its host.

## Provisioning

In order. Steps marked `#user` need the account owner.

1. `#user` `gh repo create <owner>/<name> --template gwenwindflower/_tool --public --clone`, then commit the filled placeholders and push `main`.
2. `mise trust && mise install`, then `pinact run -update` and `mise use git-cliff@latest pinact@latest zizmor@latest` to refresh pins the template carries.
3. `mise run repo:settings --description "<one line>" --topics "<a,b,c>"` (add `--homebrew` for a standalone CLI that should publish to the tap).
4. `mise run repo:labels`.
5. `#user` Ensure `<owner>/.github` exists with `CONTRIBUTING.md` and `SECURITY.md`; the issue forms, PR template, and README link to them.
6. Push a throwaway branch with a deliberate lint failure, open a PR, and confirm the annotation appears on the diff. Close it.
7. `mise run repo:rulesets` after CI has reported on `main` at least once; it requires those check names on the default branch.
8. `#user` If Homebrew is on: create `<owner>/homebrew-tap` if missing, create a fine-grained PAT with contents write on that repo, and store it as the `HOMEBREW_TAP_TOKEN` secret.
9. `mise run release:rehearse`, then `#user` `mise run release`.

CI jobs carry `if: !github.event.repository.is_template`, so they never run on the template repository itself. They also skip on any repository later flagged as a template.
