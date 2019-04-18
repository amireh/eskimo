# frozen_string_literal: true

# Remove whitespace from the beginning.
#
#     StripLeft.new { "  hello world  " }
#     # => "hello world  "
class Eskimo::ASCII::StripLeft < Eskimo::ASCII::Component
  def render(**)
    super.lstrip
  end
end
