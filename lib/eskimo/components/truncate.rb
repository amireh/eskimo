# frozen_string_literal: true

module Eskimo
  module Components
    # Truncate text from the beginning if it exceeds a certain width.
    #
    #     Truncate.new(width: 3) do
    #       "foo bar"
    #     end
    #     # => "... bar"
    class Truncate < Component
      attr_reader :maxlen

      def initialize(reserve: 0, width: Constants::SCREEN_COLUMNS, &children)
        @maxlen = [0, width - reserve].max

        super
      end

      def render(**)
        text = super

        if text.length >= maxlen
          '...' + text[text.length - maxlen - 1 .. -1]
        else
          text
        end
      end
    end
  end
end
