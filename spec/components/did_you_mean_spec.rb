# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::DidYouMean do
  it 'renders a suggestion' do
    expect(
      renderer.apply {
        described_class.new(dictionary: [ 'abc', 'bca' ], item: 'abd')
      }
    ).to eq("Did you mean? abc")
  end

  it 'renders nothing if no suggestions were found' do
    expect(
      renderer.apply {
        described_class.new(dictionary: [ 'abc', 'bca' ], item: 'asdf')
      }
    ).to eq("")
  end
end
