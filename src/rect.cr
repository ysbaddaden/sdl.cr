module SDL
  struct Point
    property x, y

    def initialize(@x : Int32, @y : Int32)
    end

    def self.from(pt : Point)
      pt
    end

    def self.from(pt : LibSDL::Point*)
      Point.new(pt.value.x, pt.value.y)
    end

    def self.from(pt : Tuple)
      Point.new(*pt)
    end

    def self.from(pt : NamedTuple)
      Point.new(pt.x, pt.y)
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

    def self.from(rect : Rect)
      rect
    end

    def self.from(rect : LibSDL::Rect*)
      new(rect.value.x, rect.value.y, rect.value.w, rect.value.h)
    end

    def self.from(rect : Tuple)
      new(*rect)
    end

    def self.from(rect : NamedTuple)
      new(rect.x, rect.y, rect.w, rect.h)
    end

    def self.from(rect : Nil)
      nil
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
