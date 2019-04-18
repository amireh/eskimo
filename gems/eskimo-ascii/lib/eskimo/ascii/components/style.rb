# frozen_string_literal: true

module Eskimo::ASCII
  # Style text with colors and custom formatting.
  #
  # See [Pastel's documentation][pastel] for the accepted styles.
  #
  # [pastel]: https://github.com/piotrmurach/pastel
  class Style < Component
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
end
