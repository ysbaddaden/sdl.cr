lib LibSDL
  alias TimerID = LibC::Int
  # (interval, param)
  alias TimerCallback = (UInt32, Void*) -> UInt32

  fun add_timer = SDL_AddTimer(interval : UInt32, callback : TimerCallback, param : Void*) : TimerID
  fun delay = SDL_Delay(ms : UInt32)
  fun get_performance_counter = SDL_GetPerformanceCounter : UInt64
  fun get_performance_frequency = SDL_GetPerformanceFrequency : UInt64
  fun get_ticks = SDL_GetTicks : UInt32
  fun get_ticks_64 = SDL_GetTicks64 : UInt64
  fun remove_timer = SDL_RemoveTimer(id : TimerID) : Bool
end
