# frozen_string_literal: true

module Eskimo
  module Components
    SCREEN_COLUMNS = [TTY::Screen.width, 72].min

    # Indent text from the left.
    #
    #     Indent.new(width: 8) do
    #       [ "Hello", SoftBreak.new, "World!" ]
    #     end
    #     # => "        Hello"
    #     #    "        World!"
    class Indent < Component
      attr_reader :width

      def initialize(width: 4, &children)
        @width = width
        super
      end

      def render(**)
        Strings.pad(super, [0,0,0,width])
      end
    end

    # Insert a paragraph-like line-break.
    #
    #     [ "Hello", LineBreak.new, "World!" ]
    #     # => "Hello"
    #     #    ""
    #     #    ""
    #     #    "World!"
    class LineBreak
      def render(**)
        "\n \n"
      end
    end

    # Insert a soft line-break.
    #
    #     [ "Hello", SoftBreak.new, "World!" ]
    #     # => "Hello"
    #     #    "World!"
    class SoftBreak
      def render(**)
        "\n"
      end
    end

    # Remove surrounding whitespace.
    #
    #     Strip.new { "  hello world  " }
    #     # => "hello world"
    class Strip < Component
      def render(**)
        super.strip
      end
    end

    # Remove whitespace from the beginning.
    #
    #     StripLeft.new { "  hello world  " }
    #     # => "hello world  "
    class StripLeft < Component
      def render(**)
        super.lstrip
      end
    end

    # Remove whitespace from the end.
    #
    #     StripRight.new { "  hello world  " }
    #     # => "  hello world"
    class StripRight < Component
      def render(**)
        super.rstrip
      end
    end

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
        @children = children
      end

      def render(**props)
        rendered = @children.map(&props[:render])

        without_blanks = rendered.reject(&:empty?)
        without_blanks.reject.with_index do |element, index|
          element == "\n" && without_blanks[index+1] == "\n"
        end
      end

      private

      def array_of(x)
        x.is_a?(Array) ? x : [x]
      end
    end

    # Style text with colors and custom formatting.
    #
    # See [Pastel's documentation][pastel] for the accepted styles.
    #
    # [pastel]: https://github.com/piotrmurach/pastel
    class Style < Component
      attr_reader :pastel, :style

      def initialize(*style, &children)
        @style = style.flatten
        @pastel = Pastel.new

        super
      end

      def render(**)
        pastel.decorate(super, *style)
      end
    end

    # Truncate text from the beginning if it exceeds a certain width.
    #
    #     Truncate.new(width: 3) do
    #       "foo bar"
    #     end
    #     # => "... bar"
    class Truncate < Component
      attr_reader :maxlen

      def initialize(reserve: 0, width: SCREEN_COLUMNS, &children)
        @maxlen = [0, width - reserve].max

        super
      end

      def render(**)
        text = super

        if text.length >= maxlen
          '...' + text[text.length - maxlen - 1 .. -1]
        else
          text
        end
      end
    end

    # Truncate text from the rear if it exceeds a certain width.
    #
    #     TruncateRear.new(width: 3) do
    #       "foo bar"
    #     end
    #     # => "foo..."
    class TruncateRear < Truncate
      def render(render:, **)
        text = render[@children]

        if text.length >= maxlen
          text[0..maxlen - 1] + '...'
        else
          text
        end
      end
    end

    # Wrap a block text with newlines at a certain threshold.
    #
    #     Wrap.new(width: 3) do
    #       "foobar"
    #     end
    #     # => "foo"
    #     #    "bar"
    #
    class Wrap < Component
      attr_reader :width

      def initialize(width: SCREEN_COLUMNS, &children)
        @width = width
        super
      end

      def render(**)
        Strings.wrap(super, width)
      end
    end
  end
end
