# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::Spacer do
  it 'inserts newlines between components' do
    expect(
      renderer.apply do
        ESK::Spacer.new([
          "Hello",
          "World!"
        ])
      end
    ).to eq("Hello\nWorld!")
  end

  it 'ignores falsey components' do
    expect(
      renderer.apply do
        ESK::Spacer.new([
          "Hello",
          false && 'hi',
          false && 'ho',
          "World!",
          false && 'yup'
        ])
      end
    ).to eq("Hello\nWorld!")
  end

  it 'bails if not given an array of children' do
    expect { ESK::Spacer.new('') }.to raise_error(ArgumentError,
      "Spacer works only with an Array of components"
    )
  end

  it 'bails if given a block' do
    expect { ESK::Spacer.new([]) {} }.to raise_error(ArgumentError,
      "Spacer works only with an Array of components"
    )
  end
end
