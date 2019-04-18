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

All gems have the same version and have an exact (`=`) dependency on other
`eskimo-` gems.

Verify changes in git, if they look good, then release:

    bin/gem-release

