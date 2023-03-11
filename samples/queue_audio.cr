require "../src/sdl"

CHANNELS    =     1
BUFFER_SIZE =  4096
SAMPLE_RATE = 44100

SDL.init(SDL::Init::AUDIO)
at_exit { SDL.quit }

audiospec = LibSDL::AudioSpec.new
audiospec.freq = SAMPLE_RATE
audiospec.format = LibSDL::AUDIO_F32SYS
audiospec.channels = CHANNELS
audiospec.samples = BUFFER_SIZE
audiospec.callback = nil
audiospec.userdata = nil

obtained_spec = LibSDL::AudioSpec.new

raise "Failed to open audio" if LibSDL.open_audio(pointerof(audiospec), pointerof(obtained_spec)) > 0

LibSDL.pause_audio 0

amp = 0.25
freq = 500
time = 0.0
delta_time = 1 / SAMPLE_RATE
buffer = Slice(Float32).new BUFFER_SIZE

loop do
  BUFFER_SIZE.times do |sample| # fill buffer with simple sine wave
    value = amp * Math.sin(2 * Math::PI * freq * time)
    buffer[sample] = value.to_f32
    time += delta_time
  end
  while LibSDL.get_queued_audio_size(1) > BUFFER_SIZE * sizeof(Float32) * 2 # delay until we need more buffered audio
    LibSDL.delay(1)
  end
  LibSDL.queue_audio(1, buffer, BUFFER_SIZE * sizeof(Float32))
end
