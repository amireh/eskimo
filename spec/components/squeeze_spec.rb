# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::Squeeze do
  it 'swallows consecutive newlines' do
    expect(
      renderer.apply do
        ESK::Squeeze.new([
          ESK::SoftBreak.new,
          false && '1',

          ESK::SoftBreak.new,
          false && '2',

          ESK::SoftBreak.new,
          '3',

          ESK::SoftBreak.new,
          '4',
        ])
      end
    ).to eq("\n3\n4")
  end

  it 'does not swallow consecutive newlines in inner children' do
    expect(
      renderer.apply do
        ESK::Squeeze.new([
          ESK::Indent.new(width: 0) do
            [
              ESK::SoftBreak.new,
              false && '1',

              ESK::SoftBreak.new,
              false && '2',

              ESK::SoftBreak.new,
              '3',

              ESK::SoftBreak.new,
              '4',
            ]
          end
        ])
      end
    ).to eq("\n\n\n3\n4")
  end

  it 'bails if not given an array of children' do
    expect { ESK::Squeeze.new('') }.to raise_error(ArgumentError,
      "Squeeze works only with an Array of components"
    )
  end

  it 'bails if given a block' do
    expect { ESK::Squeeze.new([]) {} }.to raise_error(ArgumentError,
      "Squeeze works only with an Array of components"
    )
  end
end
