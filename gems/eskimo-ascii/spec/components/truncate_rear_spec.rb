# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::TruncateRear do
  it 'truncates a string from the rear if it exceeds the length' do
    expect(
      renderer.apply do
        Eskimo::ASCII::TruncateRear.new(width: 5) do
          "hello world"
        end
      end
    ).to eq("hello...")
  end

  it 'reserves chars from the width' do
    expect(
      renderer.apply do
        Eskimo::ASCII::TruncateRear.new(width: 10, reserve: 5) do
          ("hello world")
        end
      end
    ).to eq("hello...")
  end

  it 'is a no-op if text fits' do
    expect(
      renderer.apply do
        Eskimo::ASCII::TruncateRear.new(width: 62, reserve: 5) do
          ("hello world")
        end
      end
    ).to eq("hello world")
  end
end
