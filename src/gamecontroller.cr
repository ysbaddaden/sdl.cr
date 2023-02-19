module SDL
  class GameController
    alias Axis = LibSDL::GameControllerAxis
    alias Button = LibSDL::GameControllerButton
    alias ButtonBind = LibSDL::GameControllerButtonBind

    enum EventState
      QUERY  = -1
      IGNORE
      ENABLE
    end

    # Check if the given joystick at `index` is supported by the game controller interface.
    def self.controller?(index : Int)
      ret = LibSDL.is_game_controller(index)
      raise Error.new("SDL_IsGameController") unless ret
      ret
    end

    # Get the unsafe pointer to the controller associated with an instance id.
    def self.from_instance_id(joystick_id : LibSDL::JoystickID)
      ret = LibSDL.game_controller_from_instance_id(joystick_id)
      raise Error.new("SDL_GameControllerFromInstanceID") unless ret
      ret
    end

    # Get the controller's instance id from its index
    #
    # This is primarily used when you receive a SDL::Event::Controller* event and need to map
    # the device's index id to its device instance id
    #
    # If you need the device id from an instance, use `GameController#instance_id`.
    #
    # Returns the instance id of the selected joystick. If called on an invalid index, this function returns zero.
    # This can be called before any joysticks are opened. If the index is out of range, this function will return -1.
    def self.instance_id(index : Int) : LibSDL::JoystickID
      LibSDL.joystick_get_device_instance_id(index)
    end

    # Returns the pointer to the controller at `index` or a null pointer.
    def self.from_index(index : Int)
      LibSDL.game_controller_from_player_index(index)
    end

    # Check if a controller has been opened and is currently connected.
    def self.connected?(gamecontroller : self)
      !!LibSDL.game_controller_get_attached(gamecontroller)
    end

    def initialize(@index : Int32)
      @gamecontroller = LibSDL.game_controller_open(@index)
      raise Error.new("SDL_GameControllerOpen") unless @gamecontroller
    end

    def finalize
      LibSDL.game_controller_close(self)
    end

    # Get the controller's instance id from its index
    def instance_id : LibSDL::JoystickID
      LibSDL.joystick_get_device_instance_id(@index)
    end

    # Get the current state of an axis control on a game controller.
    #
    # The axis indices start at index 0.
    # The state is a value ranging from -32768 to 32767. Triggers, however, range from 0 to 32767 (they never return a negative value).
    def axis(axis : Axis) : Int16
      LibSDL.game_controller_get_axis(self, axis)
    end

    # Get the SDL joystick layer binding for a controller axis mapping.
    def axis_bind(axis : Axis) : ButtonBind
      LibSDL.game_controller_get_bind_for_axis(self, axis)
    end

    # Query whether a game controller has a given axis.
    def axis?(axis : Axis)
      !!LibSDL.game_controller_has_axis(self, axis)
    end

    # Get the current state of a button on a game controller.
    #
    # Returns 1 for pressed state or 0 for not pressed state.
    def button(button : Button) : UInt8
      LibSDL.game_controller_get_button(self, button)
    end

    # Get the SDL joystick layer binding for a controller button mapping.
    def button_bind(button : Button) : ButtonBind
      LibSDL.game_controller_get_bind_for_button(self, button)
    end

    # Query whether a game controller has a given button.
    def button?(button : Button)
      !!LibSDL.game_controller_has_button(self, button)
    end

    # Returns the same value passed to the function, with exception to -1 (QUERY), which will return the current state
    def event_state(state : EventState)
      LibSDL.game_controller_event_state(state)
    end

    # Get the player index of an opened game controller.
    #
    # Returns the player index for controller, or -1 if it's not available.
    # For XInput controllers this returns the XInput user index.
    def index : Int
      LibSDL.game_controller_get_player_index(self)
    end

    # Trigger a rumble effect.
    # Each call to this function cancels any previous rumble effect, and calling it with 0 intensity stops any rumbling.
    def rumble(low_freq : UInt16, high_freq : UInt16, duration_ms : UInt32) : Int
      ret = LibSDL.game_controller_rumble(self, low_freq, high_freq, duration_ms)
      # Workaround: using has_rumble? since the controller can sometimes
      # return -1 the first time it's checked for rumble support within SDL
      # (based on local testing on Windows with XBox one controller)
      raise Error.new("SDL_GameControllerHasRumble") unless rumble?
      ret
    end

    # Start a rumble effect in the game controller's triggers.
    #
    # Returns 0, or -1 if trigger rumble isn't supported on this controller
    # Each call to this function cancels any previous trigger rumble effect, and calling it with 0 intensity stops any rumbling.
    # Note that this is rumbling of the _triggers_ and not the game controller as a whole.
    # This is currently only supported on Xbox One controllers.
    # If you want the (more common) whole-controller rumble, use `rumble` instead.
    def rumble_triggers(left : UInt16, right : UInt16, duration_ms : UInt32) : Int
      LibSDL.game_controller_rumble_triggers(self, left, right, duration_ms)
    end

    # Check if the game controller supports rumble functionality.
    def rumble?
      !!LibSDL.game_controller_has_rumble(self)
    end

    # Query whether a game controller has rumble support on triggers.
    def rumble_triggers?
      !!LibSDL.game_controller_has_rumble_triggers(self)
    end

    # Update a game controller's LED color.
    #
    # Returns 0, or -1 if this controller does not have a modifiable LED
    def led_color=(rgb : Tuple(UInt8, UInt8, UInt8)) : Int
      LibSDL.game_controller_set_led(self, *rgb)
    end

    # Query whether a game controller has an LED.
    def led?
      !!LibSDL.game_controller_has_led(self)
    end

    # Manually pump game controller updates if not using the loop.
    #
    # This function is called automatically by the event loop if events are enabled.
    # Under such circumstances, it will not be necessary to call this function.
    def update
      LibSDL.game_controller_update
    end

    def to_unsafe
      @gamecontroller
    end
  end
end
