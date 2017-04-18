require "./lib_mix"
require "./sdl"

module SDL
  module MIX
    alias Init = LibMIX::Init
    MAX_VOLUME = 128
    
    enum Type
      AIFF
      FLAC
      MIDI
      MOD
      MP3
      OGG
      VOC
      WAV
    end

    # Used to load the support for the flags. `quit` must be called during app cleanup
    def self.init(flags : Init)
      ret = LibMIX.init(flags)
      unless (ret & flags.value) == flags.value
        raise SDL::Error.new("Mix_Init failed to init #{flags}")
      end
    end

    def self.quit
      LibMIX.quit
    end

    # This is required to initial SDL_Mixer. It must be called before using any other function, but AFTER SDL has been initialized.
    def self.open(freq = 44100, format = 0_u16, channels = 2, sample_size = 2048)
      format = format == 0 ? LibMIX::MIX_DEFAULT_FORMAT : format.to_u16
      ret = LibMIX.open_audio(freq, format, channels, sample_size)
      raise SDL::Error.new("Mix_OpenAudio") unless ret == 0
      ret
    end

    # load long sound file
    def self.load_music(filename, type : Type? = nil)
      rwops = LibSDL.rw_from_file(filename, "rb")
      if type
        audio = LibMIX.load_mus_type_rw(rwops, type.to_s, 1)
        raise SDL::Error.new("Mix_LoadMUSType_RW") unless audio
      else
        audio = LibMIX.load_mus_rw(rwops, 1)
        raise SDL::Error.new("Mix_LoadMUS_RW") unless audio
      end
      audio
    end

    # free long sound file
    def self.unload_music(music)
      LibMIX.free_music(music)
    end

    # -1 is repeat until stopped
    def self.play_music(music, repeats = -1)
      LibMIX.play_music(music, repeats)
    end

    def self.pause_music
      LibMIX.pause_music
    end

    def self.stop_music
      LibMIX.halt_music
    end

    def self.music_paused?
      LibMIX.music_paused == 1
    end

    def self.music_playing?
      LibMIX.music_playing == 1
    end

    def self.resume_playing_music
      LibMIX.resume_music
    end

    def self.rewind_music
      LibMIX.rewind_music
    end

    def self.fade_in_music(music, loops = -1, ms = 1000)
      LibMIX.fade_in_music(music, loops, ms)
    end

    def self.fade_out_music(ms = 1000)
      LibMIX.fade_out_music(ms)
    end

    def self.music_volume=(volume)
      LibMIX.music_volume(volume > MAX_VOLUME ? MAX_VOLUME : volume)
    end

    def self.music_volume()
      LibMIX.music_volume(-1)
    end

    # load short sound file
    def self.load_wav(filename)
      rwops = LibSDL.rw_from_file(filename, "rb")
      audio = LibMIX.load_wav_rw(rwops, 1)
      raise SDL::Error.new("Mix_LoadWAV_RW") unless audio
      audio
    end

    # free short sound file
    def self.unload_wav(sound)
      LibMIX.free_chunk(sound)
    end

    # -1 for channel is the nearest channel.
    # 0 repeats is play once
    def self.play_wav(sound, channel = -1, repeats = 0, ticks = -1)
      LibMIX.play_channel_timed(channel, sound, repeats, ticks)
    end
  end
end
