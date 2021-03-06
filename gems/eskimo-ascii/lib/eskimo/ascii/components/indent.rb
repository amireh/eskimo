# frozen_string_literal: true

module Eskimo::ASCII
  # Indent text from the left.
  #
  #     Indent.new(width: 8) do
  #       [ "Hello", SoftBreak.new, "World!" ]
  #     end
  #     # => "        Hello"
  #     #    "        World!"
  class Indent < Component
    attr_reader :width

    def initialize(width: 4, &children)
      @width = width
      super
    end

    def render(**)
      Strings.pad(super, [0,0,0,width])
    end
  end
end
