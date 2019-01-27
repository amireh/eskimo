# frozen_string_literal: true

module Eskimo
  module Components
    # Insert a paragraph-like line-break.
    #
    #     [ "Hello", LineBreak.new, "World!" ]
    #     # => "Hello"
    #     #    ""
    #     #    ""
    #     #    "World!"
    class LineBreak
      def render(**)
        "\n \n"
      end
    end
  end
end
