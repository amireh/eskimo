# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::Wrap do
  it 'wraps text' do
    expect(
      renderer.apply do
        Eskimo::ASCII::Wrap.new(width: 5) do
          'hello world'
        end
      end
    ).to eq("\nhello \nworld")
  end

  it 'defaults to the screen width' do
    expect(
      renderer.apply do
        Eskimo::ASCII::Wrap.new do
          'hello world'
        end
      end
    ).to eq("hello world")
  end
end
