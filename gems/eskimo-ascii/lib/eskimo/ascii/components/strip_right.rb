# frozen_string_literal: true

# Remove whitespace from the end.
#
#     StripRight.new { "  hello world  " }
#     # => "  hello world"
class Eskimo::ASCII::StripRight < Eskimo::ASCII::Component
  def render(**)
    super.rstrip
  end
end
