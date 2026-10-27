---
name: rails-grill
description: Grill a Rails feature or refactor plan layer by layer, starting from a layered-rails draft, until it is ready for /rails-implement.
disable-model-invocation: true
argument-hint: "<feature or refactor goal>"
---

Turn the user's goal into a plan where every responsibility has a layer and every decision is the user's.

1. **Classify the goal.** A refactor changes where existing code lives (fat controller, callbacks, god object, authorization, queries, view logic). A feature adds behaviour. If it is unclear which, ask.
2. **Draft.**
   - **Refactor:** spawn the `layered-rails:layered-rails-planner` agent with the goal and this brief: "Produce the phased plan your workflow describes, built on the patterns this codebase already uses. End with an Open decisions list: every choice the plan makes that the user should own (pattern, phase order, stop point, scope), each with your recommendation."
   - **Feature:** call the Skill tool with "layered-rails:layered-rails". List each responsibility the feature adds (input, authorization, rules, persistence, side effects, presentation) with the layer and class you would put it in, following the patterns the codebase already uses. For each class, write a test skeleton and mark every entry ✓/⚠️/✗ following the skill's spec-test workflow (`workflows/spec-test.md`). Where a class the feature touches needs restructuring before it can take the change cleanly, spawn the planner for that prep refactor as in the refactor branch. Collect every choice as an Open decisions list, each with your recommendation.

   Done when there is a draft and an Open decisions list.
3. **Grill.** Call the Skill tool with "grilling" and walk the Open decisions, plus any new ones the answers raise. Done when every decision has the user's answer and the user confirms the shared understanding.
4. **Write the plan.** Ask where to save it, suggesting `tmp/<slug>-plan.md`. Record the goal; each class with its layer and test skeleton; the phases with their "stop here if"; each decision with the user's answer; and what was ruled out and why. Tell the user they can use `/rails-implement <path>` to take it from there.
