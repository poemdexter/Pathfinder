require 'gosu'

require_relative 'player'
require_relative 'world'
require_relative 'enemy'
require_relative 'pathfinder'

class Game < Gosu::Window
	attr_reader :world
	
  def initialize
    super 480, 480, false
    self.caption = "Dan's Shit Game For Idiots: Dubstep Protocol"
    @world = World.new(self)
    @player = Player.new(self)
    @enemy = Enemy.new(self)
    @pathfinder = Pathfinder.new
    
    @path_sprite = Gosu::Image.new(self, "path.bmp", false)
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
          @world.handle_wall_click(mouse_x, mouse_y)
        end
    end
  end
  
  def draw_path
    @path.each do |pos|
      @path_sprite.draw(24*pos[0], 24*pos[1], 1)
    end  
  end
	
	
end

window = Game.new
window.show