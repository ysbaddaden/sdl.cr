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

    def self.init(flags : Init)
      ret = LibMixer.init(flags)
      unless (ret & flags.value) == flags.value
        raise SDL::Error.new("Mix_Init failed to init #{flags}")
      end
    end

    def self.quit
      LibMixer.quit
    end
  end
end
