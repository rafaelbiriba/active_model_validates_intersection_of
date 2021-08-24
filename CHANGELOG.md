## v3.0.1 (2021-08-24)

- Fixing model validation when the value is nil (eg: list = `[nil]` model.valid? should be false). (From issue: #9)

## v3.0.0 (2021-04-13)

- Ruby 3 support.

## v1.2.0 (2017-12-20)

  - Support for proc and lambda

## v1.1.0 (2017-06-06)

  - Implement `validates :list, intersection: { in: ANOTHER_LIST }` see the README for more information

## v1.0.0 (2017-06-06)

  - Release 1.0 version
  - Add `:within` parameter support as an alias for `:in`

## v0.1.0 (2017-06-01)

  - Initial release
