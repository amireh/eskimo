module Eskimo
  module Core
    module Slots
      def self.included(base)
        fail "#{name} must be prepended"
      end

      def self.prepended(base)
        base.extend(ClassMethods)
      end

      def initialize(**props, &occupants_or_children)
        if klass_slots = self.class.instance_variable_get('@slots')
          @slots = Hash[klass_slots.map { |k| [k,nil] }]

          if occupants_or_children && occupants_or_children.arity == 1
            occupants_or_children[SlotBuilder.new(@slots)]

            begin
              super(**props, &nil)
            rescue ArgumentError => e
              raise unless e.to_s.include?("expected 0")
            end

            return
          end
        end

        begin
          super
        rescue ArgumentError => e
          raise unless e.to_s.include?("expected 0")
        end
      end

      module ClassMethods
        def slot(name)
          @slots ||= []
          @slots << name
        end
      end

      class SlotBuilder
        def initialize(store)
          @store = store
        end

        def method_missing(name, *args, &block)
          if @store.keys.include?(name.to_sym) && block
            @store[name] = block
          else
            super
          end
        end

        def respond_to_missing?(name, include_private = false)
          true
        end
      end

      private_constant :SlotBuilder
    end
  end
end