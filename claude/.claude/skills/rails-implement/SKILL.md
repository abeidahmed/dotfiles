---
name: rails-implement
description: Implement a spec or set of tickets in a Rails app, planned by layer and driven red-green-refactor, then run a three-axis review.
disable-model-invocation: true
argument-hint: "<spec path, ticket reference, or description>"
---

Implement the work described by the user in the spec or tickets.

1. If the user passes a ticket reference, fetch it from the issue tracker and state its title before starting. If the reference is ambiguous, ask.
2. Call the Skill tool with "layered-rails:layered-rails". For each class you plan to add or change, write its test skeleton (describe/context blocks for RSpec, test names for Minitest, no bodies) and mark every entry ✓/⚠️/✗ for that class's layer, following the skill's spec-test workflow (`workflows/spec-test.md`). Move each ✗ to the class in its own layer. When the input is a plan from `/rails-grill`, start from its skeletons and confirm only what you changed; otherwise confirm the skeletons with the user. Done when every entry is ✓ or a ⚠️ the user accepted.
3. Drive each ✓ entry red-green-refactor, one at a time, using the project's test framework (`spec/` for RSpec, `test/` for Minitest):
   - **Red:** write the test in the file for its layer (model test for domain rules, service test for orchestration, request or integration test for HTTP only) and run that one test: `bundle exec rspec <file>:<line>` or `bin/rails test <file>:<line>`. It must fail for the reason the entry names.
   - **Green:** write only the code that makes it pass.
   - **Refactor** while the file stays green.
   - Build data with the project's factories or fixtures and real objects; stub only external boundaries (HTTP, SDKs, mail delivery).
   - Take expected values from the spec or a worked example, never recomputed the way the code computes them.
4. Run the linter on the files you touched. Run the full suite once at the end when the project's instructions allow it; otherwise name the suites still to run.
5. Call the Skill tool with "rails-review", using the branch's base as the fixed point. Fix the Standards, Spec and Layers findings on your code; hand the Opportunities list to the user.
6. Commit your work to the current branch, creating a branch first if you are on the default one.
