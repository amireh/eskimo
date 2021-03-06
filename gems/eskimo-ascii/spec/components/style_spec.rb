# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::Style do
  it 'applies ANSI styling to text' do
    expect(
      renderer.apply {
        [
          Eskimo::ASCII::Style.new([:bold, :green]) { 'hai' },
        ]
      }
    ).to eq("\e[1;32mhai\e[0m")
  end

  it 'accepts a splat' do
    expect(
      renderer.apply {
        [
          Eskimo::ASCII::Style.new(:bold, :green) { 'hai' },
        ]
      }
    ).to eq("\e[1;32mhai\e[0m")
  end
end
