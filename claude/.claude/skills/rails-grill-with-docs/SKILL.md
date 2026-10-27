---
name: rails-grill-with-docs
description: Run /rails-grill and build the domain glossary (CONTEXT.md) and ADRs as decisions land.
disable-model-invocation: true
argument-hint: "<feature or refactor goal>"
---

Read `~/.claude/skills/rails-grill/SKILL.md` and follow it, with two changes:

- In step 2, read `CONTEXT.md` and `docs/adr/` first if they exist: name the draft's classes with the glossary's terms, and leave out options an ADR already ruled out.
- In step 3, run the grilling session using the domain-modeling skill: call the Skill tool with "domain-modeling" as well as "grilling".
