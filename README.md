# SDL2 bindings for Crystal

Write SDL2 games in Crystal. Support for desktop applications for now, but
Android shouldn't be hard to achieve.

Most of the bindings have been implemented, though most haven't been verified,
yet. Please see the `samples` directory for examples, ported from the tutorials
found at <http://lazyfoo.net/tutorials/SDL/index.php>. You are welcome to port
more samples, and the necessary corrections!

## Requirements

* SDL2 Library
* SDL2_Image
* SDL2_TTF
* SDL2_Mixer

**NOTE:** These are bindings for `sdl2` and not `sdl`. They are different versions of the library.

## SDL2 Library
This is the main library needed.

```text
brew install sdl2
```

## SDL2_Image
This is the SDL2 extension that handles different image formats

Installation for macOS with homebrew
```text
brew install sdl2_image
```

## SDL2_TTF
This is the SDL2 extension that handles using fonts

```text
brew install sdl2_ttf
```

## SDL2_Mixer
This is the SDL2 extension that handles different audio formats

Installation for macOS with homebrew
```text
brew install sdl2_mixer --with-flac --with-fluid-synth --with-libmikmod --with-libmodplug --with-libvorbis --with-smpeg2
```
