# Standards baseline

Smells to check on top of the repo's documented rules. Each is a judgement call ("possible Feature Envy"), a documented repo rule overrides it, and anything a configured linter enforces is skipped. Each entry reads: what it is → the fix.

- **Mysterious Name**: a method, variable or class whose name hides what it does or holds. → Rename it; if no honest name comes, the design is murky.
- **Duplicated Code**: the same logic shape in more than one hunk or file of the change. → Extract it once and call it from both.
- **Long Method**: a method doing several things at different levels of detail. → Extract the steps into named methods.
- **Feature Envy**: a method that works mostly with another object's attributes. → Move it onto that object.
- **Primitive Obsession**: a string, hash or loose group of values standing in for a domain concept (money, a date range, a status). → A value object (`Data.define`), an `enum`, or a model attribute type.
- **Message Chains**: callers walking `order.customer.account.plan.name`. → `delegate`, or one method on the first object.
- **Speculative Generality**: options, hooks or abstractions no current caller needs. → Delete them; inline until a second caller exists.
- **Reinvented Rails**: hand-rolled code for what Rails or Active Support already does. → Use the built-in:
  - `where(...).first` → `find_by`
  - `count > 0` or `any? { ... }` on a relation → `exists?`
  - `map(&:id)` on a relation → `ids` or `pluck`
  - `each` over a growing table → `find_each`
  - `value.blank? ? nil : value` → `presence`
  - a string status column with hand-written predicates → `enum`
  - `before_validation` cleanup of an attribute → `normalizes`
