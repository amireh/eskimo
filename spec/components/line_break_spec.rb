# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::LineBreak do
  it 'inserts a hard linebreak' do
    expect(
      renderer.apply {
        [
          'hello',
          ESK::LineBreak.new,
          'world'
        ]
      }
    ).to eq("hello\n \nworld")
  end
end
