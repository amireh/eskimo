# frozen_string_literal: true

# Prepend each line with a character or symbol.
#
#     Gutter.new(char: '| ') do
#       [ "Hello", "\n", "World!" ]
#     end
#     # => "| Hello"
#     #    "| World!"
class Eskimo::ASCII::Gutter < Eskimo::ASCII::Component
  attr_reader :char, :spacing

  def initialize(char:, spacing: 0, &children)
    @char = char
    @spacing = spacing

    super
  end

  def render(**)
    spacer = Array.new(spacing, char)

    [
      *spacer,
      super.lines.map { |s| s.prepend(char) }.join,
      *spacer
    ].join("\n")
  end
end
