module SDL
  module Timer
    
    def self.add(interval, &callback : UInt32 -> Void)
      LibSDL.add_timer(interval, callback)
    end

    def self.ticks
      LibSDL.get_ticks
    end
  end
end
