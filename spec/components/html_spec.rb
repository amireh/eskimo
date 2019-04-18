# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Components::HTML do
  describe Eskimo::Components::HTML::Html do
    it 'renders the DOCTYPE' do
      expect(
        renderer.apply do
          ESK::HTML::Html.new
        end
      ).to eq("<!DOCTYPE html>\n<html></html>")
    end

    it 'renders without a DOCTYPE' do
      expect(
        renderer.apply do
          ESK::HTML::Html.new(doctype: nil)
        end
      ).to eq("<html></html>")
    end
  end

  it 'generates classes for HTML tags' do
    expect(
      renderer.apply do
        ESK::HTML::Article.new(className: 'foo') do
          ESK::HTML::P.new do
            ESK::HTML::Span.new { "bar" }
          end
        end
      end
    ).to eq('<article class="foo"><p><span>bar</span></p></article>')
  end
end
