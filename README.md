```
          _                      _           _      
 _ __ ___| |_ _ __ ___       ___(_) __ _    (_)     
| '__/ _ \ __| '__/ _ \ ____|_  / |/ _` |   | |     
| | |  __/ |_| | | (_) |_____/ /| | (_| |   | |     
|_|  \___|\__|_|  \___/     /___|_|\__, |___|_|____ 
                                   |___/___________|
```
Hand-written libretro bindings for the Zig programming language.

My hope is that this will be useful for people creating emulators and game engines in Zig, for years to come.
Consider giving a ⭐ if you like what you see!

> [!WARNING]
> This is currently missing a bunch of functionality, and is not yet stable. Furthermore, while Zig itself is a very nice little language, you should expect breaking changes. Nonetheless, have fun!

## Getting started
### Prerequisites
- ⚡ Zig 0.14 dev (latest as of June 2024)
- 👾 RetroArch or another libretro frontend
- 🖼️ Optional: Cairo graphics library (to build the Cairo example)

### Building example cores
```sh
zig build -Doptimize=ReleaseSmall
```
This gives you very tiny shared objects.

### Running (RetroArch)
To run the `basic` example:
```sh
retroarch -L ./zig-out/lib/libbasic_libretro.so
```
