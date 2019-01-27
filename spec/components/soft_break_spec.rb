# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::SoftBreak do
  it 'inserts a soft linebreak' do
    expect(
      renderer.apply {
        [
          'hello',
          ESK::SoftBreak.new,
          'world'
        ]
      }
    ).to eq("hello\nworld")
  end
end
