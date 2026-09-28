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

The template is language-neutral. A kit adds language tooling to `mise.toml` at the `LANG_TOOLS` and `LANG_TASKS` markers, appends ignore rules at `LANG_IGNORES` in `.gitignore`, and provides these tasks:

| Task | Contract |
| --- | --- |
| `build` | Produce the release binary at `dist/bin/@@TOOL_BINARY@@` for the host target. |
| `lint:*` | Every semantic linter as its own task (formatters belong in `prek.toml`); CI runs `mise run 'lint:*'`. |
| `test:*` | Every test suite; CI runs `mise run 'test:*'` on Linux and macOS. |
| `version:read` | Print the declared version (`1.2.3`) and nothing else. Executable at `mise-tasks/version/read`. |
| `version:write <version>` | Set the declared version and rewrite every file derived from it. |
| `version:files` | Print, one per line, every file `version:write` may touch. |
| `version:verify` | Optional. Exit non-zero when a derived file disagrees with the declared version. |

The language toolchain itself is never a mise tool. It lives on `PATH` through the language's own manager (rustup for Rust, declared by `rust-toolchain.toml`), and CI uses the runner image's copy. `mise.toml` declares only the linters, release tooling, and language-adjacent binaries the project adds.

Release archives are named `<name>-<target>-v<version>.tgz` with Rust-style target triples for every language (`aarch64-apple-darwin`, `x86_64-apple-darwin`, `aarch64-unknown-linux-gnu`, `x86_64-unknown-linux-gnu`). The build matrix in `release-build.yml` maps runners to those triples; `build` only ever compiles for its host.

## Hooks

`prek.toml` holds every per-commit check: builtin hygiene, rumdl, shellcheck, zizmor on workflows, and the `commit-msg` Conventional Commit check in `scripts/check-commit-message`. Kits add language hooks at the `LANG_HOOKS` marker. `.config/wt.toml` runs `lint:*` before a `wt merge` squash and `release:check` after the rebase. Keep whole-repo work out of `prek.toml` and formatters out of `wt.toml`.

## Provisioning

In order. Steps marked `#user` need the account owner.

1. `#user` `gh repo create <owner>/<name> --template gwenwindflower/_tool --public --clone`, then commit the filled placeholders and push `main`.
2. `mise trust && mise install`, then `pinact run --update` and `mise run hooks:install`. The bootstrap writes `mise.local.toml` disabling every declared tool, because the core set is installed globally; delete lines for tools this machine lacks.
3. `mise run repo:settings --description "<one line>" --topics "<a,b,c>"` (add `--homebrew` for a standalone CLI that should publish to the tap).
4. `mise run repo:labels` and `mise run repo:environments`. Follow the publishing setup below.
5. Choose the project license and review `CONTRIBUTING.md` as described below.
6. Push a throwaway branch with a deliberate lint failure, open a PR, and confirm the annotation appears on the diff. Close it.
7. `mise run repo:rulesets` after CI has reported on `main` at least once; it requires those check names on the default branch.
8. `#user` If Homebrew is on: create `<owner>/homebrew-tap` if missing, create a fine-grained PAT with contents write on that repo, and store it as `HOMEBREW_TAP_TOKEN` in the `release` environment.
9. `mise run release:rehearse`, then `#user` `mise run release`.

CI jobs carry `if: !github.event.repository.is_template`, so they never run on the template repository itself. They also skip on any repository later flagged as a template.

## Publishing environment

Every publishing job uses `environment: release`, including GitHub asset uploads, Homebrew, and any registry publishing added by a language kit. Build-only jobs and manual build rehearsals do not use it. `repo:environments` configures a `v*` tag policy; review existing deployment policies and add required reviewers if desired. Keep publishing secrets in this environment.

For registry trusted publishing, bind the exact owner/repository, publishing workflow filename, and `release` environment. Grant `id-token: write` only to jobs that exchange an OIDC token; GitHub uploads and the Homebrew PAT do not need it. An environment alone does not restrict identity to one workflow: cloud trust policies must also constrain the workflow claim (or a customized subject) supported by the provider. Match the repository's actual subject format, including immutable IDs where enabled. See [GitHub's OIDC reference](https://docs.github.com/en/actions/reference/security/oidc).

## License and community files

The template itself is unlicensed. For a generated project, rename `LICENSE-option1-apache` to `LICENSE` by default, or select `LICENSE-option2-fsl` only on request, then remove the unused option. Fill the copyright placeholders and align the README, package metadata, and `.github/homebrew/formula.rb.tmpl` with `Apache-2.0` or `FSL-1.1-ALv2`. FSL is source-available, with each version becoming available under Apache 2.0 after two years.

Keep `CONTRIBUTING.md` for a self-contained project. It limits PRs to invited collaborators while welcoming requests to collaborate through Discussions. Add a security policy only when the project needs one.

For an organization with a public `.github` repository, local community files may be deleted where the shared defaults fit. Update direct links to deleted files to point to their shared locations; fallback files are not present in clones. GitHub also supports these defaults for personal accounts, but this template does not require them. `LICENSE` never inherits and must remain in every project. Local issue templates or `config.yml` override the entire shared issue-template directory. See [GitHub's supported defaults](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file).
