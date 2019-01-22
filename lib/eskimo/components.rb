# frozen_string_literal: true

module Eskimo
  module Components
    SCREEN_COLUMNS = [TTY::Screen.width, 72].min

    # Indent text from the left.
    class Indent < Component
      attr_reader :width

      def initialize(width: 4, &children)
        @width = width
        super(&children)
      end

      def render(**)
        Strings.pad(super, [0,0,0,width]).rstrip
      end
    end

    # Insert a hard line-break (paragraph-like.)
    class LineBreak
      def render(**)
        "\n \n"
      end
    end

    # Insert a soft line-break.
    class SoftBreak
      def render(**)
        "\n"
      end
    end

    # Strip text of surrounding whitespace.
    class Strip < Component
      def render(**)
        super.strip
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

        super(&children)
      end

      def render(**)
        pastel.decorate(super, *style)
      end
    end

    # Truncate text from the beginning if it exceeds a certain width.
    #
    #     ...bar
    class Truncate < Component
      attr_reader :maxlen

      def initialize(reserve: 0, width: SCREEN_COLUMNS, &children)
        @maxlen = [0, width - reserve].max

        super(&children)
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
    #     foo...
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
    class Wrap < Component
      attr_reader :width

      def initialize(width: SCREEN_COLUMNS, &children)
        @width = width
        super(&children)
      end

      def render(**)
        Strings.wrap(super, width)
      end
    end
  end
end
