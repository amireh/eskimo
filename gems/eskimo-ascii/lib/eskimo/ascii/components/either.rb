# frozen_string_literal: true

# Render a fallback component in case the first one evaluates to an empty
# String.
#
#     Either.new(->(**) { false }, "Fallback here")
#     # => "Fallback here"
#
#     Either.new(->(**) { "Hi!" }, "Fallback here")
#     # => "Hi!"
#
class Eskimo::ASCII::Either
  attr_reader :children

  def initialize(primary, fallback)
    @children = [ primary, fallback ]
  end

  def render(render:, **)
    for child in children do
      rendered = render[child]

      return rendered unless rendered.empty?
    end
  end
end
