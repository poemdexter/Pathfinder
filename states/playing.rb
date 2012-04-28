class Playing < Chingu::GameState
  
  def initialize
    super
    
    World.instance.image_init
    Buildings.init

    @player = Player.create

    @player_state_text = Chingu::Text.create("", :x => 5, :y => $window.height - 20, :zorder => 3)
    
    self.input = { :mouse_left => :left_click, :mouse_right => :right_click, :w => :w, :b => :b}
  end

  def draw
    super
    World.instance.draw
    @player.draw

    @player_state_text.draw
  end

  def update
    super
    @player.update
    @player_state_text = Text.new("Player State: #{@player.fsm.state}", :x => 5, :y => $window.height - 20, :zorder => 3)
  end
  
  def left_click
    if mouse_within_screen
      @player.reposition(($window.mouse_x / World.instance.tilesize).floor, ($window.mouse_y / World.instance.tilesize).floor)
    end
  end

  def right_click
    if mouse_within_screen
      World.instance.handle_rock_click($window.mouse_x, $window.mouse_y)
    end
  end

  def w
    if mouse_within_screen
      World.instance.handle_wall_click($window.mouse_x, $window.mouse_y)
    end
  end

  def b
    if mouse_within_screen
      World.instance.handle_build_click($window.mouse_x, $window.mouse_y)
    end
  end

  def mouse_within_screen
    (0 < $window.mouse_x && $window.mouse_x < $window.width && 0 < $window.mouse_y && $window.mouse_y < $window.height)
  end
end