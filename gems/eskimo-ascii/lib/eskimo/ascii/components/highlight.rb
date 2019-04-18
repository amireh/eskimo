# frozen_string_literal: true

# Highlight a substring with ASCII arrows.
#
#    Highlight.new(pattern: /lol/) do
#      "- include: lol://file.yml"
#    end
#    # => "- include: lol://file.yml"
#    #                ^^^
#
class Eskimo::ASCII::Highlight < Eskimo::ASCII::Component
  attr_reader :pastel, :pattern, :style

  def initialize(pattern:, style: [:red, :bold, :underline], &children)
    @pastel = Pastel.new
    @pattern = pattern
    @style = style

    super(&children)
  end

  def render(**)
    super.sub(pattern) do |substring|
      pastel.decorate(substring, *style)
    end
  end
end
