# frozen_string_literal: true

# A base component class that renders child components defined in a block into
# a String for further formatting.
#
#     class MyComponent < Eskimo::ASCII::Component
#       def render(**)
#         text = super
#         text.is_a?(String) # => true
#       end
#     end
#
# Use of this class is optional. What's happening under the hood is:
#
# 1. Component maintains a reference to the Proc passed to {#initialize}. That
#    Proc can potentially return a list of child components to render.
#
# 2. {Component#render} (called via "super" from sub-classes) invokes the
#    `render` prop provided by {Core::Renderer#apply} with the tracked children
#    which converts them to a String and returns them.
class Eskimo::ASCII::Component
  def initialize(*, **, &children_gen)
    @children = children_gen
  end

  def render(render:, **)
    render[@children]
  end

  protected

  def pastel
    @pastel ||= Pastel.new
  end
end
