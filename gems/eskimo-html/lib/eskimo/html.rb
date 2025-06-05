require 'eskimo/html/version'
require 'eskimo/html/util'
require 'eskimo/html/component'
require 'eskimo/html/builder'

module Eskimo
  module HTML
    TAGS = %w[
      a abbr address area article aside audio b base bdi bdo blockquote body
      br button canvas caption cite code col colgroup data datalist dd del
      details dfn dialog div dl dt em embed fieldset figcaption figure footer
      form h1 h2 h3 h4 h5 h6 head header hgroup hr html i iframe img input ins
      kbd keygen label legend li link main map mark math menu menuitem meta
      meter nav noscript object ol optgroup option output p param picture pre
      progress q rb rp rt rtc ruby s samp script section select slot small
      source span strong style sub summary sup svg table tbody td template
      textarea tfoot th thead time title tr track u ul var video wbr
    ]

    # ref: <https://developer.mozilla.org/en-US/docs/Glossary/Void_element>
    VOID_TAGS = %w[
      area base br col embed hr img input link meta param source track wbr
    ]

    def self.valid_tagname?(tagname)
      TAGS.include?(tagname) || tagname == 'html'
    end
  end
end

(Eskimo::HTML::TAGS - %w[ html ]).each do |tag_name|
  Eskimo::HTML::Component.define!(tag_name)
end

class Eskimo::HTML::Html < Eskimo::HTML::Component
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
