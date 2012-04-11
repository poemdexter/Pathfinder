class Enemy
  
  def initialize(window)
    @skeleton_sprite = Gosu::Image.new(window, "skeleton.bmp", false)
    @x = @y = 19
  end
  
  def draw
    @skeleton_sprite.draw(24*@x, 24*@y, 2)
  end
  
  def reposition(x, y)
    @x = (x/24).floor
    @y = (y/24).floor
  end
  
  def position
    [@x,@y]
  end
end