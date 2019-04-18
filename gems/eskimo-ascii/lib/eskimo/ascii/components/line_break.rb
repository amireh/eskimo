# frozen_string_literal: true

# Insert a paragraph-like line-break.
#
#     [ "Hello", LineBreak.new, "World!" ]
#     # => "Hello"
#     #    ""
#     #    ""
#     #    "World!"
class Eskimo::ASCII::LineBreak
  def render(**)
    "\n \n"
  end
end
