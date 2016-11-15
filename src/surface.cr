require "./rect"
require "./rwops"

module SDL
  def self.load_bmp(path)
    RWops.open(path, "rb") do |rwops|
      surface = LibSDL.load_bmp_rw(rwops, 1)
      raise Error.new("SDL_LoadBMP_RW") unless surface
      Surface.new(surface)
    end
  end

  struct Surface
    def initialize(@surface : LibSDL::Surface*)
    end

    def finalize
      LibSDL.free_surface(@surface)
    end

    def flags
      surface.flags
    end

    def width
      surface.w
    end

    def height
      surface.h
    end

    def pitch
      surface.pitch
    end

    def color(r, g, b)
      LibSDL.map_rgb(format, r, g, b)
    end

    def color(r, g, b, a)
      LibSDL.map_rgba(format, r, g, b, a)
    end

    def fill(r, g, b)
      LibSDL.fill_rect(@surface, nil, color(r, g, b))
    end

    def fill(r, g, b, a)
      LibSDL.fill_rect(@surface, nil, color(r, g, b, a))
    end

    # Saves the Surface as a BMP image.
    def save_bmp(path)
      if LibSDL.save_bmp_rw(@surface, RWops.new(path, "wb"), 1) != 0
        raise Error.new("SDL_SaveBMP_RW")
      end
    end

    # Fast copy of this Surface to *dst* Surface.
    def blit(dst : Surface, srcrect = nil, dstrect = nil)
      if LibSDL.upper_blit(self, srcrect, dst, dstrect) != 0
        raise Error.new("SDL_BlitSurface")
      end
    end

    # Fast scaled copy of this Surface to *dst* Surface. Scales to the whole
    # surface by default.
    def blit_scaled(dst : Surface, srcrect = nil, dstrect = nil)
      if LibSDL.upper_blit_scaled(self, srcrect, dst, dstrect) != 0
        raise Error.new("SDL_BlitScaled")
      end
    end

    # Copy this surface into a new one that is optimized for blitting to
    # the given *surface*.
    def convert(surface)
      optimized = LibSDL.convert_surface(self, surface.format, 0)
      raise Error.new("SDL_ConvertSurface") unless optimized
      Surface.new(optimized)
    end

    private def surface
      @surface.value
    end

    protected def format
      surface.format
    end

    #protected def pixels
    #  surface.pixels
    #end

    def to_unsafe
      @surface
    end
  end
end
