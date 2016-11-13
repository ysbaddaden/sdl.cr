require "./joystick"
require "./keyboard"

@[Link("SDL")]
lib LibSDL
  RELEASED = 0
  PRESSED  = 1

  enum EventType : UInt8
    NoEvent         =  0
    ActiveEvent     #=  1
    Keydown         #=  2
    Keyup           #=  3
    MouseMotion     #=  4
    MouseButtonDown #=  5
    MouseButtonUp   #=  6
    JoyAxisMotion   #=  7
    JoyBallMotion   #=  8
    JoyHatMotion    #=  9
    JoyButtonDown   #= 10
    JoyButtonUp     #= 11
    Quit            #= 12
    SysWMEvent      #= 13
    EventReservedA  #= 14
    EventReservedB  #= 15
    VideoResize     #= 16
    VideoExpose     #= 17
    EventReserved2  #= 18
    EventReserved3  #= 19
    EventReserved4  #= 20
    EventReserved5  #= 21
    EventReserved6  #= 22
    EventReserved7  #= 23
    UserEvent       #= 24
    NumEvents       #= 32
  end

  enum EventMask : UInt32
    ActiveEventMask     =      2
    KeydownMask         =      4
    KeyupMask           =      8
    KeyEventMask        =     12
    MouseMotionMask     =     16
    MouseButtonDownMask =     32
    MouseButtonUpMask   =     64
    MouseEventMask      =    112
    JoyAxisMotionMask   =    128
    JoyBallMotionMask   =    256
    JoyHatMotionMask    =    512
    JoyButtonDownMask   =   1024
    JoyButtonUpMask     =   2048
    JoyEventMask        =   3968
    VideoResizeMask     =  65536
    VideoExposeMask     = 131072
    QuitMask            =   4096
    SysWMEventMask      =   8192
  end

  ALLEVENTS = 1099511627570

  union Event
    type : EventType
    active : ActiveEvent
    key : KeyboardEvent
    motion : MouseMotionEvent
    button : MouseButtonEvent
    jaxis : JoyAxisEvent
    jball : JoyBallEvent
    jhat : JoyHatEvent
    jbutton : JoyButtonEvent
    resize : ResizeEvent
    expose : ExposeEvent
    quit : QuitEvent
    user : UserEvent
    syswm : SysWMEvent
  end

  struct ActiveEvent
    type : EventType
    gain : UInt8
    state : UInt8
  end

  struct KeyboardEvent
    type : EventType
    which : UInt8
    state : UInt8
    keysym : KeySym
  end

  struct MouseMotionEvent
    type : EventType
    which : UInt8
    state : UInt8
    x : UInt16
    y : UInt16
    xrel : Int16
    yrel : Int16
  end

  struct MouseButtonEvent
    type : EventType
    which : UInt8
    button : UInt8
    state : UInt8
    x : UInt16
    y : UInt16
  end

  struct JoyAxisEvent
    type : EventType
    which : UInt8
    axis : UInt8
    value : Int16
  end

  struct JoyBallEvent
    type : EventType
    which : UInt8
    ball : UInt8
    xrel : Int16
    yrel : Int16
  end

  struct JoyHatEvent
    type : EventType
    which : UInt8
    hat : UInt8
    value : Hat
  end

  struct JoyButtonEvent
    type : EventType
    which : UInt8
    button : UInt8
    state : UInt8
  end

  struct ResizeEvent
    type : EventType
    w : Int
    h : Int
  end

  struct ExposeEvent
    type : EventType
  end

  struct QuitEvent
    type : EventType
  end

  struct UserEvent
    type : EventType
    code : Int
    data1 : Void*
    data2 : Void*
  end

  struct SysWMEvent
    type : EventType
    msg : Void* # TODO: SysWMmsg*
  end

  fun pump_events = SDL_PumpEvents()

  enum EventAction : UInt32
    Add  = 0
    Peek = 1
    Get  = 2
  end
  fun peep_events = SDL_PeepEvents(events : Event*, numevents : Int, action : EventAction, mask : EventMask) : Int

  fun poll_event = SDL_PollEvent(event : Event*) : Int
  fun wait_event = SDL_WaitEvent(event : Event*) : Int
  fun push_event = SDL_PushEvent(event : Event*) : Int

  alias EventFilter = Event* -> Int
  fun set_event_filter = SDL_SetEventFilter(filter : EventFilter)
  fun get_event_filter = SDL_GetEventFilter() : EventFilter

  QUERY   = -1
  IGNORE  = 0
  DISABLE = 0
  ENABLE  = 1
  fun event_state = SDL_EventState(type : EventType, state : Int) : UInt8
end
