require "../src/sdl"
require "../src/image"

DEAD_ZONE = 8000

SDL.init(SDL::Init::VIDEO | SDL::Init::JOYSTICK); at_exit { SDL.quit }
SDL.set_hint(SDL::Hint::RENDER_SCALE_QUALITY, "1")

SDL::IMG.init(SDL::IMG::Init::PNG); at_exit { SDL::IMG.quit }

# are any joysticks connected?
if LibSDL.num_joysticks < 1
  puts "No joysticks connected!"
end

# get the first joystick
unless game_controller = LibSDL.joystick_open(0)
  puts "Could not open game controller. SDL Error: #{LibSDL.get_error}"
end

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window)
arrow = SDL::IMG.load(File.join(__DIR__, "data", "arrow.png"), renderer)

x_dir = y_dir = 0

loop do
  case event = SDL::Event.poll
  when SDL::Event::Quit
    break
  when SDL::Event::JoyAxis
    # motion on controller 1
    next unless event.which == 0

    case event.axis
    when 0                        # x-axis motion
      if event.value < -DEAD_ZONE # left of dead zone
        x_dir = -1
      elsif event.value > DEAD_ZONE # right of dead zone
        x_dir = 1
      else # default value
        x_dir = 0
      end
    when 1                        # y-axis motion
      if event.value < -DEAD_ZONE # below dead zone
        y_dir = -1
      elsif event.value > DEAD_ZONE # above dead zone
        y_dir = 1
      else # default value
        y_dir = 0
      end
    end
  end

  renderer.draw_color = SDL::Color[255]
  renderer.clear

  # calculate angle
  joystick_angle = Math.atan2(y_dir.to_f, x_dir.to_f) * 180 / Math::PI

  # correct angle
  joystick_angle = 0 if x_dir == 0 && y_dir == 0

  x = (window.width - arrow.width) // 2
  y = (window.height - arrow.height) // 2
  renderer.copy(arrow, dstrect: SDL::Rect[x, y, arrow.width, arrow.height], angle: joystick_angle)

  renderer.present
end

# clean up data
LibSDL.joystick_close(game_controller)
[arrow, renderer, window].each(&.finalize)
