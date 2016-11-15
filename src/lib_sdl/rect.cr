require "./pixels"

lib LibSDL
  struct Point
    x : Int
    y : Int
  end

  struct Rect
    x : Int
    y : Int
    w : Int
    h : Int
  end

  fun has_intersection = SDL_HasIntersection(a : Rect*, b : Rect*) : Bool
  fun intersect_rect = SDL_IntersectRect(a : Rect*, b : Rect*, result : Rect*) : Bool
  fun union_rect = SDL_UnionRect(a : Rect*, b : Rect*, result : Rect*)
  fun enclose_points = SDL_EnclosePoints(points : Point*, count : Int, clip : Rect*, result : Rect*) : Bool
  fun intersect_rect_and_line = SDL_IntersectRectAndLine(rect : Rect*, x1 : Int*, y1 : Int*, x2 : Int*, y2 : Int*) : Bool
end
