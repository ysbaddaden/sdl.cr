module SDL
  # Internal macro to return either a pointer to a struct or return or null
  # pointer. This compiler gymnastic is mostly required to pass a reference
  # to Rect which may be nil.
  #
  # :nodoc:
  macro pointer_or_null(variable, type)
    if {{variable.id}}
      %copy = {{variable.id}}
      pointerof(%copy)
    else
      Pointer({{type.id}}).null
    end
  end
end

require "./lib_sdl"
require "./events"
require "./hint"
require "./renderer"
require "./window"
require "./screensaver"
require "./color"
require "./timer"

module SDL
  class Error < Exception
    def initialize(name)
      super("#{name}: #{String.new(LibSDL.get_error)}")
    end
  end

  @[Flags]
  enum Init
    TIMER          = LibSDL::INIT_TIMER
    AUDIO          = LibSDL::INIT_AUDIO
    VIDEO          = LibSDL::INIT_VIDEO
    JOYSTICK       = LibSDL::INIT_JOYSTICK
    HAPTIC         = LibSDL::INIT_HAPTIC
    GAMECONTROLLER = LibSDL::INIT_GAMECONTROLLER
    EVENTS         = LibSDL::INIT_EVENTS
    NOPARACHUTE    = LibSDL::INIT_NOPARACHUTE
    EVERYTHING     = LibSDL::INIT_EVERYTHING
  end

  def self.init(flags : Init)
    ret = if @@initialized
            LibSDL.init(flags)
          else
            LibSDL.init_sub_system(flags)
          end
    if ret == 0
      @@initialized = true
    else
      raise Error.new("SDL_Init: failed")
    end
  end

  def self.init?(flag : Init)
    LibSDL.was_init(flag) == flag
  end

  def self.quit(flags : Init? = nil)
    if flags
      LibSDL.quit_sub_system(flags)
    else
      LibSDL.quit
    end
  end

  def self.get_desktop_display_mode(display_index : Int32) : LibSDL::DisplayMode
    ret = LibSDL.get_desktop_display_mode(display_index, out mode)
    raise Error.new("SDL_GetDesktopDisplayMode") unless ret == 0
    mode
  end

  def self.get_current_display_mode(display_index : Int32) : LibSDL::DisplayMode
    ret = LibSDL.get_current_display_mode(display_index, out mode)
    raise Error.new("SDL_GetCurrentDisplayMode") unless ret == 0
    mode
  end

  def self.displays : Array(Display)
    displays_size = LibSDL.get_num_video_displays
    raise Error.new("SDL_GetNumVideoDisplays") unless displays_size >= 0

    (0...displays_size).map do |index|
      Display.new(index)
    end
  end

  struct Display
    @index : Int32

    def initialize(@index)
    end

    def to_s(io)
      io << name
    end

    def name : String
      ret = LibSDL.get_display_name(@index)
      raise Error.new("SDL_GetDisplayName") if ret.null?
      String.new(ret)
    end

    def modes : Array(Mode)
      modes_size = LibSDL.get_num_display_modes(@index)
      raise Error.new("SDL_GetNumDisplayModes") if modes_size < 0

      (0...modes_size).map do |mode_index|
        ret = LibSDL.get_display_mode(@index, mode_index, out mode)
        raise Error.new("SDL_GetDisplayMode") unless ret == 0
        Mode.new(
          mode.format,
          mode.w,
          mode.h,
          mode.refresh_rate,
          mode.driverdata
        )
      end
    end

    def bounds : SDL::Rect
      rect = SDL::Rect.new(-1, -1, -1, -1)
      ret = LibSDL.get_display_bounds(@index, pointerof(rect))
      raise Error.new("SDL_GetDisplayBounds") unless ret == 0
      rect
    end

    def desktop_mode : Mode
      lib_mode = SDL.get_desktop_display_mode(@index)
      Mode.new(
        format: lib_mode.format,
        w: lib_mode.w,
        h: lib_mode.h,
        refresh_rate: lib_mode.refresh_rate,
        driver_data: lib_mode.driverdata
      )
    end

    def current_mode : Mode
      lib_mode = SDL.get_current_display_mode(@index)
      Mode.new(
        format: lib_mode.format,
        w: lib_mode.w,
        h: lib_mode.h,
        refresh_rate: lib_mode.refresh_rate,
        driver_data: lib_mode.driverdata
      )
    end

    struct Mode
      getter format : UInt32
      getter w : Int32
      getter h : Int32
      getter refresh_rate : Int32
      getter driver_data : Pointer(Void)

      def initialize(@format, @w, @h, @refresh_rate, @driver_data)
      end
    end
  end
end
