require "../src/sdl"
require "../src/mixer"

SDL.init(SDL::Init::VIDEO); at_exit { SDL.quit }
SDL::Mixer.init(SDL::Mixer::Init::MP3); at_exit { SDL::Mixer.quit }


