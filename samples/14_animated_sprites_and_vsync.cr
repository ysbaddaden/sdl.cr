require "../src/sdl"
require "../src/image"

SDL.init(SDL::Init::VIDEO); at_exit { SDL.quit }
IMG.init(IMG::Init::PNG); at_exit { IMG.quit }

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window, SDL::Renderer::Flags::ACCELERATED | SDL::Renderer::Flags::PRESENTVSYNC)

sprite = IMG.load(File.join(__DIR__, "data", "foo_sprite.png"), renderer)
sprite_clips = StaticArray(SDL::Rect, 4).new do |i|
  SDL::Rect.new(i * 64, 0, 64, 305)
end

frame = 0
slowdown = 6

loop do
  case event = SDL::Event.poll
  when SDL::Event::Quit
    break
  end

  renderer.draw_color = {255, 255, 255, 255}
  renderer.clear

  current_clip = sprite_clips[frame / slowdown]
  x = (window.surface.width - current_clip.w) / 2
  y = (window.surface.height - current_clip.h) / 2
  renderer.copy(sprite, current_clip, {x, y, current_clip.w, current_clip.h})

  renderer.present

  frame = (frame + 1) % (sprite_clips.size * slowdown)
end
