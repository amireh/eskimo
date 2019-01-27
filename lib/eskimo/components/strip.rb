# frozen_string_literal: true

module Eskimo
  module Components
    # Remove surrounding whitespace.
    #
    #     Strip.new { "  hello world  " }
    #     # => "hello world"
    class Strip < Component
      def render(**)
        super.strip
      end
    end
  end
end
