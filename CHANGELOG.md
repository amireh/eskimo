## 2.2.0

Same contents as 2.1.2 but version was bumped for semver since a new dependency
was introduced.

## 2.1.2

Added an explicit dependency on the `did_you_mean` gem for Ruby installations
that do not have it.

## 2.1.1

Added an explicit `require` statement for DidYouMean since on some environments
it was raising an uninitialized constant error.

## 2.1.0

- Added a Gutter component
- Added a Spacer component

## 2.0.0

- **BREAKING** Indent no longer performs an `rstrip` on its contents.
  Wrap with `StripRight` if you need the previous behavior.
- Added accompanying components to `Strip`: `StripLeft` and `StripRight`
- Added component `Squeeze`
- Slightly improved the performance of the rendering routine
- Added component `DidYouMean`
- Added component `Either`
- Added component `Highlight`
- Added component `HighlightColumn`
