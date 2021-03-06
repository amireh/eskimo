# frozen_string_literal: true

require 'eskimo/ascii/components/truncate'

module Eskimo::ASCII
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
end
