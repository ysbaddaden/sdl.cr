module SDL
  struct Point
    property x, y

    def initialize(@x : Int32, @y : Int32)
    end

    # OPTIMIZE: avoid copy
    def to_unsafe
      pt = GC.malloc(sizeof(LibSDL::Point)).as(LibSDL::Point*)
      pt.value.x = x
      pt.value.y = y
      pt
    end
  end

  struct Rect
    property x, y, w, h

    def initialize(@x : Int32, @y : Int32, @w : Int32, @h : Int32)
    end

    # OPTIMIZE: avoid copy
    def to_unsafe
      rect = GC.malloc(sizeof(LibSDL::Rect)).as(LibSDL::Rect*)
      rect.value.x = x
      rect.value.y = y
      rect.value.w = w
      rect.value.h = h
      rect
    end
  end
end
