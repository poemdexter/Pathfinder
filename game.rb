require 'state_machine'
require 'yaml'
require 'chingu'
require 'fidgit'

include Gosu
include Chingu

# TODO loop through all this
require_relative 'traits/grid_sprite'
require_relative 'traits/grid_position'

require_relative 'fsm_build'
require_relative 'player'
require_relative 'world'
require_relative 'pathfinder'
require_relative 'buildings'

require_relative 'states/playing'

class Game < Chingu::Window
	
  def initialize
    @width = 1280
    @height = 720
    super @width, @height
    self.caption = "Spacestro II: Slaves to Armok"
    
    push_game_state(Playing)
  end
  
  def needs_cursor?
    true
  end
end

window = Game.new
window.show