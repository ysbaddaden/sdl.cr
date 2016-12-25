require "../src/sdl"
require "../src/image"

SDL.init(SDL::Init::VIDEO)
at_exit { SDL.quit }

window = SDL::Window.new("SDL Tutorial", 640, 480)
renderer = SDL::Renderer.new(window)

IMG.init(IMG::Init::PNG)
texture = IMG.load(File.join(__DIR__, "data", "loaded.png"), renderer)

loop do
  case event = SDL::Event.wait
  when SDL::Event::Quit
    break
  end

  renderer.draw_color = {255, 0, 0, 255}
  renderer.clear

  renderer.copy(texture, dstrect: {20, 20, 600, 440})

  renderer.present
end
