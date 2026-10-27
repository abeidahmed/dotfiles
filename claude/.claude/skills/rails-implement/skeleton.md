# Test skeleton

A test skeleton lists the tests a class needs, without bodies: `describe`/`context` blocks for RSpec, test names for Minitest.

1. With the `layered-rails:layered-rails` skill loaded, follow its spec-test workflow (`workflows/spec-test.md`) to mark every entry for the class's layer: ✓ belongs here, ⚠️ borderline, ✗ belongs in another layer.
2. Move each ✗ entry to the skeleton of the class in its own layer, adding that class to the plan if it is new.
