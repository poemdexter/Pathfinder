class Player
  
  def initialize(window)
    @bandit_sprite = Gosu::Image.new(window, "img/bandit.bmp", false)
    @x = @y = 0
    
    @fsm = FSMBuild.new
    
    @update_rate = 200
    @count_rate = 0 
    @new_time = 0
    @old_time = 0
  end
  
  def draw
    @bandit_sprite.draw(24*@x, 24*@y, 2)
  end
  
  def update
    if tick?
      if @path && @path.count > 0
        node = @path.shift
        @x = node[0]
        @y = node[1]
      end
    end
  end
  
  def tick?
    @new_time = Gosu::milliseconds
    @count_rate = @count_rate + (@new_time - @old_time)
    @old_time = @new_time
    
    if @count_rate > @update_rate
      @count_rate = 0
      return true
    end
    false
  end
  
  def reposition(x, y)
    @x = (x/24).floor
    @y = (y/24).floor
  end
  
  def position
    [@x,@y]
  end
  
  def walk_path(path)
    @path = path
  end
end