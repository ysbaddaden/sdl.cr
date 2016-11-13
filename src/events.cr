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

    struct Active < Event
      @event : LibSDL::ActiveEvent
      delegate state, to: @event

      def gain?
        @event.gain == 1
      end
    end

    struct Keyboard < Event
      include PressRelease

      @event : LibSDL::KeyboardEvent
      delegate which, keysym, to: @event

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

    struct MouseMotion < Event
      include PressRelease

      @event : LibSDL::MouseMotionEvent
      delegate which, to: @event

      def x
        @event.x.to_i
      end

      def y
        @event.y.to_i
      end

      def xrel
        @event.xrel.to_i
      end

      def yrel
        @event.yrel.to_i
      end
    end

    struct MouseButton < Event
      include PressRelease

      @event : LibSDL::MouseButtonEvent
      delegate which, button, to: @event

      def x
        @event.x.to_i
      end

      def y
        @event.y.to_i
      end
    end

    struct JoyAxis < Event
      @event : LibSDL::JoyAxisEvent
      delegate which, ball, to: @event

      def xrel
        @event.xrel.to_i
      end

      def yrel
        @event.yrel.to_i
      end
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
      delegate which, ball, hat, value, to: @event
    end

    struct JoyButton < Event
      include PressRelease

      @event : LibSDL::JoyButtonEvent
      delegate which, button, to: @event
    end

    struct Resize < Event
      @event : LibSDL::ResizeEvent

      def width
        @event.w
      end

      def height
        @event.h
      end
    end

    struct Expose < Event
      @event : LibSDL::ExposeEvent
    end

    struct Quit < Event
      @event : LibSDL::QuitEvent
    end

    struct User < Event
      @event : LibSDL::UserEvent
      delegate code, data1, data2, to: @event

      def push
        ret = LibSDL.push_event(self)
        raise Error.new("SDL_PushEvent") unless ret == 0
      end
    end

    struct SysWM < Event
      @event : LibSDL::SysWMEvent
      delegate msg, to: @event
    end

    def self.ignore(type : Type) : Nil
      LibSDL.event_state(type, LibSDL::EventState::IGNORE)
    end

    def self.ignored?(type : Type)
      LibSDL.event_state(type, LibSDL::EventState::QUERY) == LibSDL::EventState::IGNORE
    end

    def self.enable(type : Type) : Nil
      LibSDL.event_state(type, LibSDL::EventState::ENABLE)
    end

    def self.enabled?(type : Type) : Nil
      LibSDL.event_state(type, LibSDL::EventState::QUERY) == LibSDL::EventState::ENABLE
    end

    def self.wait
      if LibSDL.wait_event(out event) == 1
        from(event)
      else
        raise Error.new("SDL_WaitEvent")
      end
    end

    def self.poll
      case LibSDL.poll_event(out event)
      when 1 then
        from(event)
      when -1
        raise Error.new("SDL_PollEvent")
      end
    end

    protected def self.from(event : LibSDL::Event)
      case event.type
      when .active_event?
        Active.new(event.active)
      when .keydown?, .keyup?
        Keyboard.new(event.key)
      when .mouse_motion?
        MouseMotion.new(event.motion)
      when .mouse_button_down?, .mouse_button_up?
        MouseButton.new(event.button)
      when .joy_axis_motion?
        JoyAxis.new(event.jaxis)
      when .joy_ball_motion?
        JoyBall.new(event.jball)
      when .joy_hat_motion?
        JoyHat.new(event.jhat)
      when .joy_button_down?, .joy_button_up?
        JoyButton.new(event.jbutton)
      when .video_resize?
        Resize.new(event.resize)
      when .video_expose?
        Expose.new(event.expose)
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

    # :nodoc:
    def to_unsafe
      @event
    end
  end
end
