# frozen_string_literal: true

# Style text with colors and custom formatting.
#
# See [Pastel's documentation][pastel] for the accepted styles.
#
# [pastel]: https://github.com/piotrmurach/pastel
class Eskimo::ASCII::Style < Eskimo::ASCII::Component
  attr_reader :pastel, :style

  def initialize(*style, &children)
    @style = style.flatten
    @pastel = Pastel.new

    super
  end

  def render(**)
    pastel.decorate(super, *style)
  end
end
