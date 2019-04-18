# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::HTML::Component do
  class CustomComponent < Eskimo::HTML::Component
    def tag_name
      'foo'
    end
  end

  it 'accepts a block of children' do
    expect(
      Eskimo::Core::Renderer.new.apply {
        CustomComponent.new { 'hello world!' }
      }
    ).to eq("<foo>hello world!</foo>")
  end

  it 'sets attribute="attribute" if its value is "true"' do
    expect(
      Eskimo::Core::Renderer.new.apply {
        CustomComponent.new(disabled: true) { 'hello world!' }
      }
    ).to eq("<foo disabled=\"disabled\">hello world!</foo>")
  end

  it 'omits attribute="attribute" if its value is "false"' do
    expect(
      Eskimo::Core::Renderer.new.apply {
        CustomComponent.new(disabled: false) { 'hello world!' }
      }
    ).to eq("<foo>hello world!</foo>")
  end
end
