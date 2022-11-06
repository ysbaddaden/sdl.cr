require "../src/sdl"

class Dot
  WIDTH = 20
  HEIGHT = 20
  VELOCITY = 10

  struct Position
    property x : Int32 = 0
    property y : Int32 = 0
  end

  struct Velocity
    property x : Int32 = 0
    property y : Int32 = 0
  end

  @surface : SDL::Surface

  def initialize
    @position = Position.new
    @velocity = Velocity.new
    @surface = SDL.load_bmp(File.join(__DIR__, "data", "dot.bmp"))
  end

  def finalize
    @surface.finalize
  end

  def handle_events(event : SDL::Event::Keyboard)
    case event.sym
    when .up?, .w?
      @velocity.y -= VELOCITY
    when .down?, .s?
      @velocity.y += VELOCITY
    when .left?, .a?
      @velocity.x -= VELOCITY
    when .right?, .d?
      @velocity.x += VELOCITY
    end if event.keydown? && event.repeat == 0

    case event.sym
    when .up?, .w?
      @velocity.y += VELOCITY
    when .down?, .s?
      @velocity.y -= VELOCITY
    when .left?, .a?
      @velocity.x += VELOCITY
    when .right?, .d?
      @velocity.x -= VELOCITY
    end if event.keyup? && event.repeat == 0
  end

  def move(x_limit : Int32, y_limit : Int32)
    # move left or right
    @position.x += @velocity.x

    # if we went too far left or right, move back
    @position.x -= @velocity.x if @position.x < 0 || @position.x + WIDTH > x_limit

    # move up or down
    @position.y += @velocity.y

    # if we went too far up or down, move back
    @position.y -= @velocity.y if @position.y < 0 || @position.y + HEIGHT > y_limit
  end

  def render(renderer : SDL::Renderer)
    renderer.copy(@surface, dstrect: SDL::Rect[@position.x, @position.y, @surface.width, @surface.height])
  end
end

SDL.init(SDL::Init::VIDEO); at_exit { SDL.quit }
SDL.set_hint(SDL::Hint::RENDER_SCALE_QUALITY, "1")

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window, SDL::Renderer::Flags::ACCELERATED | SDL::Renderer::Flags::PRESENTVSYNC)
dot = Dot.new

loop do
  case event = SDL::Event.poll
  when SDL::Event::Quit
    break
  when SDL::Event::Keyboard
    dot.handle_events(event)
  end

  dot.move(window.width, window.height)

  renderer.draw_color = SDL::Color[255]
  renderer.clear

  dot.render(renderer)

  renderer.present
end

# clean up data
[dot, renderer, window].each(&.finalize)
