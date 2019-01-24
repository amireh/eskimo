# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Renderer do
  describe 'SoftBreak' do
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

  describe 'LineBreak' do
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

  describe 'Style' do
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

  describe 'Wrap' do
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

  describe 'Indent' do
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

  describe 'Squeeze' do
    it 'swallows consecutive newlines' do
      expect(
        subject.apply do
          ESK::Squeeze.new([
            ESK::SoftBreak.new,
            false && '1',

            ESK::SoftBreak.new,
            false && '2',

            ESK::SoftBreak.new,
            '3',

            ESK::SoftBreak.new,
            '4',
          ])
        end
      ).to eq("\n3\n4")
    end

    it 'does not swallow consecutive newlines in inner children' do
      expect(
        subject.apply do
          ESK::Squeeze.new([
            ESK::Indent.new(width: 0) do
              [
                ESK::SoftBreak.new,
                false && '1',

                ESK::SoftBreak.new,
                false && '2',

                ESK::SoftBreak.new,
                '3',

                ESK::SoftBreak.new,
                '4',
              ]
            end
          ])
        end
      ).to eq("\n\n\n3\n4")
    end
  end

  describe 'Strip' do
    it 'strips surrounding whitespace' do
      expect(
        subject.apply do
          ESK::Strip.new do
            "  hello world  "
          end
        end
      ).to eq("hello world")
    end
  end

  describe 'StripLeft' do
    it 'strips whitespace from the head' do
      expect(
        subject.apply do
          ESK::StripLeft.new do
            "  hello world  "
          end
        end
      ).to eq("hello world  ")
    end
  end

  describe 'StripLeft' do
    it 'strips whitespace from the rear' do
      expect(
        subject.apply do
          ESK::StripRight.new do
            "  hello world  "
          end
        end
      ).to eq("  hello world")
    end
  end

  describe 'Truncate' do
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
