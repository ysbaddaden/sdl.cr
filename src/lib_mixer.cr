require "./lib_sdl"

@[Link("SDL2_mixer")]
lib LibMixer
  alias Int = LibC::Int
  alias Char = LibC::Char

  alias RWops = LibSDL::RWops

  VERSION = {% `pkg-config SDL2_mixer --modversion`.strip %}
  MAJOR = {% VERSION.split('.')[0] %}
  MINOR = {% VERSION.split('.')[1] %}
  PATCH = {% VERSION.split('.')[2] %}
  
  @[Flags]
  enum Init
    FLAC       = 0x00000001
    MOD        = 0x00000002
    MODPLUG    = 0x00000004
    MP3        = 0x00000008
    OGG        = 0x00000010
    FLUIDSYNTH = 0x00000020
  end

  enum MusicType
    MUS_NONE
    MUS_CMD
    MUS_WAV
    MUS_MOD
    MUS_MID
    MUS_OGG
    MUS_MP3
    MUS_MP3_MAD
    MUS_FLAC
    MUS_MODPLUG
  end

  struct MusicCMD
    file : Int*
    cmd : Int*
  end

  struct Mix_Chunk
    allocated : Int
    abuf : UInt8*
    alen : UInt32
    volume : UInt8
  end
  alias Chunk = Mix_Chunk

  struct WAVStream
    src : RWops*
    freesrc : Bool
    numloops : Int
  end

  union Data
    cmd : MusicCMD*
    wave : WAVStream*
    #mp3 : SMPEG*
    #ogg : OGG_music*
  end
  struct Mix_Music
    type : MusicType
    data : Data
  end
  alias Music = Mix_Music

  MIX_DEFAULT_FORMAT = LibSDL::AUDIO_S16LSB

  fun init = Mix_Init(flags : Init) : Int
  fun quit = Mix_Quit()

  fun open_audio = Mix_OpenAudio(frequency : Int, format : UInt16, channels : Int, chunksize : Int) : Int
  fun open_audio_device = Mix_OpenAudioDevice(frequency : Int, format : UInt16) : Int
  
  fun allocate_channels = Mix_AllocateChannels(numchans : Int) : Int
  fun query_spec = Mix_QuerySpec(frequency : Int*, format : UInt16*, channels : Int*) : Int
  fun load_wav_rw = Mix_LoadWAV_RW(src : RWops*, freesrc : Int) : Chunk*
  fun load_mus = Mix_LoadMUS(file : Char*) : Music*
  fun load_mus_rw = Mix_LoadMUS_RW(src : RWops*, freesrc : Int) : Music*
  fun load_mus_type_rw = Mix_LoadMUSType_RW(src : RWops*, type : MusicType, freesrc : Int) : Music*
  fun quick_load_wav = Mix_QuickLoad_WAV(mem : UInt8*) : Chunk*
  fun quick_load_raw = Mix_QuickLoad_RAW(mem : UInt8*, len : UInt32) : Chunk*
  fun free_chunk = Mix_FreeChunk(chunk : Chunk*)
  fun free_music = Mix_FreeMusic(music : Music*)
  fun get_num_chunk_decoders = Mix_GetNumChunkDecoders() : Int
  fun get_chunk_decoder = Mix_GetChunkDecoder(index : Int) : Char*
  fun get_num_music_decoders = Mix_GetNumMusicDecoders() : Int
  fun get_music_decoder = Mix_GetMusicDecoder(index : Int) : Char*
  fun get_music_type = Mix_GetMusicType(music : Music*) : MusicType
  fun get_music_hook_data = Mix_GetMusicHookData()

  fun play_channel_timed = Mix_PlayChannelTimed(channel : Int, chunk : Chunk*, loops : Int, ticks : Int) : Int
  fun play_music = Mix_PlayMusic(music : Music*, loops : Int) : Int

  fun music_playing = Mix_PlayingMusic() : Int
  fun music_paused = Mix_PausedMusic() : Int
  fun rewind_music = Mix_RewindMusic()
  fun resume_music = Mix_ResumeMusic()
  fun pause_music = Mix_PauseMusic()
  fun halt_music = Mix_HaltMusic() : Int
end
