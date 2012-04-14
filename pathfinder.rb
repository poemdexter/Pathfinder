class Pathfinder
  
  def initialize
  end
  
  def get_path(start, finish, world)
    @open_list = PriorityQueue.new
    @closed_list = []
    @start = start
    @finish = finish
    @world = world
    @walls = world.walls
    
    @open_list.add(1, create_node(0, calc_heuristic(@start), @start, []))
    
    while !@open_list.empty?
      
      current_node = @open_list.next
      @closed_list << current_node
      if current_node[:position] == @finish
        return backtrack_through_closed
      end
      
      get_neighbors(current_node[:position]).each do |n_position|
        next if in_closed_list?(n_position)
        g = current_node[:g] + 1
        open_neighbor = @open_list.select(n_position)
        if !open_neighbor
          h = calc_heuristic(n_position)
          f = g + h
          @open_list.add(f, create_node(g,h,n_position, current_node[:position]))
        elsif g < open_neighbor[:g]
          open_neighbor[:parent] = current_node[:position]
          open_neighbor[:g] = g
          f = g + open_neighbor[:h]
          @open_list.add(f,open_neighbor)
        end
      end
    end
    nil # no path found
  end
  
  def in_closed_list?(position)
    @closed_list.any?{|x| x[:position] == position}
  end
  
  def create_node(g, h, pos, parent)
    {
      :g => g,
      :h => h,
      :position => pos,
      :parent => parent
    }
  end
  
  def calc_heuristic(position)
		x = position[0]
		y = position[1]
		fx = @finish[0]
		fy = @finish[1]
		
    (x - fx).abs + (y - fy).abs
  end
  
  def get_neighbors(position)
    x = position[0]
		y = position[1]
    
    n_positions = []
    n_positions << [x,y-1]   #N
    n_positions << [x+1,y-1] #NE
    n_positions << [x+1,y]   #E
    n_positions << [x+1,y+1] #SE
    n_positions << [x,y+1]   #S
    n_positions << [x-1,y+1] #SW
    n_positions << [x-1,y]   #W
    n_positions << [x-1,y-1] #NW
    
    real_neighbors = []
    n_positions.each do |n|
      real_neighbors << n if valid_neighbor_check(n)
    end
    real_neighbors
  end
  
  def valid_neighbor_check(neighbor)
    x = neighbor[0]
    y = neighbor[1]
    valid = true
    valid = valid && x.between?(0,@world.width-1) && y.between?(0,@world.height-1)
    valid = valid && !@walls.include?(neighbor)
    valid
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
  
  class PriorityQueue
    def initialize
      @list = []
      @key = 0
    end
    
    def add(priority, item)
      @list << [priority, alt_sort_key, item]
      @list.sort!
      self
    end
    
    def alt_sort_key
      @key += 1
    end
    
    def count
      @list.count
    end
    
    def next
      @list.shift[2]
    end
    
    def select(position)
      item = @list.select{|x| x[2][:position] == position}[0]
      if item
        item[2]
      else
        nil
      end
    end
    
    def empty?
      @list.empty?
    end
  end
end