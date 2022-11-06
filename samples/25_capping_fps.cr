require "string_pool"

require "../src/sdl"
require "../src/ttf"

SDL.init(SDL::Init::VIDEO); at_exit { SDL.quit }
SDL::TTF.init; at_exit { SDL::TTF.quit }
SDL.set_hint(SDL::Hint::RENDER_SCALE_QUALITY, "1")

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window, SDL::Renderer::Flags::ACCELERATED)
font = SDL::TTF::Font.new(File.join(__DIR__, "data", "lazy.ttf"), 28)

pool = StringPool.new
fps_text = pool.get("Average Frames Per Second: ")
font_color = SDL::Color[0]

start_ticks = Time.monotonic.total_milliseconds
frames = 0

# Lock FPS at 60
locked_fps = 1000 / 60

loop do
  cap_ticks = Time.monotonic.total_milliseconds

  case event = SDL::Event.poll
  when SDL::Event::Quit
    break
  end

  average_fps = frames / ((Time.monotonic.total_milliseconds - start_ticks) / 1000)
  average_fps = 0 if average_fps > 2_000_000

  rendered_text = "#{fps_text}#{average_fps.format(decimal_places: 2)}"
  surface = font.render_shaded(rendered_text, font_color, renderer.draw_color)

  renderer.draw_color = SDL::Color[255]
  renderer.clear

  x = (window.width - surface.width) // 2
  y = (window.height - surface.height) // 2

  renderer.copy(surface, dstrect: SDL::Rect[x, y, surface.width, surface.height])
  renderer.present

  frames += 1
  frame_ticks = Time.monotonic.total_milliseconds - cap_ticks

  # if we finished this frame early, wait until we've reached 60 FPS before continuing
  while frame_ticks < locked_fps
    frame_ticks = Time.monotonic.total_milliseconds - cap_ticks
  end
end
