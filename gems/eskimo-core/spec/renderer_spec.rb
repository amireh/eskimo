# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo::Core::Renderer do
  it 'renders nothing' do
    expect(subject.apply).to eq('')
  end

  it 'renders a string' do
    expect(subject.apply { 'hello' }).to eq('hello')
  end

  it 'renders a proc' do
    expect(subject.apply { lambda do |**| 'hello' end }).to eq('hello')
  end

  it 'renders an array of renderables' do
    expect(subject.apply { ['h','ello'] }).to eq('hello')
  end

  it 'renders a #render renderable' do
    class Renderable
      def render(**)
        'hello'
      end
    end

    expect(subject.apply { Renderable.new }).to eq('hello')
  end

  it 'ignores falseys' do
    expect(subject.apply { nil }).to eq('')
    expect(subject.apply { false }).to eq('')
    expect(subject.apply { [nil,false] }).to eq('')
  end

  it 'passes props to renderers' do
    props = nil

    described_class.new(foo: 'bar').apply {
      lambda { |injected_props| ''.tap { props = injected_props } }
    }

    expect(props).to be_a(Hash)
    expect(props).to include(foo: 'bar')
  end

  it 'injects a "render" routine for procs' do
    expect(
      subject.apply { lambda { |render:, **| render['hello'] } }
    ).to eq('hello')
  end

  it 'bails on unrenderable inputs' do
    expect {
      subject.apply { :foo }
    }.to raise_error(ArgumentError,
      "Eskimo: don't know how to render #{:foo.class} => foo"
    )
  end
end
