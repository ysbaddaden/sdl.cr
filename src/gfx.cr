require "./lib_gfx"
require "./sdl"

module SDL
  class GFXError < Exception
  end

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

  struct Triangle
    property x1 : Int16
    property y1 : Int16
    property x2 : Int16
    property y2 : Int16
    property x3 : Int16
    property y3 : Int16

    macro [](x1, y1, x2, y2, x3, y3)
      SDL::Triangle.new({{x1}}, {{y2}}, {{x2}}, {{y2}}, {{x3}}, {{y3}})
    end

    def initialize(x1, y1, x2, y2, x3, y3)
      @x1 = x1.to_i16
      @y1 = y1.to_i16
      @x2 = x2.to_i16
      @y2 = y2.to_i16
      @x3 = x3.to_i16
      @y3 = y3.to_i16
    end

    def initialize(p1, p2, p3)
      @x1 = p1.x.to_i16
      @y1 = p1.y.to_i16
      @x2 = p2.x.to_i16
      @y2 = p2.y.to_i16
      @x3 = p3.x.to_i16
      @y3 = p3.y.to_i16
    end
  end

  class Renderer
    # Draw a single `Circle`.
    def draw_circle(x, y, radius, anti_aliased = false)
      c = draw_color
      ret = if anti_aliased
              LibGFX.aa_circle_rgba(self, x.to_i16, y.to_i16, radius.to_i16, c.r, c.g, c.b, c.a)
                    .tap { self.draw_color = c }
            else
              LibGFX.circle_rgba(self, x.to_i16, y.to_i16, radius.to_i16, c.r, c.g, c.b, c.a)
            end
      raise GFXError.new("SDL_gfx_(aa)circleRGBA") unless ret == 0
    end

    # Draw a single `Circle`.
    def draw_circle(circle, anti_aliased = false)
      draw_circle(circle.x, circle.y, circle.radius, anti_aliased)
    end

    # Fill a `Circle` with the current `#draw_color`.
    def fill_circle(x, y, radius)
      c = draw_color
      ret = LibGFX.filled_circle_rgba(self, x.to_i16, y.to_i16, radius.to_i16, c.r, c.g, c.b, c.a)
      raise GFXError.new("SDL_gfx_filledCircleRGBA") unless ret == 0
    end

    # Fill a `Circle` with the current `#draw_color`.
    def fill_circle(circle)
      fill_circle(circle.x, circle.y, circle.radius)
    end

    # Draw a single `Ellipse`.
    def draw_ellipse(x, y, rx, ry, anti_aliased = false)
      c = draw_color
      ret = if anti_aliased
              LibGFX.aa_ellipse_rgba(self, x.to_i16, y.to_i16, rx.to_i16, ry.to_i16, c.r, c.g, c.b, c.a)
                    .tap { self.draw_color = c }
            else
              LibGFX.ellipse_rgba(self, x.to_i16, y.to_i16, rx.to_i16, ry.to_i16, c.r, c.g, c.b, c.a)
            end
      raise GFXError.new("SDL_gfx_(aa)ellipseRGBA") unless ret == 0
    end

    # Draw a single `Ellipse`.
    def draw_ellipse(ellipse, anti_aliased = false)
      draw_ellipse(ellipse.x, ellipse.y, ellipse.rx, ellipse.ry, anti_aliased)
    end

    # Fill an `Ellipse` with the current `#draw_color`.
    def fill_ellipse(x, y, rx, ry)
      c = draw_color
      ret = LibGFX.filled_ellipse_rgba(self, x.to_i16, y.to_i16, rx.to_i16, ry.to_i16, c.r, c.g, c.b, c.a)
      raise GFXError.new("SDL_gfx_filledEllipseRGBA") unless ret == 0
    end

    # Fill an `Ellipse` with the current `#draw_color`.
    def fill_ellipse(ellipse)
      fill_ellipse(ellipse.x, ellipse.y, ellipse.rx, ellipse.ry)
    end

    # Draw a single `Triangle`.
    def draw_triangle(x1, y1, x2, y2, x3, y3, anti_aliased = false)
      c = draw_color
      ret = if anti_aliased
              LibGFX.aa_trigon_rgba(self, x1, y1, x2, y2, x3, y3, c.r, c.g, c.b, c.a)
                    .tap { self.draw_color = c }
            else
              LibGFX.trigon_rgba(self, x1, y1, x2, y2, x3, y3, c.r, c.g, c.b, c.a)
            end
      raise GFXError.new("SDL_gfx_(aa)trigonRGBA") unless ret == 0
    end

    # Draw a single `Triangle`.
    def draw_triangle(triangle, anti_aliased = false)
      draw_triangle(triangle.x1, triangle.y1, triangle.x2, triangle.y2, triangle.x3, triangle.y3, anti_aliased)
    end

    # Draw a single `Triangle`.
    def draw_triangle(a, b, c, anti_aliased = false)
      draw_triangle(a.x, a.y, b.x, b.y, c.x, c.y, anti_aliased)
    end

    # Fill a `Triangle` with the current `#draw_color`.
    def fill_triangle(x1, y1, x2, y2, x3, y3)
      c = draw_color
      ret = LibGFX.filled_trigon_rgba(self, x1, y1, x2, y2, x3, y3, c.r, c.g, c.b, c.a)
      raise GFXError.new("SDL_gfx_filledTrigonRGBA") unless ret == 0
    end

    # Fill a `Triangle` with the current `#draw_color`.
    def fill_triangle(triangle)
      fill_triangle(triangle.x1, triangle.y1, triangle.x2, triangle.y2, triangle.x3, triangle.y3)
    end

    # Fill a `Triangle` with the current `#draw_color`.
    def fill_triangle(a, b, c)
      fill_triangle(a.x, a.y, b.x, b.y, c.x, c.y)
    end

    # Draw a single line between two `Point`.
    def draw_line(a, b, anti_aliased : Bool)
      if anti_aliased
        draw_line(a.x, a.y, b.x, b.y, true)
      else
        draw_line(a, b)
      end
    end

    # Draw a single line between two `Point`.
    def draw_line(x1, y1, x2, y2, anti_aliased : Bool)
      if anti_aliased
        c = draw_color
        ret = LibGFX.aa_line_rgba(self, x1, y1, x2, y2, c.r, c.g, c.b, c.a)
        self.draw_color = c
        raise GFXError.new("SDL_gfx_aalineRGBA") unless ret == 0
      else
        draw_line(x1, y1, x2, y2)
      end
    end

    # Draw a single rounded `Rect`.
    def draw_rounded_rect(rect, radius)
      draw_rounded_rect(rect.x, rect.y, rect.w, rect.h, radius)
    end

    # Draw a single rounded `Rect`.
    def draw_rounded_rect(x, y, w, h, radius)
      c = draw_color
      ret = LibGFX.rounded_rectangle_rgba(self, x, y, w, h, radius, c.r, c.g, c.b, c.a)
      raise GFXError.new("SDL_gfx_roundedRectangleRGBA") unless ret == 0
    end

    # Fill a rounded `Rect` with the current `draw_color` and `draw_blend_mode`.
    def fill_rounded_rect(rect, radius)
      fill_rounded_rect(rect.x, rect.y, rect.w, rect.h, radius)
    end

    # Fill a rounded `Rect` with the current `draw_color` and `draw_blend_mode`.
    def fill_rounded_rect(x, y, w, h, radius)
      c = draw_color
      ret = LibGFX.rounded_box_rgba(self, x, y, w, h, radius, c.r, c.g, c.b, c.a)
      raise GFXError.new("SDL_gfx_roundedBoxRGBA") unless ret == 0
    end
  end
end
