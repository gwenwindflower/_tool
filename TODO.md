# {{TOOL_NAME}} TODO

<!--
  This file tracks active and upcoming work using the SPOT system
  (Spec, Phases, Objectives, Tasks). See AGENTS.md for the summary;
  the user's `~/.agents/rules/projects.md` and the `spot-project-management`
  skill have the full spec.

  Conventions:
    - Phase status markers: 🌀 active, ✅ completed, no marker = unstarted.
    - Multiple Phases may be 🌀 at once when none of them blocks another.
    - Phase numbers are stable IDs, not sequence — order comes from the
      `**Dependencies**:` line on each Phase, not from the number.
    - The `**Requirements**:` line on a Phase points at SPEC.md (`R<NNN>`)
      or domain-spec IDs (`<dom>-R<NNN>`). Manager treats this list as
      the focus checklist for promotion to DONE.
    - When a Task completes: remove it from this file and add it to
      DONE.md under its Objective with the box checked. Never edit the
      original Task text — the historical record stays honest.
    - Tag with `#user` any item only the human can do (deploys, account
      changes, manual installs). Agents must STOP and alert when blocked
      by one of these.
    - When TODO and a spec disagree, the spec wins. Flag the mismatch.

  The Phase below is a generic worked example. Overwrite it with your
  real first Phase when you're ready to start work.
-->

## Phase 1: 🌀 {{FIRST_PHASE_DESCRIPTION}}

**Requirements**: R001, {{dom}}-R001

{{ONE_OR_TWO_SENTENCES_ON_THE_PHASE_GOAL_AND_WHY_IT_COMES_FIRST}}

### {{FIRST_OBJECTIVE_DESCRIPTION}}

{{ONE_OR_TWO_SENTENCES_ON_WHAT_THIS_OBJECTIVE_DELIVERS_LIKE_A_PR_DESCRIPTION}}

- [ ] {{FIRST_TASK_IN_IMPERATIVE_MOOD}}
- [ ] {{SECOND_TASK}}
- [ ] {{THIRD_TASK}}

### {{SECOND_OBJECTIVE_DESCRIPTION}}

{{ONE_OR_TWO_SENTENCES}}

- [ ] {{FIRST_TASK}}
- [ ] {{SECOND_TASK}}
- [ ] #user {{TASK_ONLY_THE_HUMAN_CAN_DO_EG_PROVISION_THE_REPO_OR_PUBLISH_FIRST_RELEASE}}

## Phase 2: {{SECOND_PHASE_DESCRIPTION}}

**Dependencies**: 1
**Requirements**: {{dom}}-R002

{{ONE_OR_TWO_SENTENCES_ON_WHAT_THIS_PHASE_DELIVERS_AND_WHY_IT_DEPENDS_ON_PHASE_1}}

### {{OBJECTIVE_DESCRIPTION}}

- [ ] {{TASK}}
- [ ] {{TASK}}
