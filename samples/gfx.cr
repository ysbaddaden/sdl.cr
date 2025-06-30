require "../src/sdl"
require "../src/gfx"

WHITE  = SDL::Color[255, 255, 255, 255]
BLACK  = SDL::Color[0, 0, 0, 255]
RED    = SDL::Color[255, 0, 0, 255]
GREEN  = SDL::Color[0, 255, 0, 255]
BLUE   = SDL::Color[0, 0, 255, 255]
YELLOW = SDL::Color[255, 255, 0, 255]

SDL.init(SDL::Init::VIDEO)
at_exit { SDL.quit }

window = SDL::Window.new("SDL gfx", 640, 480)
renderer = SDL::Renderer.new(window)

width, height = window.size
cx = width / 2
cy = height / 2
angle = 0

loop do
  case event = SDL::Event.wait
  when SDL::Event::Quit
    break
  end

  # clear screen in black
  renderer.draw_color = BLUE
  renderer.clear

  # draw a rounded rect
  screen_rect = SDL::Rect.new(0, 0, width, height)
  renderer.draw_color = BLACK
  renderer.fill_rounded_rect screen_rect, 30
  renderer.draw_color = WHITE
  renderer.draw_rounded_rect screen_rect, 30

  # draw white centered cross
  renderer.draw_color = WHITE
  renderer.draw_line(0, cy, width, cy)
  renderer.draw_line(cx, 0, cx, height)

  # draw a green centered ellipse and some meridians with anti aliasing
  renderer.draw_color = GREEN
  renderer.draw_ellipse(cx, cy, width / 6, height / 6, anti_aliased: true)
  renderer.draw_circle(cx, cy, height / 6, anti_aliased: true)
  renderer.draw_ellipse(cx, cy, width / 12, height / 6, anti_aliased: true)
  renderer.draw_ellipse(cx, cy, width / 26, height / 6, anti_aliased: true)

  # draw two triangles within a square on the bottom right side of the screen
  rect = SDL::Rect[cx + width/4 - 51, cy + height/4 - 51, 102, 102]
  triangle1 = SDL::Triangle[rect.x + 1, rect.y + 1, rect.x + 100, rect.y + 1, rect.x + 1, rect.y + 100]
  triangle2 = SDL::Triangle[rect.x + 1, rect.y + 100, rect.x + 100, rect.y + 100, rect.x + 100, rect.y + 1]
  renderer.draw_color = RED
  renderer.draw_rect(rect)
  renderer.draw_color = YELLOW
  renderer.fill_triangle(triangle1)
  renderer.draw_color = BLUE
  renderer.fill_triangle(triangle2)

  # draw a red ball on the top left side of the screen
  renderer.draw_color = RED
  renderer.fill_circle SDL::Circle.new(width/4, cy - height/4, 50)
  renderer.draw_color = WHITE
  renderer.fill_ellipse SDL::Ellipse.new(width/4 + 25, cy - height/4 - 25, 8, 7)

  # draw triangles within a circle on the top right side of the screen
  circle = SDL::Circle.new(cx + width/4, cy - height/4, 50)
  renderer.draw_color = RED
  renderer.draw_circle circle, anti_aliased: true
  renderer.draw_color = YELLOW
  renderer.draw_point(circle.x, circle.y)

  30.step(by: 30, to: 360) do |a|
    a = a + angle
    x1 = circle.x + circle.radius * Math.cos(a * Math::PI / 180.0)
    y1 = circle.y + circle.radius * Math.sin(a * Math::PI / 180.0)
    x2 = circle.x + circle.radius * Math.cos((a - 30) * Math::PI / 180.0)
    y2 = circle.y + circle.radius * Math.sin((a - 30) * Math::PI / 180.0)
    renderer.draw_triangle SDL::Triangle.new(x1, y1, x2, y2, circle.x, circle.y), anti_aliased: true
  end

  # draw random lines on the bottom left side of the screen with antialiasing on and off
  renderer.draw_color = GREEN
  12.times do |i|
    x1 = rand(50..cx - 100)
    y1 = rand(cy + 50..height - 50)
    x2 = rand(50..cx - 100)
    y2 = rand(cy + 50..height - 50)

    if i % 2 == 0
      renderer.draw_color = GREEN
      renderer.draw_line(x1, y1, x2, y2, anti_aliased: true)
    else
      renderer.draw_color = RED
      renderer.draw_line(x1, y1, x2, y2, anti_aliased: false)
    end
  end

  angle = angle + 1 % 360
  renderer.present
end
