@[Link("SDL")]
lib LibSDL
  {% if flag?(:darwin) %}
    # should be called from main()
    fun init_quick_draw = SDL_InitQuickDraw(the_qd : Void*)
  {% elsif flag?(:windows) %}
    # should be called from WinMain()
    fun set_module_handle = SDL_SetModuleHandle(hInst : Void*)
  {% else %}
    # may replace main()
    fun main = SDL_main(argc : Int, argv : Char**) : Int
  {% end %}
end
