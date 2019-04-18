# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::StripLeft do
  it 'strips whitespace from the head' do
    expect(
      renderer.apply do
        Eskimo::ASCII::StripLeft.new do
          "  hello world  "
        end
      end
    ).to eq("hello world  ")
  end
end
