# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::LineBreak do
  it 'inserts a hard linebreak' do
    expect(
      renderer.apply {
        [
          'hello',
          Eskimo::ASCII::LineBreak.new,
          'world'
        ]
      }
    ).to eq("hello\n \nworld")
  end
end
