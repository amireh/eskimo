# frozen_string_literal: true

module Eskimo
  module Components
    # Squeeze immediate consecutive soft breaks.
    #
    #     Squeeze.new do
    #       [
    #         SoftBreak.new,
    #         ConditionalComponent.new,
    #
    #         SoftBreak.new,
    #         false && SomeOtherComponent.new,
    #
    #         SoftBreak.new,
    #         'hello',
    #       ]
    #      end
    #      # => ""
    #      #    "hello"
    #
    # The soft breaks for each conditional component will be preserved only
    # if they do render some content.
    class Squeeze
      def initialize(children)
        if !children.is_a?(Array) || block_given?
          raise ArgumentError.new("Squeeze works only with an Array of components")
        end

        @children = children
      end

      def render(**props)
        rendered = @children.map(&props[:render])

        without_blanks = rendered.reject(&:empty?)
        without_blanks.reject.with_index do |element, index|
          element == "\n" && without_blanks[index+1] == "\n"
        end
      end
    end
  end
end
