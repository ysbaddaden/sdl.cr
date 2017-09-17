lib LibSDL
  # (interval, params)
  alias TimerCallback = (UInt32, Void*) -> Void
  alias TimerID = LibC::Int
  
  fun add_timer = SDL_AddTimer(interval : UInt32, callback : TimerCallback, param : Void*) : TimerID
  fun delay = SDL_Delay(ms : UInt32) : Void
  fun get_performance_counter = SDL_GetPerformanceCounter() : UInt64
  fun get_performance_frequence = SDL_GetPerformanceFrequency() : UInt64
  fun get_ticks = SDL_GetTicks() : UInt32
  fun remove_timer = SDL_RemoveTimer(id : TimerID) : Bool
  fun ticks_passed = SDL_TICKS_PASSED(a : UInt32, b : UInt32) : Bool
end
