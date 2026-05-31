Small SDL and Old OpenGL snake game!

# Installation

The game is packaged for the most popular linux gaming distributions: MacOS and Gentoo.

**MacOS**
```bash
brew tap pkulev/homebrew-riru
brew install glsnake
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
- `SDL2_mixer` (with Vorbis support for `.ogg` music)
- Legacy OpenGL 2.1+ (fixed-function pipeline)
- `pkg-config`
- [Meson](https://mesonbuild.com/)

## Linux / MacOS

```bash
$ meson setup build       # Once, add --wipe if needed to remake build dir.
$ meson compile -C build  # Compile and link.
$ build/snake             # Run the game!
```

## Windows (MSVC, command line)

Native Windows builds use **Meson + MSVC (`cl.exe`) + Ninja + vcpkg**, no need to open Visual Studio!

You will need those things (use winget, choco or scoop, they help):

| Tool           | Notes                                                                                   |
|----------------|-----------------------------------------------------------------------------------------|
| **MSVC**       | Visual Studio Build Tools or full VS with the **Desktop development with C++** workload |
| **Meson**      | `scoop install meson`                                                                   |
| **vcpkg**      | `scoop install vcpkg`                                                                   |
| **pkg-config** | `scoop install pkg-config` (reads vcpkg `.pc` files)                                    |

Dependencies are declared in [`vcpkg.json`](vcpkg.json).

### Build
```powershell
# Install vcpkg dependencies (the environment will be prepared in vcpkg_installed/ directory)
vcpkg install --triplet x64-windows

# Meson reads pkg-config files from ./vcpkg_installed/x64-windows/lib/pkgconfig (that's awesome!)
meson setup build --backend ninja --vsenv -Dbuildtype=release

# Compile and link
meson compile -C build
```

Building the release version (`-Dbuildtype=release`) is required to get working binary, because with debug
build the binary will be linked against debug versions of SDL2 libraries with `d` suffix (e.g. SDL2_mixerd.dll).
If debugging on Windows is what you need right now - I hope you're holding there, buddy.

### Run

```powershell
build/snake.exe
```
