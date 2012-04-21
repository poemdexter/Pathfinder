require 'gosu'
require 'state_machine'
require 'yaml'

require_relative 'fsm_build'
require_relative 'player'
require_relative 'world'
require_relative 'pathfinder'
require_relative 'buildings'

class Game < Gosu::Window
	
  def initialize
    @width = 1280
    @height = 720
    
    super @width, @height, false
    self.caption = "Dan's Shit Game For Idiots: Dubstep Protocol"
    World.instance.image_init(self)
    Buildings.init
    
    @player = Player.new(self)
    
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end
  
  def needs_cursor?
    true
  end
  
  def update
		@player.update
  end
  
  def draw
    World.instance.draw
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
          World.instance.handle_rock_click(mouse_x, mouse_y)
        end
      when Gosu::KbW
        if mouse_within_screen(mouse_x, mouse_y)
          World.instance.handle_wall_click(mouse_x, mouse_y)
        end
      when Gosu::KbB
        if mouse_within_screen(mouse_x, mouse_y)
          World.instance.handle_build_click(mouse_x, mouse_y)
        end
    end
  end
  
  def mouse_within_screen(mouse_x, mouse_y)
    (0 < mouse_x && mouse_x < @width && 0 < mouse_y && mouse_y < @height)
  end
end

window = Game.new
window.show