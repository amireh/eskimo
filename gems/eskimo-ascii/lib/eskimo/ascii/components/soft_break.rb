# frozen_string_literal: true

# Insert a soft line-break.
#
#     [ "Hello", SoftBreak.new, "World!" ]
#     # => "Hello"
#     #    "World!"
class Eskimo::ASCII::SoftBreak
  def render(**)
    "\n"
  end
end
