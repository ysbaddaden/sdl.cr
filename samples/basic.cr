require "../sdl"

SDL.init(SDL::Init::VIDEO)

screen = SDL::Screen.new(640, 480, 32, SDL::Flags::HWSURFACE)
screen.flip

loop do
  event = SDL::Event.wait
  p event

  case event
  when SDL::Event::Quit
    break
  when SDL::Event::Keyboard
    if event.mod.ctrl? && event.sym.q?
      break
    end
  end
end

SDL.quit
