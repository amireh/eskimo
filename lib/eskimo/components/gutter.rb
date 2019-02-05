# frozen_string_literal: true

module Eskimo
  module Components
    # Prepend each line with a character or symbol.
    #
    #     Gutter.new(char: '| ') do
    #       [ "Hello", "\n", "World!" ]
    #     end
    #     # => "| Hello"
    #     #    "| World!"
    class Gutter < Component
      attr_reader :char

      def initialize(char:, &children)
        @char = char
        super
      end

      def render(**)
        super.lines.map { |s| s.prepend(char) }.join
      end
    end
  end
end
