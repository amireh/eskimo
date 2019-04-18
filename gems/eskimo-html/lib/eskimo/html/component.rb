# frozen_string_literal: true

# Base HTMLElement component which takes a {tag_name}, a set of {attributes},
# and optionally a set of {children} and turns them into a beautiful -- believe
# it or not -- HTML tag:
#
#     <x-foo <!-- attributes -->>
#       <!-- children -->
#     </x-foo>
#
# See {ASCII::Component} for how this works under the hood since it's similar.
class Eskimo::HTML::Component
  # Mapping of Ruby attribute name to HTML attribute name; some words like
  # "class" are reserved and are problematic when passed as attributes so this
  # hash supports a method to rewrite those.
  ATTRIBUTE_REWRITES = {
    'className' => 'class'
  }

  attr_reader :attributes
  attr_reader :children
  attr_reader :tag_name

  def initialize(attributes = {}, &children)
    @attributes = attributes
    @children = children
  end

  def render(render:, **)
    tag_with_attributes = "#{tag_name} #{serialize_attributes}"

    "<#{tag_with_attributes.strip}>#{render[@children]}</#{tag_name}>"
  end

  private

  def serialize_attributes
    attributes.map do |(k, v)|
      k = ATTRIBUTE_REWRITES.fetch(k.to_s, k.to_s)

      case v
      when true
        "#{k}=\"#{k}\""
      when false
      else
        "#{k}=\"#{v}\""
      end
    end.join(' ')
  end
end
