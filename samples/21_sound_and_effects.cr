require "../src/sdl"
require "../src/image"
require "../src/mix"

SDL.init(SDL::Init::VIDEO | SDL::Init::AUDIO); at_exit { SDL.quit }
SDL::MIX.init(SDL::MIX::Init::MP3); at_exit { SDL::MIX.quit }
SDL::MIX.open

DATA_DIR = File.join(__DIR__, "data")

music = SDL::MIX::Music.new(File.join(DATA_DIR, "beat.wav"))

samples = {} of String => SDL::MIX::Sample
channels = {} of String => SDL::MIX::Channel

%w(high medium low scratch).each_with_index do |name, idx|
  samples[name] = SDL::MIX::Sample.new(File.join(DATA_DIR, "#{name}.wav"))
  channels[name] = SDL::MIX::Channel.new(idx)
end

window = SDL::Window.new("SDL Tutorial", 640, 480)
png = SDL::IMG.load(File.join(__DIR__, "data", "prompt.png"))
png = png.convert(window.surface)
activekey = [] of LibSDL::Keycode

loop do
  case event = SDL::Event.wait
  when SDL::Event::Quit
    music.stop
    SDL::MIX.close
    break
  when SDL::Event::Keyboard
    key = event.sym
    unless activekey.includes? key
      case key
      when .key_1?
        SDL::MIX::Channel.play(samples["high"]) # allocate any free channel
      when .key_2?
        channels["medium"].play(samples["medium"]) # play through specific channel
      when .key_3?
        channels["low"].play(samples["low"])
      when .key_4?
        channels["scratch"].play(samples["scratch"])
      when .key_9?
        if music.paused?
          music.resume
        elsif music.playing?
          music.pause
        else
          music.play
        end
      when .key_0?
        music.resume if music.paused?
        music.stop
      end
      activekey << key
    end
    activekey.delete key if event.keyup?
  end

  png.blit(window.surface)
  window.update
end


#music = SDL::MIX.load_music(File.join(__DIR__, "data", "beat.wav"))
#
#sounds = {} of String => LibMIX::Mix_Chunk*
#names = %w(high medium low scratch)
#names.each do |name|
#  sounds[name] = SDL::MIX.load_wav(File.join(__DIR__, "data", "#{name}.wav"))
#end
#
#window = SDL::Window.new("SDL Tutorial", 640, 480)
#png = SDL::IMG.load(File.join(__DIR__, "data", "prompt.png"))
#png = png.convert(window.surface)
#activekey = [] of LibSDL::Keycode
#
#loop do
#  case event = SDL::Event.wait
#  when SDL::Event::Quit
#    #SDL::MIX.unload_music(music)
#    break
#  when SDL::Event::Keyboard
#    key = event.sym
#    unless activekey.includes? key
#      case key
#      when .key_1?
#        SDL::MIX.play_wav(sounds["high"])
#      when .key_2?
#        SDL::MIX.play_wav(sounds["medium"])
#      when .key_3?
#        SDL::MIX.play_wav(sounds["low"])
#      when .key_4?
#        SDL::MIX.play_wav(sounds["scratch"])
#      when .key_9?
#        if SDL::MIX.music_paused?
#          SDL::MIX.resume_playing_music
#        elsif SDL::MIX.music_playing?
#          SDL::MIX.pause_music
#        else
#          SDL::MIX.play_music(music)
#        end
#      when .key_0?
#        SDL::MIX.stop_music
#      end
#      activekey << key
#    end
#    activekey.delete key if event.keyup?
#  end
#  png.blit(window.surface)
#  window.update
#end
