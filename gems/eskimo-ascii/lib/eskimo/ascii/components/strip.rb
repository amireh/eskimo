# frozen_string_literal: true

# Remove surrounding whitespace.
#
#     Strip.new { "  hello world  " }
#     # => "hello world"
class Eskimo::ASCII::Strip < Eskimo::ASCII::Component
  def render(**)
    super.strip
  end
end
