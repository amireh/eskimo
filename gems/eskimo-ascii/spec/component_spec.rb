# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::Component do
  it 'accepts a block of children' do
    expect(
      Eskimo::Core::Renderer.new.apply {
        Eskimo::ASCII::Component.new { ['hello', "\n", 'world!'] }
      }
    ).to eq("hello\nworld!")
  end

  it 'provides a pastel for giggles' do
    expect(
      Eskimo::ASCII::Component.new.send(:pastel)
    ).to be_a(Pastel::Delegator)
  end
end
