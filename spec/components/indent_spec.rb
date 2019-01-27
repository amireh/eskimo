# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::Indent do
  it 'indents each line' do
    expect(
      renderer.apply do
        ESK::Indent.new(width: 2) do
          "hello\nworld"
        end
      end
    ).to eq("  hello\n  world")
  end
end
