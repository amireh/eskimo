# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::HTML::Html do
  it 'renders the DOCTYPE' do
    expect(
      renderer.apply do
        Eskimo::HTML::Html.new
      end
    ).to eq("<!DOCTYPE html>\n<html></html>")
  end

  it 'renders without a DOCTYPE' do
    expect(
      renderer.apply do
        Eskimo::HTML::Html.new(doctype: nil)
      end
    ).to eq("<html></html>")
  end
end
