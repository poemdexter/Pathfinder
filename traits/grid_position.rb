module Chingu
  module Traits
    module GridPosition
      attr_accessor :x, :y

      #TODO make sure grid_sprite cooperates with this.
      def setup_trait(options = {})
        self.x = options[:x] || 0
        self.y = options[:y] || 0
      end

      def reposition(x, y)
        @x = x
        @y = y
      end

      def position
        [@x, @y]
      end
    end
  end
end
