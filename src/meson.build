sources = files([
  'gameover.c',
  'gui.c',
  'highscores.c',
  'ingame.c',
  'main.c',
  'mainmenu.c',
  'paused.c',
  'targa.c',
  'ttfonts.c',
])

if host_machine.system() == 'windows'
  vcpkg_prefix = meson.project_source_root() / 'vcpkg_installed' / 'x64-windows'
  cmake_prefix_args = ['-DCMAKE_PREFIX_PATH=' + vcpkg_prefix]

  sdl2_dep = dependency(
    'SDL2',
    method: 'cmake',
    modules: ['SDL2::SDL2'],
    cmake_args: cmake_prefix_args,
  )
  sdl2_mixer_dep = dependency(
    'SDL2_mixer',
    method: 'cmake',
    modules: ['SDL2_mixer::SDL2_mixer'],
    cmake_args: cmake_prefix_args,
  )
  sdl2_ttf_dep = dependency(
    'SDL2_ttf',
    method: 'cmake',
    modules: ['SDL2_ttf::SDL2_ttf'],
    cmake_args: cmake_prefix_args,
  )
else
  sdl2_dep = dependency('sdl2', method: 'pkg-config', required: false)
  if not sdl2_dep.found()
    sdl2_dep = dependency('SDL2', method: 'pkg-config')
  endif

  sdl2_mixer_dep = dependency('sdl2_mixer', required: false)
  if not sdl2_mixer_dep.found()
    sdl2_mixer_dep = dependency('SDL2_mixer')
  endif

  sdl2_ttf_dep = dependency('sdl2_ttf', required: false)
  if not sdl2_ttf_dep.found()
    sdl2_ttf_dep = dependency('SDL2_ttf')
  endif
endif

cc = meson.get_compiler('c')
m_dep = cc.find_library('m', required: false)

dependencies = [
  dependency('gl', method: 'system'),
  sdl2_dep,
  sdl2_mixer_dep,
  sdl2_ttf_dep,
]
if m_dep.found()
  dependencies += m_dep
endif
