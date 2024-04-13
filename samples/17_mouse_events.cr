require "../src/sdl"
require "../src/image"

class Button
  WIDTH  = 300
  HEIGHT = 200
  TOTAL  =   4

  enum Sprite
    MOUSE_OUT
    MOUSE_OVER
    MOUSE_DOWN
    MOUSE_UP
    TOTAL
  end

  getter sprite : Int32 = Sprite::MOUSE_OUT.value

  def initialize(@texture : SDL::Texture, position : Tuple(Int32, Int32))
    @x, @y = position
  end

  def handle_event(event : SDL::Event)
    # Get mouse position
    # mouse_x and mouse_y are the x and y mouse cursor
    # relative to the focus window
    LibSDL.get_mouse_state(out mouse_x, out mouse_y)

    # mouse is left of the button
    # mouse is right of the button
    # mouse is above the button
    # mouse is below the button
    if mouse_x < @x || mouse_x > @x + WIDTH ||
       mouse_y < @y || mouse_y > @y + HEIGHT
      @sprite = Sprite::MOUSE_OUT.value
    else
      case event
      when SDL::Event::MouseMotion
        @sprite = Sprite::MOUSE_OVER.value
      when SDL::Event::MouseButton
        @sprite = Sprite::MOUSE_DOWN.value if event.pressed?
        @sprite = Sprite::MOUSE_UP.value if event.released?
      end
    end
  end

  def render(renderer : SDL::Renderer, srcrect : SDL::Rect)
    renderer.copy(@texture, srcrect, SDL::Rect[@x, @y, srcrect.w, srcrect.h])
  end
end

SDL.init(SDL::Init::VIDEO); at_exit { SDL.quit }
SDL::IMG.init(SDL::IMG::Init::PNG); at_exit { SDL::IMG.quit }

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window, SDL::Renderer::Flags::ACCELERATED | SDL::Renderer::Flags::PRESENTVSYNC)
texture = SDL::IMG.load(File.join(__DIR__, "data", "button.png"), renderer)

button_clips = StaticArray(SDL::Rect, Button::TOTAL).new do |i|
  SDL::Rect[0, i * Button::HEIGHT, Button::WIDTH, Button::HEIGHT]
end

buttons = [
  Button.new(texture, {0, 0}),
  Button.new(texture, {window.width - Button::WIDTH, 0}),
  Button.new(texture, {0, window.height - Button::HEIGHT}),
  Button.new(texture, {window.width - Button::WIDTH, window.height - Button::HEIGHT}),
]

loop do
  case event = SDL::Event.poll
  when SDL::Event::Quit
    break
  when SDL::Event::MouseMotion, SDL::Event::MouseButton
    buttons.each(&.handle_event(event))
  end

  renderer.draw_color = SDL::Color[255]
  renderer.clear

  buttons.each { |button| button.render(renderer, button_clips[button.sprite]) }

  renderer.present
end

# clean up data
[texture, renderer, window].each(&.finalize)
