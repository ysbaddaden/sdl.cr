require "../src/sdl"
require "../src/image"

SDL.init(SDL::Init::VIDEO); at_exit { SDL.quit }
IMG.init(IMG::Init::PNG); at_exit { IMG.quit }

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window)

image = IMG.load(File.join(__DIR__, "data", "sprites.png"))
image.color_key = {0, 255, 255}
sprite = SDL::Texture.from(image, renderer)

width, height = renderer.output_size

loop do
  case event = SDL::Event.wait
  when SDL::Event::Quit
    break
  end

  renderer.draw_color = {255, 255, 255, 255}
  renderer.clear

  renderer.copy(sprite, {0, 0, 100, 100}, {0, 0, 100, 100})
  renderer.copy(sprite, {100, 0, 100, 100}, {width - 100, 0, 100, 100})
  renderer.copy(sprite, {0, 100, 100, 100}, {0, height - 100, 100, 100})
  renderer.copy(sprite, {100, 100, 100, 100}, {width - 100, height - 100, 100, 100})

  renderer.present
end
