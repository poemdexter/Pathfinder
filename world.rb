class World
  attr_reader :grid, :width, :height, :walls, :build_spot, :stones
  
  def initialize(window)
    @width = 20
    @height = 20
    @grid = Array.new(width,[])
    @grid = @grid.map {Array.new(height,0)}
    
    @target_sprite = Gosu::Image.new(window, "img/grass.bmp", true)
    @wall_sprite = Gosu::Image.new(window, "img/wall.bmp", true)
    @stone_sprite = Gosu::Image.new(window, "img/stone.bmp", true)
    @path_sprite = Gosu::Image.new(window, "img/path.bmp", true)
    
    @build_spot = [9,3]
    
    @walls = []
    @stones = []
  end
  
  def draw
    @grid.each_with_index do |inner, x|
      inner.each_index do |y|
        @target_sprite.draw(x*24,y*24,0)
      end
    end
    
    @walls.each do |pos|
			@wall_sprite.draw(24*pos[0], 24*pos[1], 2)
		end
    
    @stones.each do |pos|
      @stone_sprite.draw(24*pos[0], 24*pos[1], 2)
    end
    
    @path_sprite.draw(24*@build_spot[0], 24*@build_spot[1], 1)
  end
  
  def handle_wall_click(x, y)
		x = (x/24).floor
    y = (y/24).floor
		if @walls.include?([x,y])
			@walls.delete([x,y])
		elsif
			@walls << [x,y]
		end
	end
  
  def handle_rock_click(x, y)
    x = (x/24).floor
    y = (y/24).floor
		if @stones.include?([x,y])
			@stones.delete([x,y])
		elsif
			@stones << [x,y]
		end
  end
  
end