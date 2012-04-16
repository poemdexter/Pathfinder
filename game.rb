require 'state_machine'
require 'yaml'
require 'chingu'

include Gosu
include Chingu

require_relative 'traits/grid_sprite'

require_relative 'fsm_build'
require_relative 'player'
require_relative 'world'
require_relative 'pathfinder'
require_relative 'buildings'


class Game < Chingu::Window
	
  def initialize
    @width = 1280
    @height = 720
    super @width, @height
    self.caption = "Dan's Shit Game For Idiots: Dubstep Protocol"
  end

  def setup
    self.input = { :mouse_left => :left_click, :mouse_right => :right_click, :w => :w, :b => :b}

    World.instance.image_init(self)
    Buildings.init

    @player = Player.create

    @player_state_text = Chingu::Text.create("", :x => 5, :y => @height - 20, :zorder => 3)
  end

  def needs_cursor?
    true
  end

  def update
    super
		@player.update

    @player_state_text = Text.new("Player State: #{@player.fsm.state}", :x => 5, :y => @height - 20, :zorder => 3)
  end

  def draw
    super
    World.instance.draw
    @player.draw

    @player_state_text.draw
  end

  def left_click
    if mouse_within_screen(mouse_x, mouse_y)
      @player.reposition((mouse_x / World.instance.tilesize).floor, (mouse_y / World.instance.tilesize).floor)
    end
  end

  def right_click
    if mouse_within_screen(mouse_x, mouse_y)
      World.instance.handle_rock_click(mouse_x, mouse_y)
    end
  end

  def w
    if mouse_within_screen(mouse_x, mouse_y)
      World.instance.handle_wall_click(mouse_x, mouse_y)
    end
  end

  def b
    if mouse_within_screen(mouse_x, mouse_y)
      World.instance.handle_build_click(mouse_x, mouse_y)
    end
  end

  def mouse_within_screen(mouse_x, mouse_y)
    (0 < mouse_x && mouse_x < @width && 0 < mouse_y && mouse_y < @height)
  end
end

window = Game.new
window.show
