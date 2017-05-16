module SDL
  struct Color
    property r : Int32
    property g : Int32
    property b : Int32
    property a : Int32

    def initialize(@r, @g, @b, @a = 255)
    end

    def self.from(color : LibSDL::Color)
      new(color.r, color.g, color.b, color.a)
    end

    def self.from(color : Tuple)
      new(*color)
    end

    def self.from(color : NamedTuple)
      new(color[:r], color[:g], color[:b], color[:a]? || 255)
    end

    def self.from(color : Nil)
      nil
    end

    def to_unsafe
      color = uninitialized LibSDL::Color
      color.r = r
      color.g = g
      color.b = b
      color.a = a
      color
    end
  end
end
