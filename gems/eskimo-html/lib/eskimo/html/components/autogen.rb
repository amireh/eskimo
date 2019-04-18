# frozen_string_literal: true

require 'eskimo/html/autogen_tags'

Eskimo::HTML::AUTOGEN_TAGS.each do |tag|
  eval <<~RUBY
    class Eskimo::HTML::#{tag.capitalize} < Eskimo::HTML::Component
      def tag_name
        "#{tag}"
      end
    end
  RUBY
end
