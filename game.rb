require 'gosu'
require 'state_machine'

require_relative 'fsm_build'
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
    @player = Player.new(self, @world)
    
    
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end
  
  def needs_cursor?
    true
  end
  
  def update
		@player.update
  end
  
  def draw
    @world.draw
    @player.draw
    
    @font.draw(@player.fsm.state, 3, 460,3)
  end
  
  def button_down(id)
    case id
      when Gosu::MsLeft
        if mouse_within_screen(mouse_x, mouse_y)
          @player.reposition(mouse_x, mouse_y)
        end
      when Gosu::MsRight
        if mouse_within_screen(mouse_x, mouse_y)
          @world.handle_rock_click(mouse_x, mouse_y)
        end
      when Gosu::KbW
        if mouse_within_screen(mouse_x, mouse_y)
          @world.handle_wall_click(mouse_x, mouse_y)
        end
    end
  end
  
  def mouse_within_screen(mouse_x, mouse_y)
    (0 < mouse_x && mouse_x < 480 && 0 < mouse_y && mouse_y < 480)
  end
end

window = Game.new
window.show