require "../src/sdl"
require "../src/image"
require "../src/ttf"

SDL.init(SDL::Init::VIDEO); at_exit { SDL.quit }
SDL::TTF.init; at_exit { SDL::TTF.quit }

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window, SDL::Renderer::Flags::ACCELERATED | SDL::Renderer::Flags::PRESENTVSYNC)

font = SDL::TTF::Font.new(File.join(__DIR__, "data", "lazy.ttf"), 28)
font_color = SDL::Color[0, 0, 0, 255]

renderer.draw_color = SDL::Color[255, 255, 255, 255]
prompt_surface = font.render_shaded("Press Enter to Reset Start Time.", font_color, renderer.draw_color)

start_time = 0

loop do
  case event = SDL::Event.poll
  when SDL::Event::Quit
    break
  when SDL::Event::Keyboard
    if event.keydown? && event.sym.return?
      start_time = SDL::Timer.ticks
    end
  end
  renderer.clear
  prompt_x = (window.width - prompt_surface.width) / 2
  renderer.copy(prompt_surface, dstrect: SDL::Rect[prompt_x, 0, prompt_surface.width, prompt_surface.height])

  time_text_surface = font.render_shaded("Milliseconds since start time #{SDL::Timer.ticks - start_time}", font_color, renderer.draw_color)
  time_text_x = (window.width - time_text_surface.width) / 2
  time_text_y = (window.height - time_text_surface.height) / 2
  renderer.copy(time_text_surface, dstrect: SDL::Rect[time_text_x, time_text_y, time_text_surface.width, time_text_surface.height])

  renderer.present
end
