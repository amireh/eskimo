# frozen_string_literal: true


module Eskimo
  module Components
    module HTML
      TAGS = %w[
        a abbr address area article aside audio b base bdi bdo blockquote body
        br button canvas caption cite code col colgroup data datalist dd del
        details dfn dialog div dl dt em embed fieldset figcaption figure footer
        form h1 h2 h3 h4 h5 h6 head header hgroup hr i iframe img input ins kbd
        keygen label legend li link main map mark math menu menuitem meta meter
        nav noscript object ol optgroup option output p param picture pre
        progress q rb rp rt rtc ruby s samp script section select slot small
        source span strong style sub summary sup svg table tbody td template
        textarea tfoot th thead time title tr track u ul var video wbr
      ]

      class HTMLElement < Component
        ATTRIBUTE_REWRITES = {
          'className' => 'class'
        }

        attr_reader :children
        attr_reader :tag_name
        attr_reader :attributes

        def initialize(attributes = {}, &children)
          @attributes = attributes

          super
        end

        def render(**)
          tag_with_attributes = "#{tag_name} #{serialize_attributes}"

          "<#{tag_with_attributes.strip}>#{super}</#{tag_name}>"
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

      class Html < HTMLElement
        def initialize(doctype: 'html', **)
          @doctype = doctype
          @tag_name = 'html'
          super
          @attributes.delete(:doctype)
        end

        def render(**)
          if @doctype.to_s.empty?
            super
          else
            "<!DOCTYPE #{@doctype}>\n" + super
          end
        end
      end

      TAGS.each do |tag|
        eval <<~RUBY
          class #{tag.capitalize} < HTMLElement
            def tag_name
              "#{tag}"
            end
          end
        RUBY
      end
    end
  end
end
