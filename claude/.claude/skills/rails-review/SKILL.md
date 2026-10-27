---
name: rails-review
description: Four-axis review of a Rails branch or diff (Standards, Spec, Correctness, Layers). Use when reviewing Rails changes since a fixed point, or when another skill needs a full Rails review.
argument-hint: "<fixed point: branch, commit or tag> [spec path]"
---

Review a Rails diff on four axes, each from its own reviewer:

- **Standards**, **Spec** and **Correctness** come from the `rails-code-review` skill.
- **Layers** comes from the `layered-rails:layered-rails-reviewer` agent: does each change sit in the right architecture layer?

## Process

### 1. Pin the fixed point

Take the fixed point the user gave; ask if there is none. Confirm it resolves (`git rev-parse <fixed-point>`) and that `git diff <fixed-point>...HEAD` is non-empty. Done when both hold.

### 2. Start the Layers reviewer

Spawn the `layered-rails:layered-rails-reviewer` agent with:

- the diff command `git diff <fixed-point>...HEAD` and the commit list `git log <fixed-point>..HEAD --oneline`;
- the brief: "Report findings on lines this diff adds or changes, each with file:line, severity and a fix. Put anything about unchanged code (god objects, churn, old callbacks, concern health) in a separate Opportunities list. Under 400 words."

### 3. Run Standards, Spec and Correctness

While the Layers reviewer works, call the Skill tool with "rails-code-review", passing the same fixed point and the spec path if the user gave one.

### 4. Report

Present `## Standards`, `## Spec`, `## Correctness` and `## Layers` as each reviewer wrote them, then one `## Opportunities` list combining both reviews. Keep the axes separate and unranked: a change can pass one and fail another.

End with one line: findings per axis and the worst issue within each. Done when all four axes are reported, or a skipped axis says why.
