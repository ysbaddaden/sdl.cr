require "./scancode"

lib LibSDL
  # :nodoc:
  SDLK_SCANCODE_MASK = 1 << 30

  enum Keycode : UInt32
    UNKNOWN = 0

    RETURN     = 13 # '\r'
    ESCAPE     = 27 # '\033'
    BACKSPACE  =  8 # '\b'
    TAB        =  9 # '\t'
    SPACE      = 32 # ' '
    EXCLAIM    = 33 # '!'
    QUOTEDBL   = 34 # '"'
    HASH       = 35 # '#'
    PERCENT    = 37 # '%'
    DOLLAR     = 38 # '$'
    AMPERSAND  = 38 # '&'
    QUOTE      = 39 # '\''
    LEFTPAREN  = 40 # '('
    RIGHTPAREN = 41 # ')'
    ASTERISK   = 42 # '*'
    PLUS       = 43 # '+'
    COMMA      = 44 # ','
    MINUS      = 45 # '-'
    PERIOD     = 46 # '.'
    SLASH      = 47 # '/'
    KEY_0      = 48 # '0'
    KEY_1      = 49 # '1'
    KEY_2      = 50 # '2'
    KEY_3      = 51 # '3'
    KEY_4      = 52 # '4'
    KEY_5      = 53 # '5'
    KEY_6      = 54 # '6'
    KEY_7      = 55 # '7'
    KEY_8      = 56 # '8'
    KEY_9      = 57 # '9'
    COLON      = 58 # ':'
    SEMICOLON  = 59 # ';'
    LESS       = 60 # '<'
    EQUALS     = 61 # '='
    GREATER    = 62 # '>'
    QUESTION   = 63 # '?'
    AT         = 64 # '@'

    # skip uppercase letters

    LEFTBRACKET  =  91 # '['
    BACKSLASH    =  92 # '\\'
    RIGHTBRACKET =  93 # ']'
    CARET        =  94 # '^'
    UNDERSCORE   =  95 # '_'
    BACKQUOTE    =  96 # '`'
    A            =  97 # 'a'
    B            =  98 # 'b'
    C            =  99 # 'c'
    D            = 100 # 'd'
    E            = 101 # 'e'
    F            = 102 # 'f'
    G            = 103 # 'g'
    H            = 104 # 'h'
    I            = 105 # 'i'
    J            = 106 # 'j'
    K            = 107 # 'k'
    L            = 108 # 'l'
    M            = 109 # 'm'
    N            = 110 # 'n'
    O            = 111 # 'o'
    P            = 112 # 'p'
    Q            = 113 # 'q'
    R            = 114 # 'r'
    S            = 115 # 's'
    T            = 116 # 't'
    U            = 117 # 'u'
    V            = 118 # 'v'
    W            = 119 # 'w'
    X            = 120 # 'x'
    Y            = 121 # 'y'
    Z            = 122 # 'z'

    CAPSLOCK = Scancode::CAPSLOCK | SDLK_SCANCODE_MASK

    F1  = Scancode::F1 | SDLK_SCANCODE_MASK
    F2  = Scancode::F2 | SDLK_SCANCODE_MASK
    F3  = Scancode::F3 | SDLK_SCANCODE_MASK
    F4  = Scancode::F4 | SDLK_SCANCODE_MASK
    F5  = Scancode::F5 | SDLK_SCANCODE_MASK
    F6  = Scancode::F6 | SDLK_SCANCODE_MASK
    F7  = Scancode::F7 | SDLK_SCANCODE_MASK
    F8  = Scancode::F8 | SDLK_SCANCODE_MASK
    F9  = Scancode::F9 | SDLK_SCANCODE_MASK
    F10 = Scancode::F10 | SDLK_SCANCODE_MASK
    F11 = Scancode::F11 | SDLK_SCANCODE_MASK
    F12 = Scancode::F12 | SDLK_SCANCODE_MASK

    PRINTSCREEN = Scancode::PRINTSCREEN | SDLK_SCANCODE_MASK
    SCROLLLOCK  = Scancode::SCROLLLOCK | SDLK_SCANCODE_MASK
    PAUSE       = Scancode::PAUSE | SDLK_SCANCODE_MASK
    INSERT      = Scancode::INSERT | SDLK_SCANCODE_MASK
    HOME        = Scancode::HOME | SDLK_SCANCODE_MASK
    PAGEUP      = Scancode::PAGEUP | SDLK_SCANCODE_MASK
    DELETE      = 127 # '\177'
    END         = Scancode::END | SDLK_SCANCODE_MASK
    PAGEDOWN    = Scancode::PAGEDOWN | SDLK_SCANCODE_MASK
    RIGHT       = Scancode::RIGHT | SDLK_SCANCODE_MASK
    LEFT        = Scancode::LEFT | SDLK_SCANCODE_MASK
    DOWN        = Scancode::DOWN | SDLK_SCANCODE_MASK
    UP          = Scancode::UP | SDLK_SCANCODE_MASK

    NUMLOCKCLEAR = Scancode::NUMLOCKCLEAR | SDLK_SCANCODE_MASK
    KP_DIVIDE    = Scancode::KP_DIVIDE | SDLK_SCANCODE_MASK
    KP_MULTIPLY  = Scancode::KP_MULTIPLY | SDLK_SCANCODE_MASK
    KP_MINUS     = Scancode::KP_MINUS | SDLK_SCANCODE_MASK
    KP_PLUS      = Scancode::KP_PLUS | SDLK_SCANCODE_MASK
    KP_ENTER     = Scancode::KP_ENTER | SDLK_SCANCODE_MASK
    KP_1         = Scancode::KP_1 | SDLK_SCANCODE_MASK
    KP_2         = Scancode::KP_2 | SDLK_SCANCODE_MASK
    KP_3         = Scancode::KP_3 | SDLK_SCANCODE_MASK
    KP_4         = Scancode::KP_4 | SDLK_SCANCODE_MASK
    KP_5         = Scancode::KP_5 | SDLK_SCANCODE_MASK
    KP_6         = Scancode::KP_6 | SDLK_SCANCODE_MASK
    KP_7         = Scancode::KP_7 | SDLK_SCANCODE_MASK
    KP_8         = Scancode::KP_8 | SDLK_SCANCODE_MASK
    KP_9         = Scancode::KP_9 | SDLK_SCANCODE_MASK
    KP_0         = Scancode::KP_0 | SDLK_SCANCODE_MASK
    KP_PERIOD    = Scancode::KP_PERIOD | SDLK_SCANCODE_MASK

    APPLICATION    = Scancode::APPLICATION | SDLK_SCANCODE_MASK
    POWER          = Scancode::POWER | SDLK_SCANCODE_MASK
    KP_EQUALS      = Scancode::KP_EQUALS | SDLK_SCANCODE_MASK
    F13            = Scancode::F13 | SDLK_SCANCODE_MASK
    F14            = Scancode::F14 | SDLK_SCANCODE_MASK
    F15            = Scancode::F15 | SDLK_SCANCODE_MASK
    F16            = Scancode::F16 | SDLK_SCANCODE_MASK
    F17            = Scancode::F17 | SDLK_SCANCODE_MASK
    F18            = Scancode::F18 | SDLK_SCANCODE_MASK
    F19            = Scancode::F19 | SDLK_SCANCODE_MASK
    F20            = Scancode::F20 | SDLK_SCANCODE_MASK
    F21            = Scancode::F21 | SDLK_SCANCODE_MASK
    F22            = Scancode::F22 | SDLK_SCANCODE_MASK
    F23            = Scancode::F23 | SDLK_SCANCODE_MASK
    F24            = Scancode::F24 | SDLK_SCANCODE_MASK
    EXECUTE        = Scancode::EXECUTE | SDLK_SCANCODE_MASK
    HELP           = Scancode::HELP | SDLK_SCANCODE_MASK
    MENU           = Scancode::MENU | SDLK_SCANCODE_MASK
    SELECT         = Scancode::SELECT | SDLK_SCANCODE_MASK
    STOP           = Scancode::STOP | SDLK_SCANCODE_MASK
    AGAIN          = Scancode::AGAIN | SDLK_SCANCODE_MASK
    UNDO           = Scancode::UNDO | SDLK_SCANCODE_MASK
    CUT            = Scancode::CUT | SDLK_SCANCODE_MASK
    COPY           = Scancode::COPY | SDLK_SCANCODE_MASK
    PASTE          = Scancode::PASTE | SDLK_SCANCODE_MASK
    FIND           = Scancode::FIND | SDLK_SCANCODE_MASK
    MUTE           = Scancode::MUTE | SDLK_SCANCODE_MASK
    VOLUMEUP       = Scancode::VOLUMEUP | SDLK_SCANCODE_MASK
    VOLUMEDOWN     = Scancode::VOLUMEDOWN | SDLK_SCANCODE_MASK
    KP_COMMA       = Scancode::KP_COMMA | SDLK_SCANCODE_MASK
    KP_EQUALSAS400 = Scancode::KP_EQUALSAS400 | SDLK_SCANCODE_MASK

    ALTERASE   = Scancode::ALTERASE | SDLK_SCANCODE_MASK
    SYSREQ     = Scancode::SYSREQ | SDLK_SCANCODE_MASK
    CANCEL     = Scancode::CANCEL | SDLK_SCANCODE_MASK
    CLEAR      = Scancode::CLEAR | SDLK_SCANCODE_MASK
    PRIOR      = Scancode::PRIOR | SDLK_SCANCODE_MASK
    RETURN2    = Scancode::RETURN2 | SDLK_SCANCODE_MASK
    SEPARATOR  = Scancode::SEPARATOR | SDLK_SCANCODE_MASK
    OUT        = Scancode::OUT | SDLK_SCANCODE_MASK
    OPER       = Scancode::OPER | SDLK_SCANCODE_MASK
    CLEARAGAIN = Scancode::CLEARAGAIN | SDLK_SCANCODE_MASK
    CRSEL      = Scancode::CRSEL | SDLK_SCANCODE_MASK
    EXSEL      = Scancode::EXSEL | SDLK_SCANCODE_MASK

    KP_00              = Scancode::KP_00 | SDLK_SCANCODE_MASK
    KP_000             = Scancode::KP_000 | SDLK_SCANCODE_MASK
    THOUSANDSSEPARATOR = Scancode::THOUSANDSSEPARATOR | SDLK_SCANCODE_MASK
    DECIMALSEPARATOR   = Scancode::DECIMALSEPARATOR | SDLK_SCANCODE_MASK
    CURRENCYUNIT       = Scancode::CURRENCYUNIT | SDLK_SCANCODE_MASK
    CURRENCYSUBUNIT    = Scancode::CURRENCYSUBUNIT | SDLK_SCANCODE_MASK
    KP_LEFTPAREN       = Scancode::KP_LEFTPAREN | SDLK_SCANCODE_MASK
    KP_RIGHTPAREN      = Scancode::KP_RIGHTPAREN | SDLK_SCANCODE_MASK
    KP_LEFTBRACE       = Scancode::KP_LEFTBRACE | SDLK_SCANCODE_MASK
    KP_RIGHTBRACE      = Scancode::KP_RIGHTBRACE | SDLK_SCANCODE_MASK
    KP_TAB             = Scancode::KP_TAB | SDLK_SCANCODE_MASK
    KP_BACKSPACE       = Scancode::KP_BACKSPACE | SDLK_SCANCODE_MASK
    KP_A               = Scancode::KP_A | SDLK_SCANCODE_MASK
    KP_B               = Scancode::KP_B | SDLK_SCANCODE_MASK
    KP_C               = Scancode::KP_C | SDLK_SCANCODE_MASK
    KP_D               = Scancode::KP_D | SDLK_SCANCODE_MASK
    KP_E               = Scancode::KP_E | SDLK_SCANCODE_MASK
    KP_F               = Scancode::KP_F | SDLK_SCANCODE_MASK
    KP_XOR             = Scancode::KP_XOR | SDLK_SCANCODE_MASK
    KP_POWER           = Scancode::KP_POWER | SDLK_SCANCODE_MASK
    KP_PERCENT         = Scancode::KP_PERCENT | SDLK_SCANCODE_MASK
    KP_LESS            = Scancode::KP_LESS | SDLK_SCANCODE_MASK
    KP_GREATER         = Scancode::KP_GREATER | SDLK_SCANCODE_MASK
    KP_AMPERSAND       = Scancode::KP_AMPERSAND | SDLK_SCANCODE_MASK
    KP_DBLAMPERSAND    = Scancode::KP_DBLAMPERSAND | SDLK_SCANCODE_MASK
    KP_VERTICALBAR     = Scancode::KP_VERTICALBAR | SDLK_SCANCODE_MASK
    KP_DBLVERTICALBAR  = Scancode::KP_DBLVERTICALBAR | SDLK_SCANCODE_MASK
    KP_COLON           = Scancode::KP_COLON | SDLK_SCANCODE_MASK
    KP_HASH            = Scancode::KP_HASH | SDLK_SCANCODE_MASK
    KP_SPACE           = Scancode::KP_SPACE | SDLK_SCANCODE_MASK
    KP_AT              = Scancode::KP_AT | SDLK_SCANCODE_MASK
    KP_EXCLAM          = Scancode::KP_EXCLAM | SDLK_SCANCODE_MASK
    KP_MEMSTORE        = Scancode::KP_MEMSTORE | SDLK_SCANCODE_MASK
    KP_MEMRECALL       = Scancode::KP_MEMRECALL | SDLK_SCANCODE_MASK
    KP_MEMCLEAR        = Scancode::KP_MEMCLEAR | SDLK_SCANCODE_MASK
    KP_MEMADD          = Scancode::KP_MEMADD | SDLK_SCANCODE_MASK
    KP_MEMSUBTRACT     = Scancode::KP_MEMSUBTRACT | SDLK_SCANCODE_MASK
    KP_MEMMULTIPLY     = Scancode::KP_MEMMULTIPLY | SDLK_SCANCODE_MASK
    KP_MEMDIVIDE       = Scancode::KP_MEMDIVIDE | SDLK_SCANCODE_MASK
    KP_PLUSMINUS       = Scancode::KP_PLUSMINUS | SDLK_SCANCODE_MASK
    KP_CLEAR           = Scancode::KP_CLEAR | SDLK_SCANCODE_MASK
    KP_CLEARENTRY      = Scancode::KP_CLEARENTRY | SDLK_SCANCODE_MASK
    KP_BINARY          = Scancode::KP_BINARY | SDLK_SCANCODE_MASK
    KP_OCTAL           = Scancode::KP_OCTAL | SDLK_SCANCODE_MASK
    KP_DECIMAL         = Scancode::KP_DECIMAL | SDLK_SCANCODE_MASK
    KP_HEXADECIMAL     = Scancode::KP_HEXADECIMAL | SDLK_SCANCODE_MASK

    LCTRL  = Scancode::LCTRL | SDLK_SCANCODE_MASK
    LSHIFT = Scancode::LSHIFT | SDLK_SCANCODE_MASK
    LALT   = Scancode::LALT | SDLK_SCANCODE_MASK
    LGUI   = Scancode::LGUI | SDLK_SCANCODE_MASK
    RCTRL  = Scancode::RCTRL | SDLK_SCANCODE_MASK
    RSHIFT = Scancode::RSHIFT | SDLK_SCANCODE_MASK
    RALT   = Scancode::RALT | SDLK_SCANCODE_MASK
    RGUI   = Scancode::RGUI | SDLK_SCANCODE_MASK

    MODE = Scancode::MODE | SDLK_SCANCODE_MASK

    AUDIONEXT    = Scancode::AUDIONEXT | SDLK_SCANCODE_MASK
    AUDIOPREV    = Scancode::AUDIOPREV | SDLK_SCANCODE_MASK
    AUDIOSTOP    = Scancode::AUDIOSTOP | SDLK_SCANCODE_MASK
    AUDIOPLAY    = Scancode::AUDIOPLAY | SDLK_SCANCODE_MASK
    AUDIOMUTE    = Scancode::AUDIOMUTE | SDLK_SCANCODE_MASK
    MEDIASELECT  = Scancode::MEDIASELECT | SDLK_SCANCODE_MASK
    WWW          = Scancode::WWW | SDLK_SCANCODE_MASK
    MAIL         = Scancode::MAIL | SDLK_SCANCODE_MASK
    CALCULATOR   = Scancode::CALCULATOR | SDLK_SCANCODE_MASK
    COMPUTER     = Scancode::COMPUTER | SDLK_SCANCODE_MASK
    AC_SEARCH    = Scancode::AC_SEARCH | SDLK_SCANCODE_MASK
    AC_HOME      = Scancode::AC_HOME | SDLK_SCANCODE_MASK
    AC_BACK      = Scancode::AC_BACK | SDLK_SCANCODE_MASK
    AC_FORWARD   = Scancode::AC_FORWARD | SDLK_SCANCODE_MASK
    AC_STOP      = Scancode::AC_STOP | SDLK_SCANCODE_MASK
    AC_REFRESH   = Scancode::AC_REFRESH | SDLK_SCANCODE_MASK
    AC_BOOKMARKS = Scancode::AC_BOOKMARKS | SDLK_SCANCODE_MASK

    BRIGHTNESSDOWN = Scancode::BRIGHTNESSDOWN | SDLK_SCANCODE_MASK
    BRIGHTNESSUP   = Scancode::BRIGHTNESSUP | SDLK_SCANCODE_MASK
    DISPLAYSWITCH  = Scancode::DISPLAYSWITCH | SDLK_SCANCODE_MASK
    KBDILLUMTOGGLE = Scancode::KBDILLUMTOGGLE | SDLK_SCANCODE_MASK
    KBDILLUMDOWN   = Scancode::KBDILLUMDOWN | SDLK_SCANCODE_MASK
    KBDILLUMUP     = Scancode::KBDILLUMUP | SDLK_SCANCODE_MASK
    EJECT          = Scancode::EJECT | SDLK_SCANCODE_MASK
    SLEEP          = Scancode::SLEEP | SDLK_SCANCODE_MASK
  end

  enum Keymod : UInt16
    NONE     = 0x0000
    LSHIFT   = 0x0001
    RSHIFT   = 0x0002
    LCTRL    = 0x0040
    RCTRL    = 0x0080
    LALT     = 0x0100
    RALT     = 0x0200
    LGUI     = 0x0400
    RGUI     = 0x0800
    NUM      = 0x1000
    CAPS     = 0x2000
    MODE     = 0x4000
    RESERVED = 0x8000

    CTRL  = LCTRL | RCTRL
    SHIFT = LSHIFT | RSHIFT
    ALT   = LALT | RALT
    GUI   = LGUI | RGUI
  end
end
