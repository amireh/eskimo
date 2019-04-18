module Eskimo
  module HTML
    module Test
      module ComponentSuite
        def renderer
          @renderer ||= Eskimo::Core::Renderer.new
        end
      end
    end
  end
end
