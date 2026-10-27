---
name: rails-code-review
description: Standards, Spec and Correctness review of a Rails diff since a fixed point. Use when reviewing Rails changes for bugs, conventions or spec fit without the architecture lens, or when another skill needs a Rails code review.
argument-hint: "<fixed point: branch, commit or tag> [spec path]"
---

Review a Rails diff on three axes, each in its own subagent so one axis does not colour another:

- **Standards**: does the code follow the repo's documented rules and avoid the smells in [standards.md](standards.md)?
- **Spec**: does it do what the plan, ticket or spec asked?
- **Correctness**: can it crash, return a wrong result, lose data or open a security hole? See [correctness.md](correctness.md).

## Process

### 1. Pin the fixed point

Take the fixed point the user gave; ask if there is none. Confirm `git rev-parse <fixed-point>` resolves and `git diff <fixed-point>...HEAD` is non-empty, and note the commit list `git log <fixed-point>..HEAD --oneline`. Done when both checks hold.

### 2. Find the spec

In order: a spec path passed in; a `/rails-grill` plan written in this conversation; issue references in the commit messages (fetch them with `gh issue view`); otherwise ask. If the user says there is none, skip the Spec axis.

### 3. Find the standards

Collect the files that document how this repo writes code (`CLAUDE.md`, `.claude/rules/`, `CONTRIBUTING.md`, style guides under `docs/`) and the linters it configures (`.rubocop.yml`, `.erb-lint.yml` and the like).

### 4. Spawn the reviewers

Send one message with three general-purpose agents. Give each the diff command, the commit list and this shared rule: "Report only on lines this diff adds or changes, each with file:line. Put anything about unchanged code in a separate Opportunities list. Under 400 words."

- **Standards:** the standards files, the linter list and the absolute path to standards.md. Brief: "Report where the diff breaks a documented rule (cite the file and the rule) and any smell from standards.md (name it, quote the hunk). Documented rules are hard findings; smells are judgement calls, and a documented rule overrides a smell. Skip what the linters enforce."
- **Spec:** the spec. Brief: "Report requirements that are missing or partial, behaviour nobody asked for, and requirements that look implemented but wrong. Quote the spec line for each."
- **Correctness:** the absolute path to correctness.md. Brief: "Hunt bugs with correctness.md. For each, give the input or state that triggers it and the wrong result, traced through the code. Mark what you cannot trace end to end as Possible."

### 5. Verify Correctness

Read the cited lines of each Correctness finding and follow its trace. Keep the findings that hold; move the rest to Possible, saying what is unproven. Done when every finding is confirmed or marked Possible.

### 6. Report

Present `## Standards`, `## Spec`, `## Correctness` and `## Opportunities`, each as its reviewer wrote it apart from step 5's changes. Keep the axes separate and unranked: a change can pass one and fail another. End with one line: findings per axis and the worst issue within each.
