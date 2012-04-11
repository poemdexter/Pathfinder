require 'gosu'
require_relative 'player'
require_relative 'world'
require_relative 'enemy'
require_relative 'pathfinder'

class Game < Gosu::Window
	attr_reader :walls
	
  def initialize
    super 480, 480, false
    self.caption = "Dan's Shit Game For Idiots: Dubstep Protocol"
    @world = World.new(self)
    @player = Player.new(self)
    @enemy = Enemy.new(self)
    @pathfinder = Pathfinder.new(self)
    
    @path_sprite = Gosu::Image.new(self, "path.bmp", false)
		@wall_sprite = Gosu::Image.new(self, "wall.bmp", false)
		@walls = []
  end
  
  def needs_cursor?
    true
  end
  
  def update
  end
  
  def draw
    @world.draw
    @player.draw
    @enemy.draw
		draw_walls
    
    if !@path.nil? 
      draw_path
    end
  end
  
  def button_down(id)
    case id
      when Gosu::MsLeft
        if (0 < mouse_x && mouse_x < 480 && 0 < mouse_y && mouse_y < 480)
          @player.reposition(mouse_x, mouse_y)
        end
      when Gosu::MsRight
        if (0 < mouse_x && mouse_x < 480 && 0 < mouse_y && mouse_y < 480)
          @enemy.reposition(mouse_x, mouse_y)
        end
      when Gosu::KbSpace
        @path = @pathfinder.get_path(@player.position, @enemy.position, @world)
			when Gosu::KbW
        if (0 < mouse_x && mouse_x < 480 && 0 < mouse_y && mouse_y < 480)
          handle_wall_click(mouse_x, mouse_y)
        end
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
		puts @walls.to_s
	end
  
  def draw_path
    @path.each do |pos|
      @path_sprite.draw(24*pos[0], 24*pos[1], 1)
    end  
  end
	
	def draw_walls
		@walls.each do |pos|
			@wall_sprite.draw(24*pos[0], 24*pos[1], 1)
		end
	end
end

window = Game.new
window.show