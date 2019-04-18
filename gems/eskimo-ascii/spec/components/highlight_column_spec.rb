# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::ASCII::HighlightColumn do
  it 'highlights the character' do
    style = [ :bold, :red ]

    expect(
      renderer.apply {
        described_class.new(column: 1, line: 1, style: style) { "number:\nfour" }
      }
    ).to include("f#{pastel.decorate('o', *style)}ur")
  end

  it 'highlights the first character' do
    style = [ :bold, :red ]

    expect(
      renderer.apply {
        described_class.new(column: 0, line: 0, style: style) { "four" }
      }
    ).to include("#{pastel.decorate('f', *style)}our")
  end

  it 'highlights the last character' do
    style = [ :bold, :red ]

    expect(
      renderer.apply {
        described_class.new(column: 3, line: 0, style: style) { "four" }
      }
    ).to include("fou#{pastel.decorate('r', *style)}")
  end

  it 'highlights nothing' do
    expect(
      renderer.apply {
        described_class.new(column: 1234, line: 0) { "four" }
      }
    ).to eq("four")

    expect(
      renderer.apply {
        described_class.new(column: 0, line: 1234) { "four" }
      }
    ).to eq("four")
  end

  it 'inserts the arrow' do
    expect(
      strip_styles(
        renderer.apply {
          described_class.new(column: 1, line: 0) { "four" }
        }
      )
    ).to eq(
      "four"  + "\n" +
      " ^"    + "\n" +
      " here" + "\n"
    )
  end
end
