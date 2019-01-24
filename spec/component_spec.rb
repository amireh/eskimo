# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Component do
  it 'accepts a block of children' do
    expect(
      Eskimo::Renderer.new.apply {
        Eskimo::Component.new { ['hello', "\n", 'world!'] }
      }
    ).to eq("hello\nworld!")
  end
end
