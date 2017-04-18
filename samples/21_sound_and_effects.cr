require "../src/sdl"
require "../src/image"
require "../src/mix"

SDL.init(SDL::Init::VIDEO | SDL::Init::AUDIO); at_exit { SDL.quit }
SDL::MIX.init(SDL::MIX::Init::MP3); at_exit { SDL::MIX.quit }
SDL::MIX.open

music = SDL::MIX.load_music(File.join(__DIR__, "data", "beat.wav"))

sounds = {} of String => LibMIX::Mix_Chunk*
names = %w(high medium low scratch)
names.each do |name|
  sounds[name] = SDL::MIX.load_wav(File.join(__DIR__, "data", "#{name}.wav"))
end

window = SDL::Window.new("SDL Tutorial", 640, 480)
png = SDL::IMG.load(File.join(__DIR__, "data", "prompt.png"))
png = png.convert(window.surface)
activekey = [] of LibSDL::Keycode

loop do
  case event = SDL::Event.wait
  when SDL::Event::Quit
    #SDL::MIX.unload_music(music)
    break
  when SDL::Event::Keyboard
    key = event.sym
    unless activekey.includes? key
      case key
      when .key_1?
        SDL::MIX.play_wav(sounds["high"])
      when .key_2?
        SDL::MIX.play_wav(sounds["medium"])
      when .key_3?
        SDL::MIX.play_wav(sounds["low"])
      when .key_4?
        SDL::MIX.play_wav(sounds["scratch"])
      when .key_9?
        if SDL::MIX.music_paused?
          SDL::MIX.resume_playing_music
        elsif SDL::MIX.music_playing?
          SDL::MIX.pause_music
        else
          SDL::MIX.play_music(music)
        end
      when .key_0?
        SDL::MIX.stop_music
      end
      activekey << key
    end
    activekey.delete key if event.keyup?
  end
  png.blit(window.surface)
  window.update
end
