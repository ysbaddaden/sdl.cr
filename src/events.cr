module SDL
  abstract struct Event
    alias Type = LibSDL::EventType

    module PressRelease
      def pressed?
        @event.state == LibSDL::PRESSED
      end

      def released?
        @event.state == LibSDL::RELEASED
      end
    end

    struct Window < Event
      @event : LibSDL::WindowEvent
      delegate event, data1, data2, to: @event

      def window_id
        @event.windowID
      end
    end

    struct Keyboard < Event
      include PressRelease

      @event : LibSDL::KeyboardEvent
      delegate repeat, keysym, to: @event

      def window_id
        @event.windowID
      end

      def keyup?
        type.keyup?
      end

      def keydown?
        type.keydown?
      end

      def mod
        @event.keysym.mod
      end

      def sym
        @event.keysym.sym
      end
    end

    struct TextEditing < Event
      @event : LibSDL::TextEditingEvent
      delegate text, start, length, to: @event

      def window_id
        @event.windowID
      end
    end

    struct TextInput < Event
      @event : LibSDL::TextInputEvent
      delegate text, to: @event

      def window_id
        @event.windowID
      end
    end

    struct MouseMotion < Event
      include PressRelease

      @event : LibSDL::MouseMotionEvent
      delegate which, x, y, xrel, yrel, to: @event

      def window_id
        @event.windowID
      end
    end

    struct MouseButton < Event
      include PressRelease

      @event : LibSDL::MouseButtonEvent
      delegate which, button, clicks, x, y, to: @event

      def window_id
        @event.windowID
      end
    end

    struct MouseWheel < Event
      @event : LibSDL::MouseWheelEvent
      delegate which, x, y, to: @event

      def window_id
        @event.windowID
      end
    end

    struct JoyAxis < Event
      @event : LibSDL::JoyAxisEvent
      delegate which, x, y, to: @event
    end

    struct JoyBall < Event
      @event : LibSDL::JoyBallEvent
      delegate which, ball, to: @event

      def xrel
        @event.xrel.to_i
      end

      def yrel
        @event.yrel.to_i
      end
    end

    struct JoyHat < Event
      @event : LibSDL::JoyHatEvent
      delegate which, hat, value, to: @event
    end

    struct JoyButton < Event
      include PressRelease

      @event : LibSDL::JoyButtonEvent
      delegate which, button, to: @event
    end

    struct JoyDevice < Event
      @event : LibSDL::JoyDeviceEvent
      delegate which, to: @event
    end

    struct ControllerAxis < Event
      @event : LibSDL::ControllerAxisEvent
      delegate which, axis, value, to: @event
    end

    struct ControllerButton < Event
      include PressRelease

      @event : LibSDL::ControllerButtonEvent
      delegate which, button, to: @event
    end

    struct ControllerDevice < Event
      @event : LibSDL::ControllerDeviceEvent
      delegate which, to: @event
    end

    struct TouchFinger < Event
      @event : LibSDL::TouchFingerEvent
      delegate x, y, dx, dy, pressure, to: @event

      def touch_id
        @event.touchId
      end

      def finger_id
        @event.fingerId
      end
    end

    struct DollarGesture < Event
      @event : LibSDL::DollarGestureEvent
      delegate error, x, y, to: @event

      def touch_id
        @event.touchId
      end

      def gesture_id
        @event.gestureId
      end

      def num_fingers
        @event.numFingers
      end
    end

    struct MultiGesture < Event
      @event : LibSDL::MultiGestureEvent
      delegate x, y, to: @event

      def touch_id
        @event.touchId
      end

      def d_theta
        @event.dTheta
      end

      def d_dist
        @event.dDist
      end

      def num_fingers
        @event.numFingers
      end
    end

    struct Drop < Event
      @event : LibSDL::DropEvent

      def filename
        String.new(@event.file)
      end
    end

    struct Quit < Event
      @event : LibSDL::QuitEvent
    end

    struct User < Event
      @event : LibSDL::UserEvent
      delegate code, data1, data2, to: @event

      def window_id
        @event.windowID
      end

      def push
        ret = LibSDL.push_event(self)
        raise Error.new("SDL_PushEvent") unless ret == 0
      end
    end

    struct SysWM < Event
      @event : LibSDL::SysWMEvent
      delegate msg, to: @event
    end

    # Ignores an event type. They will no longer be pushed to the queue event.
    def self.ignore(type : Type) : Nil
      LibSDL.event_state(type, LibSDL::EventState::IGNORE)
    end

    # Returns true if an event type is ignored.
    def self.ignored?(type : Type)
      LibSDL.event_state(type, LibSDL::EventState::QUERY) == LibSDL::EventState::IGNORE
    end

    # Enables an event type. They will be pushed to the event queue.
    def self.enable(type : Type) : Nil
      LibSDL.event_state(type, LibSDL::EventState::ENABLE)
    end

    # Returns true if an event type is enabled.
    def self.enabled?(type : Type) : Nil
      LibSDL.event_state(type, LibSDL::EventState::QUERY) == LibSDL::EventState::ENABLE
    end

    # Tries to pull an event from the event queue; blocks until an event is added
    # to the queue, indefinitely, or for a given timeout.
    def self.wait(timeout = nil)
      event = uninitialized LibSDL::Event
      if timeout
        ret = LibSDL.wait_event_timeout(pointerof(event), timeout)
        raise Error.new("SDL_WaitEventTimeout") unless ret == 1
      else
        ret = LibSDL.wait_event(pointerof(event))
        raise Error.new("SDL_WaitEvent") unless ret == 1
      end
      from(event)
    end

    # Tries to pull an event from the event queue; returns nil immediately if the
    # queue is empty.
    def self.poll
      case LibSDL.poll_event(out event)
      when 1
        from(event)
      when -1
        raise Error.new("SDL_PollEvent")
      end
    end

    protected def self.from(event : LibSDL::Event)
      case event.type
      when .window_event?
        Window.new(event.window)
      when .keydown?, .keyup?
        Keyboard.new(event.key)
      when .text_editing?
        TextEditing.new(event.edit)
      when .text_input?
        TextInput.new(event.text)
      when .mouse_motion?
        MouseMotion.new(event.motion)
      when .mouse_button_down?, .mouse_button_up?
        MouseButton.new(event.button)
      when .mouse_wheel?
        MouseWheel.new(event.wheel)
      when .joy_axis_motion?
        JoyAxis.new(event.jaxis)
      when .joy_ball_motion?
        JoyBall.new(event.jball)
      when .joy_hat_motion?
        JoyHat.new(event.jhat)
      when .joy_button_down?, .joy_button_up?
        JoyButton.new(event.jbutton)
      when .joy_device_added?, .joy_device_removed?
        JoyDevice.new(event.jdevice)
      when .controller_axis_motion?
        ControllerAxis.new(event.caxis)
      when .controller_button_down?, .controller_button_up?
        ControllerButton.new(event.cbutton)
      when .controller_device_added?, .controller_device_removed?, .controller_device_remapped?
        ControllerDevice.new(event.cdevice)
      when .finger_down?, .finger_up?, .finger_motion?
        TouchFinger.new(event.tfinger)
      when .dollar_gesture?, .dollar_record?
        DollarGesture.new(event.dgesture)
      when .multi_gesture?
        MultiGesture.new(event.mgesture)
      when .drop_file?
        Drop.new(event.drop)
      when .quit?
        Quit.new(event.quit)
      when .sys_wm_event?
        SysWM.new(event.syswm)
      else
        User.new(event.user)
      end
    end

    def initialize(@event)
    end

    def type
      @event.type
    end

    def timestamp
      @event.timestamp
    end

    # :nodoc:
    def to_unsafe
      @event
    end
  end
end
