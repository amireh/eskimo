# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::Gutter do
  it 'prepends each line with the character' do
    expect(
      renderer.apply do
        Eskimo::ASCII::Gutter.new(char: '| ') do
          "hello\nworld"
        end
      end
    ).to eq("| hello\n| world")
  end

  it 'inserts surrounding whitespace' do
    expect(
      renderer.apply do
        Eskimo::ASCII::Gutter.new(char: '| ', spacing: 2) do
          "hello\nworld"
        end
      end
    ).to eq("| \n| \n| hello\n| world\n| \n| ")
  end
end
