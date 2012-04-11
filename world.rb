class World
  attr_reader :grid, :width, :height
  
  def initialize(window)
    @width = 20
    @height = 20
    @grid = Array.new(width,[])
    @grid = @grid.map {Array.new(height,0)}
    
    @target_sprite = Gosu::Image.new(window, "target.bmp", true)
  end
  
  def draw
    @grid.each_with_index do |inner, x|
      inner.each_index do |y|
        @target_sprite.draw(x*24,y*24,0)
      end
    end
  end
  
end