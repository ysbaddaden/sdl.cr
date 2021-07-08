module SDL
  module Timer
    
    def self.add(interval, &callback : UInt32 -> Void)
      LibSDL.add_timer(interval, callback)
    end

    def self.delay(ms : UInt32)
      LibSDL.delay(ms)
    end

    def self.performance_counter
      LibSDL.get_performance_counter
    end

    def self.performance_frequency
      LibSDL.get_performance_frequency
    end

    def self.ticks
      LibSDL.get_ticks
    end

    def self.remove(timer_id)
      LibSDL.remove_timer(timer_id)
    end
  end
end
