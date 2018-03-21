require "./lib_sdl"

@[Link("SDL2_gfx")]
lib LibGFX
  alias Int = LibC::Int
  alias Float = LibC::Float

  alias Renderer = LibSDL::Renderer
  alias Surface = LibSDL::Surface

  VERSION = {% `pkg-config SDL2_gfx --modversion`.strip %}
  MAJOR   = {% VERSION.split('.')[0] %}
  MINOR   = {% VERSION.split('.')[1] %}
  PATCH   = {% VERSION.split('.')[2] %}

  # Graphics primitives

  fun pixel_color = pixelColor(renderer : Renderer*, x : Int16, y : Int16, color : UInt32) : Int
  fun pixel_rgba = pixelRGBA(renderer : Renderer*, x : Int16, y : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun hline_color = hlineColor(renderer : Renderer*, x1 : Int16, x2 : Int16, y : Int16, color : UInt32) : Int
  fun hline_rgba = hlineRGBA(renderer : Renderer*, x1 : Int16, x2 : Int16, y : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun vline_color = vlineColor(renderer : Renderer*, x : Int16, y1 : Int16, y2 : Int16, color : UInt32) : Int
  fun vline_rgba = vlineRGBA(renderer : Renderer*, x : Int16, y1 : Int16, y2 : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun rectangle_color = rectangleColor(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, color : UInt32) : Int
  fun rectangle_rgba = rectangleRGBA(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun rounded_rectangle_color = roundedRectangleColor(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, rad : Int16, color : UInt32) : Int
  fun rounded_rectangle_rgba = roundedRectangleRGBA(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, rad : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun box_color = boxColor(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, color : UInt32) : Int
  fun box_rgba = boxRGBA(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun rounded_box_color = roundedBoxColor(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, rad : Int16, color : UInt32) : Int
  fun rounded_box_rgba = roundedBoxRGBA(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, rad : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun line_color = lineColor(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, color : UInt32) : Int
  fun line_rgba = lineRGBA(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun aa_line_color = aalineColor(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, color : UInt32) : Int
  fun aa_line_rgba = aalineRGBA(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun thick_line_color = thickLineColor(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, width : UInt8, color : UInt32) : Int
  fun thick_line_rgba = thickLineRGBA(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, width : UInt8, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun circle_color = circleColor(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, color : UInt32) : Int
  fun circle_rgba = circleRGBA(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun arc_color = arcColor(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, start : Int16, end : Int16, color : UInt32) : Int
  fun arc_rgba = arcRGBA(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, start : Int16, end : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun aa_circle_color = aacircleColor(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, color : UInt32) : Int
  fun aa_circle_rgba = aacircleRGBA(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun filled_circle_color = filledCircleColor(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, color : UInt32) : Int
  fun filled_circle_rgba = filledCircleRGBA(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun ellipse_color = ellipseColor(renderer : Renderer*, x : Int16, y : Int16, rx : Int16, ry : Int16, color : UInt32) : Int
  fun ellipse_rgba = ellipseRGBA(renderer : Renderer*, x : Int16, y : Int16, rx : Int16, ry : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun aa_ellipse_color = aaellipseColor(renderer : Renderer*, x : Int16, y : Int16, rx : Int16, ry : Int16, color : UInt32) : Int
  fun aa_ellipse_rgba = aaellipseRGBA(renderer : Renderer*, x : Int16, y : Int16, rx : Int16, ry : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun filled_ellipse_color = filledEllipseColor(renderer : Renderer*, x : Int16, y : Int16, rx : Int16, ry : Int16, color : UInt32) : Int
  fun filled_ellipse_rgba = filledEllipseRGBA(renderer : Renderer*, x : Int16, y : Int16, rx : Int16, ry : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun pie_color = pieColor(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, start : Int16, end : Int16, color : UInt32) : Int
  fun pie_rgba = pieRGBA(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, start : Int16, end : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun filled_pie_color = filledPieColor(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, start : Int16, end : Int16, color : UInt32) : Int
  fun filled_pie_rgba = filledPieRGBA(renderer : Renderer*, x : Int16, y : Int16, rad : Int16, start : Int16, end : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun trigon_color = trigonColor(Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, x3 : Int16, y3 : Int16, color : UInt32) : Int
  fun trigon_rgba = trigonRGBA(Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, x3 : Int16, y3 : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun aa_trigon_color = aatrigonColor(Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, x3 : Int16, y3 : Int16, color : UInt32) : Int
  fun aa_trigon_rgba = aatrigonRGBA(Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, x3 : Int16, y3 : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun filled_trigon_color = filledTrigonColor(Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, x3 : Int16, y3 : Int16, color : UInt32) : Int
  fun filled_trigon_rgba = filledTrigonRGBA(Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16, x3 : Int16, y3 : Int16, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun polygon_color = polygonColor(renderer : Renderer*, vx : Int16*, vy : Int16*, n : Int, color : UInt32) : Int
  fun polygon_rgba = polygonRGBA(renderer : Renderer*, vx : Int16*, vy : Int16*, n : Int, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun aa_polygon_color = aapolygonColor(renderer : Renderer*, vx : Int16*, vy : Int16*, n : Int, color : UInt32) : Int
  fun aa_polygon_rgba = aapolygonRGBA(renderer : Renderer*, vx : Int16*, vy : Int16*, n : Int, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun filled_polygon_color = filledPolygonColor(renderer : Renderer*, vx : Int16*, vy : Int16*, n : Int, color : UInt32) : Int
  fun filled_polygon_rgba = filledPolygonRGBA(renderer : Renderer*, vx : Int16*, vy : Int16*, n : Int, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int

  fun textured_polygon = texturedPolygon(renderer : Renderer*, vx : Int16*, vy : Int16*, n : Int, texture : Surface*, texture_dx : Int, texture_dy : Int) : Int

  fun bezier_color = bezierColor(renderer : Renderer*, vx : Int16*, vy : Int16*, n : Int, s : Int, color : UInt32) : Int
  fun bezier_rgba = bezierRGBA(renderer : Renderer*, vx : Int16*, vy : Int16*, n : Int, s : Int, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int
end
