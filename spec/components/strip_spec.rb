# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::Strip do
  it 'strips surrounding whitespace' do
    expect(
      renderer.apply do
        ESK::Strip.new do
          "  hello world  "
        end
      end
    ).to eq("hello world")
  end
end
