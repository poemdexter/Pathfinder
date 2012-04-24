class Player < GameObject

  attr_reader :fsm

  def setup
    @image = Image["img/bandit.bmp"]
    @zorder = 2
    @grid_x = @grid_y = 0
    @fsm = FSMBuild.new
    @fsm.set_building(:hut)

    @update_rate = 200
    @count_rate = 0
    @new_time = 0
    @old_time = 0
  end

  def x=(v)
    @grid_x = v
    @x = v * World.instance.tilesize
  end

  def y=(v)
    @grid_y = v
    @y = v * World.instance.tilesize
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
            self.x = node[0]
            self.y = node[1]
          else
            @fsm.arrived
          end
        when "taking_mat"
          @fsm.got_mat
          World.instance.stones.shift
        when "searching_buildspot"
          if @path = Pathfinder.get_path(position, World.instance.build_spot[0])
            @fsm.path_found
          else
            @fsm.path_not_found
          end
        when "walking_buildspot"
          if @path.count > 0
            node = @path.shift
            self.x = node[0]
            self.y = node[1]
          else
            @fsm.arrived
          end
        when "placing_mat"
          @fsm.placed_mat("stone")
          if @fsm.got_all_mats? 
            @fsm.have_all_mats 
          else 
            @fsm.need_more_mats 
          end
        when "building"
          if @fsm.tick_construction_time == 0
            World.instance.building_complete
            @fsm.building_done
          else 
            @fsm.tick_building
          end
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
    self.x = x
    self.y = y
  end

  def position
    [@grid_x, @grid_y]
  end
end
