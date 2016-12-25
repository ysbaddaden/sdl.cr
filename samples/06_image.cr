require "../src/sdl"
require "../src/image"

SDL.init(SDL::Init::VIDEO)
at_exit { SDL.quit }
window = SDL::Window.new("SDL Tutorial", 640, 480)

IMG.init(IMG::Init::PNG)
at_exit { IMG.quit }

png = IMG.load(File.join(__DIR__, "data", "loaded.png"))
png = png.convert(window.surface)

loop do
  case event = SDL::Event.wait
  when SDL::Event::Quit
    break
  end

  png.blit(window.surface)
  window.update
end
