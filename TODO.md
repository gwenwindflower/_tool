# {{TOOL_NAME}} TODO

## Phase 1: Repo bootstrap 🌀

**Requirements**: dev-R001, dev-R008, dev-R009, dev-R012

### Repository provisioning

- [ ] #user Create the GitHub repository from the template and push `main`
- [ ] Run `mise run repo:settings --description "..." --topics "..."`, `mise run repo:labels`, and `mise run repo:environments`
- [ ] #user Confirm CONTRIBUTING and SECURITY resolve from the owner's `.github` repository

### First green CI

- [ ] Install the language kit and fill every remaining placeholder listed in `docs/bootstrap.md`
- [ ] Open a throwaway PR with a deliberate lint failure and confirm the annotation lands on the diff
- [ ] Run `mise run repo:rulesets` once CI has reported on `main`

### Release rehearsal

- [ ] Run `mise run release:rehearse` and resolve everything it reports
- [ ] #user Cut the first release with `mise run release`, then run `mise run release:verify`
