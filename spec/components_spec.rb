# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Renderer do
  ESK = Eskimo::Components

  describe 'SOFT_BREAK' do
    it 'inserts a soft linebreak' do
      expect(
        subject.apply {
          [
            'hello',
            ESK::SoftBreak.new,
            'world'
          ]
        }
      ).to eq("hello\nworld")
    end
  end

  describe 'BR' do
    it 'inserts a hard linebreak' do
      expect(
        subject.apply {
          [
            'hello',
            ESK::LineBreak.new,
            'world'
          ]
        }
      ).to eq("hello\n \nworld")
    end
  end

  describe 'STYLE' do
    it 'applies ANSI styling to text' do
      expect(
        subject.apply {
          [
            ESK::Style.new([:bold, :green]) { 'hai' },
          ]
        }
      ).to eq("\e[1;32mhai\e[0m")
    end

    it 'accepts a splat' do
      expect(
        subject.apply {
          [
            ESK::Style.new(:bold, :green) { 'hai' },
          ]
        }
      ).to eq("\e[1;32mhai\e[0m")
    end
  end

  describe 'WRAP' do
    it 'wraps text' do
      expect(
        subject.apply do
          ESK::Wrap.new(width: 5) do
            'hello world'
          end
        end
      ).to eq("\nhello \nworld")
    end
  end

  describe 'INDENT' do
    it 'indents each line' do
      expect(
        subject.apply do
          ESK::Indent.new(width: 2) do
            "hello\nworld"
          end
        end
      ).to eq("  hello\n  world")
    end
  end

  describe 'STRIP' do
    it 'strips surrounding whitespace' do
      expect(
        subject.apply do
          ESK::Strip.new do
            ESK::Indent.new(width: 2) do
              ("hello world")
            end
          end
        end
      ).to eq("hello world")
    end
  end

  describe 'TRUNCATE' do
    it 'truncates a string from the beginning if it exceeds the length' do
      expect(
        subject.apply do
          ESK::Truncate.new(width: 5) do
            ("hello world")
          end
        end
      ).to eq("... world")
    end

    it 'reserves chars from the width' do
      expect(
        subject.apply do
          ESK::Truncate.new(width: 10, reserve: 5) do
            ("hello world")
          end
        end
      ).to eq("... world")
    end

    it 'is a no-op if text fits' do
      expect(
        subject.apply do
          ESK::Truncate.new(width: 62, reserve: 5) do
            ("hello world")
          end
        end
      ).to eq("hello world")
    end
  end

  describe 'TruncateRear' do
    it 'truncates a string from the rear if it exceeds the length' do
      expect(
        subject.apply do
          ESK::TruncateRear.new(width: 5) do
            "hello world"
          end
        end
      ).to eq("hello...")
    end

    it 'reserves chars from the width' do
      expect(
        subject.apply do
          ESK::TruncateRear.new(width: 10, reserve: 5) do
            ("hello world")
          end
        end
      ).to eq("hello...")
    end

    it 'is a no-op if text fits' do
      expect(
        subject.apply do
          ESK::TruncateRear.new(width: 62, reserve: 5) do
            ("hello world")
          end
        end
      ).to eq("hello world")
    end
  end
end
