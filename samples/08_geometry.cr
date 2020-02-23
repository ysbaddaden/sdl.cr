require "../src/sdl"

SDL.init(SDL::Init::VIDEO)
at_exit { SDL.quit }

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window)

width, height = window.size

loop do
  case event = SDL::Event.wait
  when SDL::Event::Quit
    break
  end

  # clear screen in white
  renderer.draw_color = SDL::Color[255, 255, 255, 255]
  renderer.clear

  # centered red rectangle
  renderer.draw_color = SDL::Color[255, 0, 0, 255]
  renderer.fill_rect((width / 4).to_i, (height / 4).to_i, (width / 2).to_i, (height / 2).to_i)

  # outlined green rectangle
  renderer.draw_color = SDL::Color[0, 255, 0, 255]
  renderer.draw_rect((width / 6).to_i, (height / 6).to_i, (width * 2 / 3).to_i, (height * 2 / 3).to_i)

  # blue horizontal line
  renderer.draw_color = SDL::Color[0, 0, 255, 255]
  renderer.draw_line(0, (height / 2).to_i, width, (height / 2).to_i)

  # vertical line of yellow dots
  renderer.draw_color = SDL::Color[255, 255, 0, 255]
  0.step(by: 4, to: height) do |i|
    renderer.draw_point((width / 2).to_i, i)
  end

  renderer.present
end
