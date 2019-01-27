# frozen_string_literal: true

module Eskimo
  # Render a component or a list of ones.
  class Renderer
    # @param props [Hash]
    #  Properties to pass to each component being rendered.
    def initialize(**props)
      @props = { **props, render: method(:render) }
    end

    # @param components [Proc]
    #  A block that returns components to render.
    def apply(&components)
      render(components)
    end

    private

    def render(*components)
      buf = +''

      for component in components do
        if component.is_a?(String)
          buf << component
        elsif component.is_a?(Array)
          buf << render(*component)
        elsif component.is_a?(Proc)
          buf << render(component[**@props])
        elsif component.respond_to?(:render)
          buf << render(component.render(**@props))
        elsif component
          bail(component)
        end
      end

      buf
    end

    def bail(component)
      raise ArgumentError.new(
        "Eskimo: don't know how to render #{component.class} => #{component}"
      )
    end
  end
end
