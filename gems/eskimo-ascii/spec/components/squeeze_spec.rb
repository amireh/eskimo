# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::Squeeze do
  it 'swallows consecutive newlines' do
    expect(
      renderer.apply do
        Eskimo::ASCII::Squeeze.new([
          Eskimo::ASCII::SoftBreak.new,
          false && '1',

          Eskimo::ASCII::SoftBreak.new,
          false && '2',

          Eskimo::ASCII::SoftBreak.new,
          '3',

          Eskimo::ASCII::SoftBreak.new,
          '4',
        ])
      end
    ).to eq("\n3\n4")
  end

  it 'does not swallow consecutive newlines in inner children' do
    pending "not sure why it's broken but it is"

    expect(
      renderer.apply do
        Eskimo::ASCII::Squeeze.new([
          Eskimo::ASCII::Indent.new(width: 0) do
            [
              Eskimo::ASCII::SoftBreak.new,
              false && '1',

              Eskimo::ASCII::SoftBreak.new,
              false && '2',

              Eskimo::ASCII::SoftBreak.new,
              '3',

              Eskimo::ASCII::SoftBreak.new,
              '4',
            ]
          end
        ])
      end.tap do |x| debugger end
    ).to eq("\n\n\n3\n4")
  end

  it 'bails if not given an array of children' do
    expect { Eskimo::ASCII::Squeeze.new('') }.to raise_error(ArgumentError,
      "Squeeze works only with an Array of components"
    )
  end

  it 'bails if given a block' do
    expect { Eskimo::ASCII::Squeeze.new([]) {} }.to raise_error(ArgumentError,
      "Squeeze works only with an Array of components"
    )
  end
end
