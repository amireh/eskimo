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
      components.select(&NOT_FALSEY).reduce('') do |buf, component|
        case component
        when String
          buf + component
        when Array
          buf + render(*component)
        when Proc
          buf + render(component[**@props])
        else
          if component.respond_to?(:render)
            buf + render(component.render(**@props))
          else
            bail(component)
          end
        end
      end
    end

    def bail(component)
      raise ArgumentError.new(
        "Eskimo: don't know how to render #{component.class} => #{component}"
      )
    end

    NOT_FALSEY = ->(x) { !!x }.freeze
    private_constant :NOT_FALSEY
  end
end
