require "./lib_sdl"
require "./events"
require "./keyboard"
require "./surface"

module SDL
  class Error < Exception
    def initialize(name)
      super("#{name}: #{String.new(LibSDL.get_error)}")
    end
  end

  @[Flags]
  enum Init
    TIMER       = LibSDL::INIT_TIMER
    AUDIO       = LibSDL::INIT_AUDIO
    VIDEO       = LibSDL::INIT_VIDEO
    CDROM       = LibSDL::INIT_CDROM
    JOYSTICK    = LibSDL::INIT_JOYSTICK
    NOPARACHUTE = LibSDL::INIT_NOPARACHUTE
    EVENTTHREAD = LibSDL::INIT_EVENTTHREAD
    EVERYTHING  = LibSDL::INIT_EVERYTHING
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
end
