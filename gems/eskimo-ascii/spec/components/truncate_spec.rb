# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::Truncate do
  it 'truncates a string from the beginning if it exceeds the length' do
    expect(
      renderer.apply do
        Eskimo::ASCII::Truncate.new(width: 5) do
          ("hello world")
        end
      end
    ).to eq("... world")
  end

  it 'reserves chars from the width' do
    expect(
      renderer.apply do
        Eskimo::ASCII::Truncate.new(width: 10, reserve: 5) do
          ("hello world")
        end
      end
    ).to eq("... world")
  end

  it 'is a no-op if text fits' do
    expect(
      renderer.apply do
        Eskimo::ASCII::Truncate.new(width: 62, reserve: 5) do
          ("hello world")
        end
      end
    ).to eq("hello world")
  end
end
