lib LibSDL
  type GameController = Void

  enum GameControllerAxis
    INVALID = -1
    LEFTX
    LEFTY
    RIGHTX
    RIGHTY
    TRIGGERLEFT
    TRIGGERRIGHT
    MAX
  end

  enum GameControllerButton
    BUTTON_INVALID = -1
    BUTTON_A
    BUTTON_B
    BUTTON_X
    BUTTON_Y
    BUTTON_BACK
    BUTTON_GUIDE
    BUTTON_START
    BUTTON_LEFTSTICK
    BUTTON_RIGHTSTICK
    BUTTON_LEFTSHOULDER
    BUTTON_RIGHTSHOULDER
    BUTTON_DPAD_UP
    BUTTON_DPAD_DOWN
    BUTTON_DPAD_LEFT
    BUTTON_DPAD_RIGHT
    BUTTON_MISC1
    BUTTON_PADDLE1
    BUTTON_PADDLE2
    BUTTON_PADDLE3
    BUTTON_PADDLE4
    BUTTON_TOUCHPAD
    BUTTON_MAX
  end

  enum GameControllerBindType
    NONE = 0
    BUTTON
    AXIS
    HAT
  end

  struct GameControllerButtonBind_value_hat
    hat : Int
    hat_mask : Int
  end

  union GameControllerButtonBind_value
    button : Int
    axis : Int
    hat : GameControllerButtonBind_value_hat
  end

  struct GameControllerButtonBind
    bindType : GameControllerBindType
    value : GameControllerButtonBind_value
  end

  fun game_controller_add_mappings_from_rw = SDL_GameControllerAddMappingsFromRW(rw : RWops*, freerw : Int) : Int
  # SDL_GameControllerAddMappingsFromFile(file)   SDL_GameControllerAddMappingsFromRW(SDL_RWFromFile(file, "rb"), 1)

  fun game_controller_add_mapping = SDL_GameControllerAddMapping(mappingString : Char*) : Int
  fun game_controller_mapping_for_guid = SDL_GameControllerMappingForGUID(guid : JoystickGUID) : Char*
  fun game_controller_mapping = SDL_GameControllerMapping(gamecontroller : GameController*) : Char*
  fun game_controller_get_player_index = SDL_GameControllerGetPlayerIndex(gamecontroller : GameController*) : Int
  fun game_controller_from_player_index = SDL_GameControllerFromPlayerIndex(index : Int) : GameController*
  fun game_controller_from_instance_id = SDL_GameControllerFromInstanceID(joystick_id : LibSDL::JoystickID) : GameController*
  fun is_game_controller = SDL_IsGameController(joystick_index : Int) : Bool
  fun game_controller_rumble = SDL_GameControllerRumble(gamecontroller : GameController*, low_freq : UInt16, high_freq : UInt16, duration_ms : UInt32) : Int
  fun game_controller_rumble_triggers = SDL_GameControllerRumbleTriggers(gamecontroller : GameController*, left : UInt16, right : UInt16, duration_ms : UInt32) : Int
  fun game_controller_has_rumble = SDL_GameControllerHasRumble(gamecontroller : GameController*) : Bool
  fun game_controller_has_rumble_triggers = SDL_GameControllerHasRumbleTriggers(gamecontroller : GameController*) : Bool
  fun game_controller_name_for_index = SDL_GameControllerNameForIndex(joystick_index : Int)
  fun game_controller_open = SDL_GameControllerOpen(joystick_index : Int) : GameController*
  fun game_controller_name = SDL_GameControllerName(gamecontroller : GameController*) : Char*
  fun game_controller_get_attached = SDL_GameControllerGetAttached(gamecontroller : GameController*) : Bool
  fun game_controller_get_joystick = SDL_GameControllerGetJoystick(gamecontroller : GameController*) : Joystick*
  fun game_controller_event_state = SDL_GameControllerEventState(state : Int) : Int
  fun game_controller_update = SDL_GameControllerUpdate

  fun game_controller_has_axis = SDL_GameControllerHasAxis(gamecontroller : GameController*, axis : GameControllerAxis) : Bool
  fun game_controller_get_axis_from_string = SDL_GameControllerGetAxisFromString(pchString : Char*) : GameControllerAxis
  fun game_controller_get_string_for_axis = SDL_GameControllerGetStringForAxis(axis : GameControllerAxis) : Char*
  fun game_controller_get_bind_for_axis = SDL_GameControllerGetBindForAxis(gamecontroller : GameController*, axis : GameControllerAxis) : GameControllerButtonBind
  fun game_controller_get_axis = SDL_GameControllerGetAxis(gamecontroller : GameController*, axis : GameControllerAxis) : Int16

  fun game_controller_has_button = SDL_GameControllerHasButton(gamecontroller : GameController*, button : GameControllerButton) : Bool
  fun game_controller_get_button_from_string = SDL_GameControllerGetButtonFromString(pchString : Char*) : GameControllerButton
  fun game_controller_get_string_for_button = SDL_GameControllerGetStringForButton(button : GameControllerButton) : Char*
  fun game_controller_get_bind_for_button = SDL_GameControllerGetBindForButton(gamecontroller : GameController*, button : GameControllerButton) : GameControllerButtonBind
  fun game_controller_get_button = SDL_GameControllerGetButton(gamecontroller : GameController*, button : GameControllerButton) : UInt8

  fun game_controller_set_led = SDL_GameControllerSetLED(gamecontroller : GameController*, red : UInt8, green : UInt8, blue : UInt8) : Int
  fun game_controller_has_led = SDL_GameControllerHasLED(gamecontroller : GameController*) : Bool

  fun game_controller_close = SDL_GameControllerClose(gamecontroller : GameController*)
end
