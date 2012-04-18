class World
  attr_reader :grid, :width, :height, :walls
  
  def initialize(window)
    @width = 20
    @height = 20
    @grid = Array.new(width,[])
    @grid = @grid.map {Array.new(height,0)}
    
    @target_sprite = Gosu::Image.new(window, "img/grass.bmp", true)
    @wall_sprite = Gosu::Image.new(window, "img/wall.bmp", false)
    
    @walls = []
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
  
end