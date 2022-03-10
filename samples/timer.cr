require "../src/sdl"

def callback(interval : UInt32, param : Void*) : UInt32
  puts "#{LibSDL.get_ticks} In callback with interval #{interval}ms and param #{param.as(String*).value}"
  interval
end

SDL.init(SDL::Init::EVERYTHING)
at_exit { SDL.quit }

param = "'param'"
timer_id = LibSDL.add_timer(50, ->callback, pointerof(param))
LibSDL.delay(51)
puts "#{LibSDL.get_ticks} After delay"
LibSDL.remove_timer(timer_id)
LibSDL.delay(51)
puts "#{LibSDL.get_ticks} Timer should have been called exactly once"