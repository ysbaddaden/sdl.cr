require "./lib_mixer"
require "./sdl"

module SDL
  module Mixer
    alias Init = LibMixer::Init
    
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
      ret = LibMixer.init(flags)
      unless (ret & flags.value) == flags.value
        raise SDL::Error.new("Mix_Init failed to init #{flags}")
      end
    end

    def self.quit
      LibMixer.quit
    end

    # This is required to initial SDL_Mixer. It must be called before using any other function, but AFTER SDL has been initialized.
    def self.open(frequency = 44100, format = LibMixer::MIX_DEFAULT_FORMAT, channels = 2, sample_size = 2048)
      ret = LibMixer.open_audio(frequency, format, channels, sample_size)
      if ret == 0
        # audio is loaded
      else
        # an error has occurred
      end
    end

    # load long sound file
    def self.load_music(filename, type : Type? = nil)
      rwops = LibSDL.rw_from_file(filename, "rb")
      if type
        audio = LibMixer.load_mus_type_rw(rwops, type.to_s, 1)
        raise SDL::Error.new("Mix_LoadMUSType_RW") unless audio
      else
        audio = LibMixer.load_mus_rw(rwops, 1)
        raise SDL::Error.new("Mix_LoadMUS_RW") unless audio
      end
      audio
    end

    # free long sound file
    def self.unload_music(music)
      LibMixer.free_music(music)
    end

    # -1 is repeat until stopped
    def self.play_music(music, repeats = -1)
      LibMixer.play_music(music, repeats)
    end

    def self.pause_music
      LibMixer.pause_music
    end

    def self.stop_music
      LibMixer.halt_music
    end

    def self.music_paused?
      LibMixer.music_paused == 1
    end

    def self.music_playing?
      LibMixer.music_playing == 1
    end

    def self.resume_playing_music
      LibMixer.resume_music
    end

    def self.rewind_music
      LibMixer.rewind_music
    end

    def self.fade_in_music(music, loops = -1, ms = 1000)
      LibMixer.fade_in_music(music, loops, ms)
    end

    def self.fade_out_music(ms = 1000)
      LibMixer.fade_out_music(ms)
    end

    # load short sound file
    def self.load_wav(filename)
      rwops = LibSDL.rw_from_file(filename, "rb")
      audio = LibMixer.load_wav_rw(rwops, 1)
      raise SDL::Error.new("Mix_LoadWAV_RW") unless audio
      audio
    end

    # free short sound file
    def self.unload_wav(sound)
      LibMixer.free_chunk(sound)
    end

    # -1 for channel is the nearest channel.
    # 0 repeats is play once
    def self.play_wav(sound, channel = -1, repeats = 0, ticks = -1)
      LibMixer.play_channel_timed(channel, sound, repeats, ticks)
    end
  end
end
