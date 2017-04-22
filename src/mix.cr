require "./lib_mix"
require "./sdl"

module SDL
  module MIX
    alias Init = LibMIX::Init
    MAX_VOLUME = LibMIX::MIN_MAX_VOLUME
    
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

    def self.query_spec(freq = 44100, format = 0_u16, channels = 2)
      audio_open_count = LibMIX.query_spec(freq, format, channels)
      raise SDL::Error.new("Mix_QuerySpec: #{LibMIX.get_error}") if audio_open_count < 1
      audio_open_count
    end

    def self.close
      LibMIX.close_audio
    end

  end

  module MIX
    class Sample
      protected getter sample

      def self.decoder_count
        LibMIX.get_num_chunk_decoders
      end

      def self.decoder_name(index)
        LibMIX.get_chunk_decoder(index)
      end

      def initialize(filename = nil)
        load filename if filename
      end

      def load(filename)
        SDL::RWops.open(filename, "rb") do |rwops|
          @sample = LibMIX.load_wav_rw(rwops, 1)
          raise SDL::Error.new("Mix_LoadWAV_RW") unless @sample
          @sample
        end
      end

      def finalize
        LibMIX.free_chunk(sample)
      end
    end
  end

  module MIX
    class Music
      private getter music : Pointer(LibMIX::Music) | Nil

      def initialize(filename = nil)
        @music = filename ? load(filename) : nil
      end

      def play(repeats = -1)
        LibMIX.play_music(music, repeats)
      end

      def pause
        LibMIX.pause_music
      end

      def resume
        LibMIX.resume_music
      end

      def stop
        LibMIX.halt_music
      end

      def playing?
        LibMIX.music_playing == 1
      end

      def paused?
        LibMIX.music_paused == 1
      end

      def rewind
        LibMIX.rewind_music
      end

      def fade_in(loops = -1, msec = 1000)
        LibMIX.fade_in_music(music, loops, msec)
      end

      def fade_out(msec = 1000)
        LibMIX.fade_out_music(msec)
      end

      def volume=(volume)
        LibMIX.music_volume(volume > MAX_VOLUME ? MAX_VOLUME : volume)
      end

      def volume
        LibMIX.music_volume(-1)
      end

      def load(filename, type : Type? = nil)
        SDL::RWops.open(filename, "rb") do |rwops|
          if type
            @music = load_music_type(rwops, type)
          else
            @music = load_music(rwops)
          end
          @music
        end
      end

      def finalize
        LibMIX.free_music(music)
        @music = nil
      end

      private def load_music(rwops)
        audio = LibMIX.load_mus_rw(rwops, 1)
        raise SDL::Error.new("Mix_LoadMUSType_RW") unless audio
        audio
      end

      private def load_music_type(rwops, typ)
        audio = LibMIX.load_mus_type_rw(rwops, typ.to_s, 1)
        raise SDL::Error.new("Mix_LoadMUS_RW") unless audio
        audio
      end
    end
  end

  module MIX
    class Channel
      property id

      def initialize(@id = 1)
        @@count ||= 8 unless @@count
      end

      def self.allocate_channels(count)
        @@count = count
        LibMIX.allocate_channels(count)
      end

      def self.reserve_channels(count)
        @@reserved = count
        LibMIX.reserve_channels(count)
      end

      def self.play(smpl, repeats = 0)
        LibMIX.play_channel(-1, smpl.sample, repeats)
      end

      def self.play(smpl, repeats = 0, ticks = -1)
        LibMIX.play_channel_timed(-1, smpl.sample, repeats, ticks)
      end

      def self.fade_in(smpl : Sample, loops = 0, ms = 1000, ticks = -1)
        LibMIX.fade_in_channel(-1, smpl.sample, loops, ms, ticks)
      end

      def self.fade_out(ms = 1000)
        LibMIX.fade_out_channel(-1, ms)
      end

      def self.resume
        LibMIX.resume_music(-1)
      end

      def self.expire(ticks)
        LibMIX.channel_expire(-1, ticks)
      end

      def self.channels
        @@count || 0
      end

      def self.reserved
        @@reserved || 0
      end

      def self.volume=(volume)
        LibMIX.channel_volume(-1, volume > MAX_VOLUME ? MAX_VOLUME : volume)
      end

      def self.paused_count
        LibMIX.channel_paused(-1)
      end

      def self.finished(func)
        LibMIX.cb_channel_finished(func)
      end

      def play(smpl, repeats = 0)
        LibMIX.play_channel(id, smpl.sample, repeats)
      end

      def play(smpl, repeats = 0, ticks = -1)
        LibMIX.play_channel_timed(id, smpl.sample, repeats, ticks)
      end

      def fade_in(smpl : Sample, loops = 0, ms = 1000, ticks = -1)
        LibMIX.fade_in_channel(id, smpl.sample, loops, ms, ticks)
      end

      def fade_out(ms = 1000)
        LibMIX.fade_out_channel(id, ms)
      end

      def expire
        LibMIX.channel_expire(id, ticks)
      end

      def fading?
        LibMIX.fading? id
      end

      def paused?
        LibMIX.channel_paused(id) == 1
      end

      def volume=(volume)
        LibMIX.channel_volume(id, volume > MAX_VOLUME ? MAX_VOLUME : volume)
      end

      def volume
        LibMIX.channel_volume(id, -1)
      end
    end
  end
end
