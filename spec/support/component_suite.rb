module EskimoTest
  module ComponentSuite
    def renderer
      @renderer ||= Eskimo::Renderer.new
    end

    def strip_styles(string)
      pastel.strip(string)
    end

    def pastel
      @pastel ||= Pastel.new
    end
  end
end
