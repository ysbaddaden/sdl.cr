require "../src/sdl"
require "../src/image"
require "../src/ttf"

SDL.init(SDL::Init::VIDEO); at_exit { SDL.quit }
SDL::TTF.init; at_exit { SDL::TTF.quit }

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window, SDL::Renderer::Flags::ACCELERATED | SDL::Renderer::Flags::PRESENTVSYNC)

font = SDL::TTF::Font.new(File.join(__DIR__, "data", "lazy.ttf"), 28)
font_color = SDL::Color[0, 0, 0, 255]

renderer.draw_color = SDL::Color[255, 255, 255, 255]
bg_color = renderer.draw_color
start_prompt_surface = font.render_shaded("Press S to Start or Stop the Timer", font_color, bg_color)
pause_prompt_surface = font.render_shaded("Press P to Pause or Unpause the Timer", font_color, bg_color)

class SampleTimer
  property started : Bool = false
  property paused : Bool = false
  property start_ticks : UInt32 = 0_u32
  property paused_ticks : UInt32 = 0_u32

  def ticks
    time = 0
    if started?
      if paused?
        time = @paused_ticks
      else
        time = SDL::Timer.ticks - @start_ticks
      end
    end
    time
  end

  def start
    @started = true
    @paused = false
    @start_ticks = SDL::Timer.ticks
    @paused_ticks = 0_u32
  end

  def stop
    @started = false
    @paused = false
    @start_ticks = 0_u32
    @paused_ticks = 0_u32
  end

  def started?
    @started
  end

  def toggle_on_state
    started? ? stop : start
  end

  def pause
    unless paused?
      @paused = true
      @paused_ticks = SDL::Timer.ticks - @start_ticks
      @start_ticks = 0_u32
    end
  end

  def unpause
    if paused?
      @paused = false
      @start_ticks = SDL::Timer.ticks - @paused_ticks
      @paused_ticks = 0_u32
    end
  end

  def paused?
    @paused && @started
  end

  def toggle_pause_state
    paused? ? unpause : pause
  end
end

timer = SampleTimer.new

loop do
  case event = SDL::Event.poll
  when SDL::Event::Quit
    break
  when SDL::Event::Keyboard
    if event.keydown?
      case event.sym
      when .s?
        timer.toggle_on_state
      when .p?
        timer.toggle_pause_state
      end
    end
  end
  renderer.clear
  # Render the start prompt text
  start_prompt_x = (window.width - start_prompt_surface.width) / 2
  renderer.copy(start_prompt_surface, dstrect: SDL::Rect[start_prompt_x, 0, start_prompt_surface.width, start_prompt_surface.height])

  # Render the pause prompt text
  pause_prompt_x = (window.width - pause_prompt_surface.width) / 2
  renderer.copy(pause_prompt_surface, dstrect: SDL::Rect[pause_prompt_x, start_prompt_surface.height, pause_prompt_surface.width, pause_prompt_surface.height])

  # Render the action text
  time_text_surface = font.render_shaded("Seconds since start time #{timer.ticks / 1000.0}", font_color, bg_color)
  time_text_x = (window.width - time_text_surface.width) / 2
  time_text_y = (window.height - time_text_surface.height) / 2
  renderer.copy(time_text_surface, dstrect: SDL::Rect[time_text_x, time_text_y, time_text_surface.width, time_text_surface.height])

  renderer.present
end

