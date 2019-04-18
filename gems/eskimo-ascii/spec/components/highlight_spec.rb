# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::Highlight do
  it 'styles a substring' do
    style = [ :bold, :red ]

    expect(
      renderer.apply {
        described_class.new(pattern: /ou/, style: style) { 'four' }
      }
    ).to eq("f#{Pastel.new.decorate('ou', *style)}r")
  end

  it 'is a no-op if no match' do
    input = 'four'

    expect(
      renderer.apply {
        described_class.new(pattern: /asdf/) { input }
      }
    ).to eq(input)
  end
end
