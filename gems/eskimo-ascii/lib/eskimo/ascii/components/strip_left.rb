# frozen_string_literal: true

module Eskimo::ASCII
  # Remove whitespace from the beginning.
  #
  #     StripLeft.new { "  hello world  " }
  #     # => "hello world  "
  class StripLeft < Component
    def render(**)
      super.lstrip
    end
  end
end
