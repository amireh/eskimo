# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::StripLeft do
  it 'strips whitespace from the head' do
    expect(
      renderer.apply do
        ESK::StripLeft.new do
          "  hello world  "
        end
      end
    ).to eq("hello world  ")
  end
end
