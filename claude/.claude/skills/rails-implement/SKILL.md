---
name: rails-implement
description: Implement a spec or set of tickets in a Rails app, planned by layer and driven red-green-refactor, then run a four-axis review.
disable-model-invocation: true
argument-hint: "<spec path, ticket reference, or description>"
---

Implement the work described by the user in the spec or tickets.

1. If the user passes a ticket reference, fetch it from the issue tracker and state its title before starting. If the reference is ambiguous, ask. If you are on the default branch, create a branch for the work.
2. **Plan by layer.**
   - Read `CONTEXT.md` and `docs/adr/` if they exist: name classes and methods with the glossary's terms, and keep to the decisions the ADRs record.
   - Call the Skill tool with "layered-rails:layered-rails".
   - For each class you plan to add or change, write its test skeleton as [skeleton.md](skeleton.md) describes.
   - When the input is a plan from `/rails-grill`, start from its skeletons and confirm only what you changed; otherwise confirm the skeletons with the user.

   Done when every entry is ✓ or a ⚠️ the user accepted.
3. Drive each ✓ entry and each accepted ⚠️ entry red-green-refactor, one at a time, using the project's test framework (`spec/` for RSpec, `test/` for Minitest):
   - **Red:** write the test in the file for its layer (model test for domain rules, service test for orchestration, request or integration test for HTTP only) and run that one test: `bundle exec rspec <file>:<line>` or `bin/rails test <file>:<line>`. It must fail for the reason the entry names.
   - **Green:** write only the code that makes it pass.
   - **Refactor** while the test stays green.
   - Build data with the project's factories or fixtures and real objects; stub only external boundaries (HTTP, SDKs, mail delivery).
   - Take expected values from the spec or a worked example, never recomputed the way the code computes them.
4. Run the linter on the files you touched. Run the full suite once at the end when the project's instructions allow it; otherwise name the suites still to run.
5. Commit your work.
6. Call the Skill tool with "rails-review", using the default branch as the fixed point.
7. Fix the findings that are not judgement calls: broken documented rules, Spec gaps, confirmed Correctness bugs (each starting from a failing test that reproduces it), and Critical or Warning Layers findings. Re-run the touched tests and the linter, then commit the fixes. Hand the smells, Layers Suggestions, Possible and Opportunities lists to the user.
