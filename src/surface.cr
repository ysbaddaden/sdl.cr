module SDL
  #alias SURFACE = LibSDL::SURFACE

  @[Flags]
  enum Flags : UInt32
    SWSURFACE = LibSDL::SWSURFACE
    HWSURFACE = LibSDL::HWSURFACE
    ASYNCBLIT = LibSDL::ASYNCBLIT

    # available for SDL_SetVideoMode

    ANYFORMAT  = LibSDL::ANYFORMAT
    HWPALETTE  = LibSDL::HWPALETTE
    DOUBLEBUF  = LibSDL::DOUBLEBUF
    FULLSCREEN = LibSDL::FULLSCREEN
    OPENGL     = LibSDL::OPENGL
    OPENGLBLIT = LibSDL::OPENGLBLIT
    RESIZABLE  = LibSDL::RESIZABLE
    NOFRAME    = LibSDL::NOFRAME

    # used internally (read-only)

    HWACCEL     = LibSDL::HWACCEL
    SRCCOLORKEY = LibSDL::SRCCOLORKEY
    RLEACCELOK  = LibSDL::RLEACCELOK
    RLEACCEL    = LibSDL::RLEACCEL
    SRCALPHA    = LibSDL::SRCALPHA
    PREALLOC    = LibSDL::PREALLOC
  end

  struct VideoInfo
    @info : LibSDL::VideoInfo

    delegate video_mem, to: @info

    def initialize
      @info = LibSDL.get_video_info.value
    end

    def hw_available
      @info.flags.bit(0) == 1
    end

    def sw_available
      @info.flags.bit(1) == 1
    end

    def blit_hw
      @info.flags.bit(9) == 1
    end

    def blit_hw_cc
      @info.flags.bit(10) == 1
    end

    def blit_hw_a
      @info.flags.bit(11) == 1
    end

    def blit_sw
      @info.flags.bit(12) == 1
    end

    def blit_sw_cc
      @info.flags.bit(13) == 1
    end

    def blit_sw_a
      @info.flags.bit(14) == 1
    end

    def blit_fill
      @info.flags.bit(15)
    end

    def format
      @info.vfmt
    end

    def current_width
      @info.current_w
    end

    def current_height
      @info.current_h
    end
  end

  # TODO: #format, #pixels
  abstract class Surface
    @surface : LibSDL::Surface*

    # Returns a list of available video modes.
    #
    # May return an empty array if any dimension is possible. May return nil if
    # no dimensions are available.
    def self.available_modes(flags : Flags = Flags::None)
      rects = LibSDL.list_modes(nil, flags)

      # no modes available
      if rects.null?
        return
      end

      modes = [] of LibSDL::Rect
      i = 0

      unless rects.address == -1
        while rect = rects[i]
          modes << rect.value
        end
        i += 1
      end

      modes
    end

    # Returns the closest BPP available if the dimension is valid, otherwise
    # returns nil.
    def self.valid?(width, height, bpp, flags : Flags)
      closest_bpp = LibSDL.video_mode_ok(width, height, bpp, flags)
      closest_bpp if closest_bpp > 0
    end

    private def initialize(@surface)
    end

    def finalize
      LibSDL.free_surface(@surface)
    end

    private def surface
      @surface.value
    end

    def flags
      Flags.new(surface.flags)
    end

    def width
      surface.w
    end

    def height
      surface.h
    end

    def pitch
      surface.pitch.to_i
    end

    def rect
      surface.rect
    end

    def ref_count
      surface.refcount
    end

    # Locks the surface if required by the surface.
    #
    # NOTE: no operating system or library calls should be made while the
    # surface is locked, as critical system locks may be helf during this time.
    def lock
      unless must_lock?
        return yield
      end

      if LibSDL.lock_surface(@surface) == -1
        raise Error.new("SDL_LockSurface")
      end

      begin
        yield
      ensure
        LibSDL.unlock_surface(@surface)
      end
    end

    @[AlwaysInline]
    private def must_lock?
      (surface.__offset != 0) ||
        flags.hwsurface? || flags.asyncblit? || flags.rleaccel?
    end

    def flip
      LibSDL.flip(@surface)
    end
  end

  class Screen < Surface
    def initialize(width, height, bpp = 0, flags : Flags = Flags::None)
      @surface = LibSDL.set_video_mode(width, height, bpp, flags)
      raise Error.new("SDL_SetVideoMode") unless @surface
    end

    def caption
      LibSDL.get_caption(out title, out icon)
      String.new(title)
    end

    def caption=(title)
      LibSDL.wm_set_caption(title, nil)
      title
    end

    def icon_name(icon : Surface)
      LibSDL.wm_get_caption(out title, out icon)
      String.new(icon)
    end

    def icon_name=(name)
      LibSDL.wm_get_caption(name)
      name
    end

    def icon=(icon : Surface, mask)
      LibSDL.wm_set_icon(icon, mask)
    end

    def toggle_fullscreen
      LibSDL.wm_toggle_full_screen(@surface)
    end
  end

  class RGBSurface < Surface
    def initialize(width, height, depth = 32)
      # pixels are hardcoded as little endian
      r_mask = 0x000000ff
      g_mask = 0x0000ff00
      b_mask = 0x00ff0000
      a_mask = 0xff000000
      @surface = LibSDL.create_rgb_surface(width, height, depth, r_mask, g_mask, b_mask, a_mask)
      raise Error.new("SDL_CreateRGBSurface") unless surface
    end
  end
end
