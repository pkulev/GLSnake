Small SDL and Old OpenGL snake game!

# Installation

The game is packaged for the most popular linux gaming distributions: MacOS and Gentoo.

**MacOS**
```bash
brew tap github.com/pkulev/brew
brew update
brew install pkulev/glsnake
```

**Gentoo**
```bash
sudo eselect repository enable riru
sudo emaint sync -r riru
sudo emerge -av glsnake
```

# Build from sources

## Requirements
- `SDL2`
- `SDL2_ttf`
- `SDL2_mixer` (with Vorbis support for .ogg music)
- Legacy OpenGL 2.1+ (fixed-function pipeline)

## Build
```bash
$ meson setup builddir  # Once, add --wipe if needed to remake builddir.
$ meson compile -C builddir  # Compile and link.
$ builddir/snake  # Run the game!
```
