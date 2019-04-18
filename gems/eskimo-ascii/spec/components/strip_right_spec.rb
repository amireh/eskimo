# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::StripRight do
  it 'strips whitespace from the rear' do
    expect(
      renderer.apply do
        Eskimo::ASCII::StripRight.new do
          "  hello world  "
        end
      end
    ).to eq("  hello world")
  end
end
