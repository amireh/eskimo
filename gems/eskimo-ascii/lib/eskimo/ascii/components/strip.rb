# frozen_string_literal: true

module Eskimo::ASCII
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
