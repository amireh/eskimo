## 3.0.0

This release introduces a new set of components for HTML rendering allowing for
Eskimo to be used in HTML templating engines like ERB.

In light of this change, the previous gem setup stopped holding up because the
dependencies of the original `eskimo` gem are exclusive to ASCII rendering and
make no sense in the HTML context. For this reason, `eskimo` has been broken
down into the following gems:

- `eskimo-core` containing the renderer
- `eskimo-ascii` containing the ASCII components (which were previously in
  `Eskimo::Components`)
- `eskimo-html` sibling to `eskimo-ascii` but for HTML

The `eskimo` gem is now a meta-gem (similar to `rspec`) that pulls in
`eskimo-core` and `eskimo-ascii`. This is meant to help users of 2.x in the
upgrade.

Changes:

- Lowered Ruby engine requirement to 2.4 down from 2.5.1
- (BREAKING) Removed explicit dependency on `did_you_mean` because it's not
  available for engines < 2.5 -- if you're using Ruby 2.5+ in a platform that
  doesn't have it (like Alpine Linux), please it install manually alongside of
  Eskimo
- (BREAKING) `Eskimo::Renderer` is now `Eskimo::Core::Renderer`
- (BREAKING) `Eskimo::Components::*` are now in `Eskimo::ASCII`

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
