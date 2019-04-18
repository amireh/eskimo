# frozen_string_literal: true

module Eskimo::ASCII
  # Remove whitespace from the end.
  #
  #     StripRight.new { "  hello world  " }
  #     # => "  hello world"
  class StripRight < Component
    def render(**)
      super.rstrip
    end
  end
end
