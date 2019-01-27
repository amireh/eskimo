# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::Either do
  it 'renders the primary component' do
    expect(
      renderer.apply {
        described_class.new(->(**) { false }, "Fallback here")
      }
    ).to eq("Fallback here")
  end

  it 'renders the fallback if the primary does not' do
    expect(
      renderer.apply {
        described_class.new(->(**) { "Hi!" }, "Fallback here")
      }
    ).to eq("Hi!")
  end
end
