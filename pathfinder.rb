class Pathfinder

	def initialize(game)
		@game = game
	end

  def get_path(start, finish, world)
    @open_list = []
    @closed_list = []
    @start = start
    @finish = finish
    @world = world
		
    # moving to ANY square costs 1, even diagonals
    @movement_cost = 1
		
    #add starting point to open list
    starting_point = create_node(-1, 0, start, start, 0)
    @open_list << starting_point
    
		# bool to check if we find path at end
    found_path = false
		
    #while open_list isn't empty or fail to find square
    while !@open_list.empty?
    
      # pick lowest heuristic (thanks sort!) and get more path options
      next_node = @open_list[0]
      @open_list.delete(next_node)
      @closed_list << next_node
      if found_finish_in_closed
        found_path = true
        break 
      end # finish condition
      get_adjacent_squares(next_node)
      @open_list.sort_by!{|node| node[:heuristic]}
    
    end
    
    if found_path
      backtrack_through_closed
    else
      nil
    end
  end
	
	def create_node(h,count,pos,parent,m_cost)
    {
      :heuristic => h,
      :list_count => count,
      :position => pos,
      :parent => parent,
      :move_cost => m_cost
    }
  end
  
  def backtrack_through_closed
    final_path = []
    next_position = @closed_list.find{|x| x[:position] == @finish}[:position]
    final_path.unshift(next_position)
    while next_position != @start
      next_position = @closed_list.find{|x| x[:position] == next_position}[:parent]
      final_path.unshift(next_position)
    end
    final_path
  end
  
  def get_adjacent_squares(node)
    x = node[:position][0]
		y = node[:position][1]
    
    #N
    adj_point = [x,y-1]
    adjacent_validity_check(adj_point, node)
    
    #NE
    adj_point = [x+1,y-1]
    adjacent_validity_check(adj_point, node)
    
    #E
    adj_point = [x+1,y]
    adjacent_validity_check(adj_point, node)
    
    #SE
    adj_point = [x+1,y+1]
    adjacent_validity_check(adj_point, node)
    
    #S
    adj_point = [x,y+1]
    adjacent_validity_check(adj_point, node)
    
    #SW
    adj_point = [x-1,y+1]
    adjacent_validity_check(adj_point, node)
    
    #W
    adj_point = [x-1,y]
    adjacent_validity_check(adj_point, node)
    
    #NW
    adj_point = [x-1,y-1]
    adjacent_validity_check(adj_point, node)
  end
  
  def is_adj_point_in_open(point)
    @open_list.any?{|x| x[:position] == point}
  end
  
  def found_finish_in_closed
    @closed_list.any?{|x| x[:position] == @finish}
  end
	
	def adjacent_validity_check(adj_point, node)
    if is_adj_point_in_open(adj_point)
      is_better_path(adj_point, node)
    elsif can_add_to_open(adj_point)
			h = calc_heuristic(adj_point,node[:move_cost])
      @open_list << create_node(h, @open_list.count, adj_point, node[:position], node[:move_cost]+@movement_cost)
    end
  end
  
  # check to see if path to node from adj_point is better
  # if node's move cost (G) is lower if we use adj_point to get there, then yes
  def is_better_path(adj_point, node)
    adj_node = @open_list.find{|x| x[:position] == adj_point}
    if adj_node[:move_cost] + @movement_cost < node[:move_cost] 
      node[:parent] = adj_point
      node[:heuristic] = calc_heuristic(node[:position], adj_node[:move_cost]) # recalculate heuristic for node
    end
  end
  
  # ignore squares on closed_list and check bounds of world
  def can_add_to_open(p)
    !@closed_list.include?(p) && is_within_bounds(p) && !@game.walls.include?(p)
  end
  
  def is_within_bounds(point)
    x = point[0]
    y = point[1]
    
    x.between?(0,@world.width-1) && y.between?(0,@world.height-1)
  end
  
  # = path score (heuristic or F) = manhattan distance (H) + movement cost (G)
  def calc_heuristic(position, node_move_cost)
		x = position[0]
		y = position[1]
		fx = @finish[0]
		fy = @finish[1]
		
    ((x - fx).abs + (y - fy).abs) + node_move_cost + @movement_cost
  end
end