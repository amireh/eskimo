# Eskimo development guide

To install the dependencies of each gem:

    bin/bundle

---

To run RSpec against all the gems:

    bin/rspec

Coverage is aggregated in `./coverage`. View at `coverage/index.html`.

---

To generate the documentation:

    bin/yard

View at `./docs/index.html`.

---

To bump the version

    bin/gem-bump x.y.z

Verify changes in git, if they look good, then go to each `gems/*/*.gemspec`
and manually edit the runtime dependencies to point to the __exact__ version
you've bumped to.

To release:

    bin/gem-release

