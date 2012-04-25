module Chingu
  module Traits
    module GridSprite
      include Chingu::Traits::Sprite
      def draw
        @image.draw_rot(@x * World.instance.tilesize, @y * World.instance.tilesize, @zorder, @angle, @center_x, @center_y, @factor_x, @factor_y, @color, @mode)  if @image
      end

      def draw_relative(x=0, y=0, zorder=0, angle=0, center_x=0, center_y=0, factor_x=0, factor_y=0)
        @image.draw_rot(@x * World.instance.tilesize + x, @y * World.instance.tilesize + y, @zorder+zorder, @angle+angle, @center_x+center_x, @center_y+center_y, @factor_x+factor_x, @factor_y+factor_y, @color, @mode)  if @image
      end
    end
  end
end
