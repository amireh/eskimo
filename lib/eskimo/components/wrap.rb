# frozen_string_literal: true

module Eskimo
  module Components
    # Wrap a block text with newlines at a certain threshold.
    #
    #     Wrap.new(width: 3) do
    #       "foobar"
    #     end
    #     # => "foo"
    #     #    "bar"
    #
    class Wrap < Component
      attr_reader :width

      def initialize(width: Constants::SCREEN_COLUMNS, &children)
        @width = width
        super
      end

      def render(**)
        Strings.wrap(super, width)
      end
    end
  end
end
