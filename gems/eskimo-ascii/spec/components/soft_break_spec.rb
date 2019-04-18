# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::SoftBreak do
  it 'inserts a soft linebreak' do
    expect(
      renderer.apply {
        [
          'hello',
          Eskimo::ASCII::SoftBreak.new,
          'world'
        ]
      }
    ).to eq("hello\nworld")
  end
end
