require "./lib_sdl/main"
require "./lib_sdl/audio"
require "./lib_sdl/error"
require "./lib_sdl/events"
require "./lib_sdl/rwops"
require "./lib_sdl/video"

@[Link("SDL")]
lib LibSDL
  alias Char = LibC::Char
  alias Double = LibC::Double
  alias Float = LibC::Float
  alias Int = LibC::Int
  alias UInt = LibC::UInt

  INIT_TIMER = 1
  INIT_AUDIO = 16
  INIT_VIDEO = 32
  INIT_CDROM = 256
  INIT_JOYSTICK = 512
  INIT_NOPARACHUTE = 1048576
  INIT_EVENTTHREAD = 16777216
  INIT_EVERYTHING = 65535

  fun init = SDL_Init(flags : UInt32) : Int
  fun init_sub_system = SDL_InitSubSystem(flags : UInt32) : Int
  fun quit_sub_system = SDL_QuitSubSystem(flags : UInt32)
  fun was_init = SDL_WasInit(flags : UInt32) : UInt32
  fun quit = SDL_Quit()
end
