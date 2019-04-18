# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::HTML do
  it 'generates classes for HTML tags' do
    expect(
      renderer.apply do
        Eskimo::HTML::Article.new(className: 'foo') do
          Eskimo::HTML::P.new do
            Eskimo::HTML::Span.new { "bar" }
          end
        end
      end
    ).to eq('<article class="foo"><p><span>bar</span></p></article>')
  end
end
