project(
  'GLSnake', 'c',
  version : '1.0.0',
  default_options: [
    'default_library=static',
    'c_std=c99',
  ],
)

resource_dir = get_option('resource_dir')
add_project_arguments(
  '-DRESOURCE_DIR="@0@"'.format(resource_dir),
  language : 'c',
)

# Provides 'sources' and 'dependencies' variables.
subdir('src')

if host_machine.system() == 'windows'
  vcpkg_root = meson.project_source_root() / 'vcpkg_installed' / 'x64-windows'
  powershell = find_program('powershell', 'pwsh', required: true)
  custom_target(
    'copy-vcpkg-dlls',
    command: [
      powershell,
      '-NoProfile',
      '-ExecutionPolicy', 'Bypass',
      '-File', meson.project_source_root() / 'copy-vcpkg-dlls.ps1',
      '-VcpkgBin', vcpkg_root / 'bin',
      '-DestDir', meson.current_build_dir(),
      '-Stamp', '@OUTPUT@',
    ],
    output: 'vcpkg-dlls.stamp',
    build_by_default: true,
  )
endif


executable(
  'snake',
  sources,
  dependencies: dependencies,
  include_directories: include_directories('include'),
)
