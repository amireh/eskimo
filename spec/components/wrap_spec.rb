# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::Wrap do
  it 'wraps text' do
    expect(
      renderer.apply do
        ESK::Wrap.new(width: 5) do
          'hello world'
        end
      end
    ).to eq("\nhello \nworld")
  end
end
