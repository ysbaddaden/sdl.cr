lib LibSDL
  HINT_FRAMEBUFFER_ACCELERATION           = "SDL_FRAMEBUFFER_ACCELERATION"
  HINT_RENDER_DRIVER                      = "SDL_RENDER_DRIVER"
  HINT_RENDER_OPENGL_SHADERS              = "SDL_RENDER_OPENGL_SHADERS"
  HINT_RENDER_DIRECT3D_THREADSAFE         = "SDL_RENDER_DIRECT3D_THREADSAFE"
  HINT_RENDER_SCALE_QUALITY               = "SDL_RENDER_SCALE_QUALITY"
  HINT_RENDER_VSYNC                       = "SDL_RENDER_VSYNC"
  HINT_VIDEO_ALLOW_SCREENSAVER            = "SDL_VIDEO_ALLOW_SCREENSAVER"
  HINT_VIDEO_X11_XVIDMODE                 = "SDL_VIDEO_X11_XVIDMODE"
  HINT_VIDEO_X11_XINERAMA                 = "SDL_VIDEO_X11_XINERAMA"
  HINT_VIDEO_X11_XRANDR                   = "SDL_VIDEO_X11_XRANDR"
  HINT_GRAB_KEYBOARD                      = "SDL_GRAB_KEYBOARD"
  HINT_MOUSE_RELATIVE_MODE_WARP           = "SDL_MOUSE_RELATIVE_MODE_WARP"
  HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS       = "SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS"
  HINT_IDLE_TIMER_DISABLED                = "SDL_IOS_IDLE_TIMER_DISABLED"
  HINT_ORIENTATIONS                       = "SDL_IOS_ORIENTATIONS"
  HINT_ACCELEROMETER_AS_JOYSTICK          = "SDL_ACCELEROMETER_AS_JOYSTICK"
  HINT_XINPUT_ENABLED                     = "SDL_XINPUT_ENABLED"
  HINT_GAMECONTROLLERCONFIG               = "SDL_GAMECONTROLLERCONFIG"
  HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS   = "SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS"
  HINT_ALLOW_TOPMOST                      = "SDL_ALLOW_TOPMOST"
  HINT_TIMER_RESOLUTION                   = "SDL_TIMER_RESOLUTION"
  HINT_VIDEO_HIGHDPI_DISABLED             = "SDL_VIDEO_HIGHDPI_DISABLED"
  HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK = "SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK"
  HINT_VIDEO_WIN_D3DCOMPILER              = "SDL_VIDEO_WIN_D3DCOMPILER"
  HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT    = "SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT"
  HINT_VIDEO_MAC_FULLSCREEN_SPACES        = "SDL_VIDEO_MAC_FULLSCREEN_SPACES"

  enum HintPriority
    DEFAULT
    NORMAL
    OVERRIDE
  end

  fun set_hint_with_priority = SDL_SetHintWithPriority(name : Char*, value : Char*, priority : HintPriority) : Bool
  fun set_hint = SDL_SetHint(name : Char*, value : Char*) : Bool
  fun get_hint = SDL_GetHint(name : Char*) : Char*

  alias HintCallback = (Void*, Char*, Char*, Char*) -> # (userdata, name, oldValue, newValue)
  fun add_hint_callback = SDL_AddHintCallback(name : Char*, callback : HintCallback*, userdata : Void*)
  fun del_hint_callback = SDL_DelHintCallback(name : Char*, callback : HintCallback*, userdata : Void*)

  fun clear_hints = SDL_ClearHints
end
