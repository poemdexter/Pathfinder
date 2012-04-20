class Player
  
  attr_reader :fsm
  
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
    @bandit_sprite.draw(World.instance.tilesize*@x, World.instance.tilesize*@y, 2)
  end
  
  def update
    if tick?
      case @fsm.state
        when "chill"
          @fsm.building_needed if World.instance.building_spot_exists?
        when "searching_mat"
          if World.instance.stones[0] && @path = Pathfinder.get_path(position, World.instance.stones[0])
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
          World.instance.stones.shift
        when "searching_buildspot"
          if @path = Pathfinder.get_path(position, World.instance.build_spot)
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
          @fsm.have_all_mats
          #@fsm.need_more_mats
        when "building"
          #need to tick down here
          World.instance.building_complete
          @fsm.building_done
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
    @x = (x/World.instance.tilesize).floor
    @y = (y/World.instance.tilesize).floor
  end
  
  def position
    [@x,@y]
  end
end