module Eskimo
  module Core
    module Props
      def self.included(base)
        fail "#{name} must be prepended"
      end

      def self.prepended(base)
        if base.include?(Eskimo::Core::Slots)
          fail "#{name} must be prepended before Eskmo::Core::Slots"
        end
      end

      def initialize(**props, &children)
        @props = props
        @children = children

        # can't find a cleaner way to check if parent constructor is defined
        # ref (they also can't seem to find a better way):
        # <https://apidock.com/rails/ActiveRecord/Coders/ColumnSerializer/check_arity_of_constructor>
        begin
          super
        rescue ArgumentError => e
          raise unless e.to_s.include?("expected 0")
        end
      end

      def render(**kwargs)
        super(**kwargs.merge(@props), &@children)
      end
    end
  end
end
