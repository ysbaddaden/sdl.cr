require "./lib_gfx"
require "./sdl"

module SDL
  struct Circle
    property x : Int16
    property y : Int16
    property radius : Int16

    macro [](x, y, r)
      SDL::Circle.new({{x}}, {{y}}, {{r}})
    end

    def initialize(x, y, r)
      @x = x.to_i16
      @y = y.to_i16
      @radius = r.to_i16
    end
  end

  struct Ellipse
    property x : Int16
    property y : Int16
    property rx : Int16
    property ry : Int16

    macro [](x, y, rx, ry)
      SDL::Ellipse.new({{x}}, {{y}}, {{rx}}, {{ry}})
    end

    def initialize(x, y, rx, ry)
      @x = x.to_i16
      @y = y.to_i16
      @rx = rx.to_i16
      @ry = ry.to_i16
    end
  end

  class Renderer
    # Draw a single `Circle`.
    def draw_circle(x, y, radius, anti_aliased = false)
      c = self.draw_color
      ret = if anti_aliased
              LibGFX.aa_circle_rgba(self, x.to_i16, y.to_i16, radius.to_i16, c.r, c.g, c.b, c.a)
            else
              LibGFX.circle_rgba(self, x.to_i16, y.to_i16, radius.to_i16, c.r, c.g, c.b, c.a)
            end
      raise Exception.new("GFX_circleRGBA") unless ret == 0
      # reset original drawing color as antialiasing modifies alpha
      self.draw_color = c if anti_aliased
    end

    # Draw a single `Circle`.
    def draw_circle(circle, anti_aliased = false)
      self.draw_circle(circle.x, circle.y, circle.radius, anti_aliased)
    end

    # Fill a `Circle` with the current `#draw_color`.
    def fill_circle(x, y, radius)
      c = self.draw_color
      ret = LibGFX.filled_circle_rgba(self, x.to_i16, y.to_i16, radius.to_i16, c.r, c.g, c.b, c.a)
      raise Exception.new("GFX_filledCircleRGBA") unless ret == 0
    end

    # Fill a `Circle` with the current `#draw_color`.
    def fill_circle(circle)
      self.filled_circle(circle.x, circle.y, circle.radius)
    end

    # Draw a single `Ellipse`.
    def draw_ellipse(x, y, rx, ry, anti_aliased = false)
      c = self.draw_color
      ret = if anti_aliased
              LibGFX.aa_ellipse_rgba(self, x.to_i16, y.to_i16, rx.to_i16, ry.to_i16, c.r, c.g, c.b, c.a)
            else
              LibGFX.ellipse_rgba(self, x.to_i16, y.to_i16, rx.to_i16, ry.to_i16, c.r, c.g, c.b, c.a)
            end
      raise Exception.new("GFX_ellipseRGBA") unless ret == 0
      # reset original drawing color as antialiasing modifies alpha
      self.draw_color = c if anti_aliased
    end

    # Draw a single `Ellipse`.
    def draw_ellipse(ellipse, *, anti_aliased = false)
      self.draw_ellipse(ellipse.x, ellipse.y, ellipse.rx, ellipse.ry, anti_aliased)
    end
  end
end
