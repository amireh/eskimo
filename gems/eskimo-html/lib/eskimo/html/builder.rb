# frozen_string_literal: true

module Eskimo
  module HTML
    class Builder
      def self.method_missing(method, *params, &block)
        return super unless Eskimo::HTML.valid_tagname?(method.to_s)

        attrs, children = case params.count
        when 0
          [nil, nil]
        when 1
          if params[0].is_a?(Hash)
            [attrs, nil]
          else
            [nil, Proc.new { params[0] }]
          end
        when 2
          [params[0], Proc.new { params[1] }]
        end

        Eskimo::HTML::Component.tag(method.to_s, attrs, &children)
      end
    end
  end
end
