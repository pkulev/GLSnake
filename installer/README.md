# Windows installer (MSI + ZIP)

Builds a **portable ZIP** and a **per-machine MSI** from an existing Meson `build/` directory.

## Prerequisites (local)

- Completed Windows build: `meson setup build --backend ninja --vsenv -Dbuildtype=release -Dresource_dir=resources/` then `meson compile -C build`
- [.NET SDK](https://dotnet.microsoft.com/download) (for WiX SDK)
- WiX is restored automatically via `GLSnake.Installer.wixproj`

## Package locally

```powershell
./installer/build-release.ps1 -Version 1.0.4
```

Outputs in `dist/`:

- `GLSnake-1.0.4-win64.zip` — unzip and run `snake.exe` (keep `resources/` beside the exe)
- `GLSnake-1.0.4-win64.msi` — installs to `Program Files\GLSnake` with a Start Menu shortcut (`WorkingDirectory` = install folder)

## CI

[`.github/workflows/release.yaml`](../.github/workflows/release.yaml) runs on **published GitHub releases** and attaches both files. Use **Actions → GLSnake Release → Run workflow** to test without publishing.

Windows CI installs **meson**, **vcpkg**, **pkg-config**, and **ninja** via [setup-scoop](https://github.com/Marketplace/actions/setup-scoop), then runs `vcpkg install --triplet x64-windows` for manifest deps.

The game is built with `-Dresource_dir=resources/` so assets resolve when the working directory is the install folder (shortcut sets this).
