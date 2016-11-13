@[Link("SDL")]
lib LibSDL
  # (userdata, stream, len)
  alias AudioCallback = (Void*, UInt8*, Int) -> Void

  struct AudioSpec
	freq : Int
	format : UInt16
	channels : UInt8
	silence : UInt8
	samples : UInt16
	padding : UInt16
	size : UInt32
    callback : AudioCallback*
	userdata : Void*
  end

  AUDIO_U8     = 0x0008
  AUDIO_S8     = 0x8008
  AUDIO_U16LSB = 0x0010
  AUDIO_S16LSB = 0x8010
  AUDIO_U16MSB = 0x1010
  AUDIO_S16MSB = 0x9010
  AUDIO_U16 = AUDIO_U16LSB
  AUDIO_S16 = AUDIO_S16LSB

  # LITTLE ENDIAN
  AUDIO_U16SYS = AUDIO_U16LSB
  AUDIO_S16SYS = AUDIO_S16LSB

  # BIG ENDIAN
  #AUDIO_U16SYS = AUDIO_U16MSB
  #AUDIO_S16SYS = AUDIO_S16MSB

  # (cvt, format)
  alias AudioFilter = (AudioCVT*, UInt16) -> Void

  struct AudioCVT
	needed : Int
	src_format : UInt16
	dst_format : UInt16
	rate_incr : Double
	buf : UInt8*
	len : Int
	len_cvt : Int
	len_mult : Int
	len_ratio : Double
    filters : StaticArray(AudioFilter*, 10)
	filter_index : Int
  end

  fun audio_init = SDL_AudioInit(driver_name : Char*) : Int
  fun audio_quit = SDL_AudioQuit()
  fun audio_driver_name = SDL_AudioDriverName(namebuf : Char*, maxlen : Int) : Char*

  fun open_audio = SDL_OpenAudio(desierd : AudioSpec*, obtained : AudioSpec*) : Int

  enum AudioStatus
	STOPPED = 0
	PLAYING= 1
    PAUSED
  end
  fun get_audio_status = SDL_GetAudioStatus() : AudioStatus

  fun pause_audio = SDL_PauseAudio(pause_on : Int)
  fun load_wav_rw = SDL_LoadWAV_RW(src : RWops, freesrc : Int, spec : AudioSpec*, audio_buf : UInt8**, audio_len : UInt32*)
  fun free_wav = SDL_FreeWAV(audio_buf : UInt8)
  fun build_audio_cvt = SDL_BuildAudioCVT(
    cvt : AudioCVT*,
    src_format : UInt16, src_channels : UInt8, src_rate : Int,
    dst_format : UInt16, dst_channels : UInt8, dst_rate : Int
  )
  fun convert_audio = SDL_ConvertAudio(cvt : AudioCVT*) : Int

  MIX_MAXVOLUME = 128
  fun mix_audio = SDL_MixAudio(dst : UInt8*, src : UInt8*, len : UInt32, volume : Int)

  fun lock_audio = SDL_LockAudio()
  fun unlock_audio = SDL_UnlockAudio()

  fun close_audio = SDL_CloseAudio()
end
