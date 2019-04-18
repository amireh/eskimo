# frozen_string_literal: true

module Eskimo::ASCII
  # Insert a soft line-break.
  #
  #     [ "Hello", SoftBreak.new, "World!" ]
  #     # => "Hello"
  #     #    "World!"
  class SoftBreak
    def render(**)
      "\n"
    end
  end
end
