@[Link("SDL")]
lib LibSDL
  alias Joystick = Void

  fun num_joysticks : SDL_NumJoysticks() : Int
  fun joystick_name = SDL_JoystickName(device_index : Int) : Char*
  fun joystick_open = SDL_JoystickOpen(device_index : Int) : Joystick*
  fun joystick_opened = SDL_JoystickOpened(int device_index) : Int
  fun joystick_index = SDL_JoystickIndex(joystick : Joystick*) : Int
  fun joystick_num_axes = SDL_JoystickNumAxes(joystick : Joystick*) : Int
  fun joystick_num_balls = SDL_JoystickNumBalls(joystick : Joystick*) : Int
  fun joystick_num_hats = SDL_JoystickNumHats(joystick : Joystick*) : Int
  fun joystick_num_buttons = SDL_JoystickNumButtons(joystick : Joystick*) : Int
  fun joystick_update = SDL_JoystickUpdate()
  fun joystick_event_state = SDL_JoystickEventState(state : Int) : Int
  fun joystick_get_axis = SDL_JoystickGetAxis(joystick : Joystick, axis : Int) : Int16

  HAT_CENTERED  = 0x00
  HAT_UP        = 0x01
  HAT_RIGHT     = 0x02
  HAT_DOWN      = 0x04
  HAT_LEFT      = 0x08
  HAT_RIGHTUP   = RIGHT | UP
  HAT_RIGHTDOWN = RIGHT | DOWN
  HAT_LEFTUP    = LEFT | UP
  HAT_LEFTDOWN  = LEFT | DOWN
  fun joystick_get_hat = SDL_JoystickGetHat(joystick : Joystick, hat : Int) : UInt8

  fun joystick_get_ball = SDL_JoystickGetBall(joystick : Joystick*, ball : Int, dx : Int*, dy : Int*) : Int
  fun joystick_get_button = SDL_JoystickGetButton(joystick : Joystick*, button : Int)
  fun joystick_close = SDL_JoystickClose(joystick : Joystick*)
end
