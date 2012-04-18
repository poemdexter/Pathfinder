class Player
  
  attr_reader :fsm
  
  def initialize(window, world)
    @world = world
    
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
      case @fsm.state
        when "searching_mat"
          if @world.stones[0] && @path = Pathfinder.get_path(position, @world.stones[0], @world)
            @fsm.path_found
          else
            @fsm.path_not_found
          end
        when "walking_mat"
          if @path.count > 0
            node = @path.shift
            @x = node[0]
            @y = node[1]
          else
            @fsm.arrived
          end
        when "taking_mat"
          @fsm.got_mat
          @world.stones.shift
        when "searching_buildspot"
          if @path = Pathfinder.get_path(position, @world.build_spot, @world)
            @fsm.path_found
          else
            @fsm.path_not_found
          end
        when "walking_buildspot"
          if @path.count > 0
            node = @path.shift
            @x = node[0]
            @y = node[1]
          else
            @fsm.arrived
          end
        when "placing_mat"
          # should check here if we should get more mats or start building
          # fuck it, we love stones.  gotta catch em all
          @fsm.need_more_mats
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
end