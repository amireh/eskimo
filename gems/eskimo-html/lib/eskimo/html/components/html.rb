# frozen_string_literal: true

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
