class Player
  
  def initialize(window)
    @bandit_sprite = Gosu::Image.new(window, "img/bandit.bmp", false)
    @x = @y = 0
  end
  
  def draw
    @bandit_sprite.draw(24*@x, 24*@y, 2)
  end
  
  def reposition(x, y)
    @x = (x/24).floor
    @y = (y/24).floor
  end
  
  def position
    [@x,@y]
  end
end