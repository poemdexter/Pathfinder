module Chingu
  module Traits
    module GridSprite
      include Chingu::Traits::Sprite
      def draw
        @image.draw(@x * World.instance.tilesize, @y * World.instance.tilesize, @zorder)  if @image
      end

      def draw_relative(x=0, y=0)
        @image.draw(@x * World.instance.tilesize + x, @y * World.instance.tilesize + y, @zorder)  if @image
      end
    end
  end
end
