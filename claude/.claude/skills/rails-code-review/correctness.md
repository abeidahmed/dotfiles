# Correctness checklist

Bugs to hunt in a Rails diff. A finding names the input or state that triggers it and the wrong result: an exception, a wrong value, lost or duplicated data, or a security hole. Trace it through the code; mark what you cannot trace end to end as Possible.

## Missing and empty data

- `find` where the record may be gone, outside a controller's 404 path (it raises), or a `find_by`/`first` result used without a nil check.
- `&.` chains that turn a missing record into a silently wrong answer.
- Blank, missing or unexpected params; empty collections reaching `max`, `min`, averages or division.

## Queries

- N+1: associations read in a loop or partial without `includes` or `preload`.
- Unbounded loads: `all`, `each` or `map` over a table that grows; use `find_each` or a limit.
- Scope leaks: a query missing the tenant, owner or soft-delete filter the rest of the code applies; an unscoped `find` on an id from params (IDOR).
- `or`, `merge`, `unscope` or `rewhere` changing more conditions than intended.

## Writes and integrity

- `save` or `update` whose false return is ignored; use the bang version or handle it.
- Uniqueness or presence enforced only by a validation, with no database constraint, so concurrent requests slip past.
- `update_all`, `update_columns`, `insert_all` or `delete_all` skipping callbacks, validations or timestamps the code relies on.
- Counters or balances computed read-then-write instead of atomically (`update_counters`, a row lock, a single `UPDATE`).

## Transactions and side effects

- Mail, HTTP calls, cache writes, or jobs on a queue outside the database, issued inside a transaction: they fire even when it rolls back, and hold locks while slow. Move them after commit, unless the app already defers job enqueues (Active Job's `enqueue_after_transaction_commit`).
- A `rescue` inside a transaction block that swallows the error, so a partial write commits.
- Callbacks with side effects that fire on every save, including imports, loops and retries.

## Retries and concurrency

- Jobs that are not safe to run twice (retries, duplicate enqueues).
- Double submits creating duplicates; `find_or_create_by` without a unique index behind it.

## Security

- A new controller action or endpoint without an authorization check.
- Params permitted too broadly (`permit!`, role, owner or price fields): mass assignment.
- SQL built by string interpolation; `html_safe` or `raw` on user input; `redirect_to` a param.
- Sensitive data in logs, URLs or error messages.

## Time and money

- `Date.today` or `Time.now` in an app that uses `Time.zone` (`Date.current`, `Time.current`); date math across DST changes or month ends.
- Floats for money; rounding applied more than once.

## Migrations

- On PostgreSQL, an index added without `algorithm: :concurrently`; on any database, a backfill or `NOT NULL` change on a large table, inside one locking migration.
- A column renamed or removed while the running code still reads it during the deploy.
- Data changes mixed into a schema migration; a `change` method that cannot be reversed.
