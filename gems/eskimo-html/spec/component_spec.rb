# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::HTML::Component do
  it 'accepts a block of children' do
    class CustomComponent < Eskimo::HTML::Component
      def tag_name
        'foo'
      end
    end

    expect(
      Eskimo::Core::Renderer.new.apply {
        CustomComponent.new { 'hello world!' }
      }
    ).to eq("<foo>hello world!</foo>")
  end
end
