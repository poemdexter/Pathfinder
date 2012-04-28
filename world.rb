class World
  attr_reader :grid, :width, :height, :walls, :build_spot, :stones, :tilesize
  
  def initialize
    @width = 80
    @height = 45
    @tilesize = 16
    
    @grid = Array.new(width,[])
    @grid = @grid.map {Array.new(height,0)}
    
    @build_spot = []
    
    @walls = []
    @stones = []
    @houses = []
  end
  
  def self.instance
    @@instance ||= World.new
  end
  
  def image_init
    @target_sprite = Image["img/grass.bmp"]
    @wall_sprite   = Image["img/wall.bmp"]
    @stone_sprite  = Image["img/stone.bmp"]
    @build_sprite  = Image["img/path.bmp"]
    @house_sprite  = Image["img/building.bmp"]
  end
  
  def draw
    @grid.each_with_index do |inner, x|
      inner.each_index do |y|
        @target_sprite.draw(x*@tilesize,y*@tilesize,0)
      end
    end
    
    @walls.each do |pos|
			@wall_sprite.draw(@tilesize*pos[0], @tilesize*pos[1], 2)
		end
    
    @houses.each do |pos|
			@house_sprite.draw(@tilesize*(pos[0] - 1), @tilesize*(pos[1] - 1), 2)
		end
    
    @stones.each do |pos|
      @stone_sprite.draw(@tilesize*pos[0], @tilesize*pos[1], 2)
    end
    
    @build_spot.each do |pos|
      @build_sprite.draw(@tilesize*pos[0], @tilesize*pos[1], 2)
    end
  end
  
  def building_spot_exists?
    return true if @build_spot != [] 
    false
  end
  
  def building_complete
    @houses << @build_spot.shift
  end
  
  def handle_wall_click(x, y)
		x = (x/@tilesize).floor
    y = (y/@tilesize).floor
		if @walls.include?([x,y])
			@walls.delete([x,y])
		elsif
			@walls << [x,y]
		end
	end
  
  def handle_rock_click(x, y)
    x = (x/@tilesize).floor
    y = (y/@tilesize).floor
		if @stones.include?([x,y])
			@stones.delete([x,y])
		elsif
			@stones << [x,y]
		end
  end
  
  def handle_build_click(x, y)
    x = (x/@tilesize).floor
    y = (y/@tilesize).floor
      @build_spot << [x,y]
  end
end