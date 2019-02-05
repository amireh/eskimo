# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::Gutter do
  it 'prepends each line with the character' do
    expect(
      renderer.apply do
        ESK::Gutter.new(char: '| ') do
          "hello\nworld"
        end
      end
    ).to eq("| hello\n| world")
  end
end
