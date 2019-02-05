# frozen_string_literal: true

module Eskimo
  module Components
    # Space consecutive components with soft breaks.
    #
    #     Spacer.new([
    #       "Hello",
    #       "World!"
    #     ])
    #     # => "Hello"
    #     #    "World!"
    #
    # The soft breaks for each conditional component will be preserved only
    # if they do render some content.
    class Spacer
      def initialize(children)
        if !children.is_a?(Array) || block_given?
          raise ArgumentError.new("Spacer works only with an Array of components")
        end

        @children = children
      end

      def render(**props)
        rendered = @children.map(&props[:render])

        without_blanks = rendered.reject(&:empty?)
        without_blanks.join("\n")
      end
    end
  end
end
