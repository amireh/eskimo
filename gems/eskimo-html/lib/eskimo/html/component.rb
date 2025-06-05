# frozen_string_literal: true

module Eskimo::HTML
  # Base HTMLElement component which takes a {tag_name}, a set of {attributes},
  # and optionally a set of {children} and turns them into a beautiful --
  # believe it or not -- HTML tag:
  #
  #     <x-foo <!-- attributes -->>
  #       <!-- children -->
  #     </x-foo>
  #
  # See {ASCII::Component} for how this works under the hood since it's similar.
  class Component
    BLANK_ATTRIBUTES = {}.freeze

    # Mapping of Ruby attribute name to HTML attribute name; some words like
    # "class" are reserved and are problematic when passed as attributes so this
    # hash supports a method to rewrite those.
    ATTRIBUTE_REWRITES = {
      'className' => 'class'
    }

    attr_reader :attributes
    attr_reader :children
    attr_reader :tag_name
    attr_reader :void

    def self.tag(tag_name, attrs, &children)
      new(attrs, &children).tap do |component|
        component.instance_variable_set(:@tag_name, tag_name)
        component.instance_variable_set(:@void, Eskimo::HTML::VOID_TAGS.include?(tag_name))
      end
    end

    def self.define!(tag_name)
      eval <<~RUBY
        class Eskimo::HTML::#{tag_name.capitalize} < Eskimo::HTML::Component
          def tag_name
            "#{tag_name}".freeze
          end

          def void
            @void = Eskimo::HTML::VOID_TAGS.include?(tag_name) if @void.nil?
            @void
          end
        end
      RUBY
    end

    def initialize(attributes = nil, &children)
      @attributes = attributes || BLANK_ATTRIBUTES
      @children = children
    end

    def render(render:, **)
      safe_tag_name = Eskimo::HTML::Util.xml_name_escape(tag_name)
      tag_with_attributes = "#{safe_tag_name} #{serialize_attributes}".strip

      if void
        "<#{tag_with_attributes} />"
      else
        "<#{tag_with_attributes}>#{render[@children]}</#{safe_tag_name}>"
      end
    end

    def serialize_attributes
      attributes.map do |(k, v)|
        k = ATTRIBUTE_REWRITES.fetch(k.to_s, k.to_s)

        case v
        when true
          "#{k}=\"#{k}\""
        when false
        else
          "#{k}=\"#{ERB::Util.html_escape(v)}\""
        end
      end.join(' ')
    end

    private :serialize_attributes
    private_constant :BLANK_ATTRIBUTES
  end
end
