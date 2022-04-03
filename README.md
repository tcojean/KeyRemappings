Convenient Key Remappings
=================================

This is a simple script to give some keys on top of their normal usage, adds new capacities to
some keys:
* Adds Control to: 
  * the CapsLock key and
  * the key '" on qwerty keyboards, on the other side of the home row (SC028, keycode 48)
* Adds Escape to: both shifts

The way it works is simple: the normal effects happen when pressing the CapsLock
and SC028 keys alone. When pressed with another key, the script assumes a
control behavior. Shift works the same way but reverse, when pressed alone we
add the escape behavior.

Configurations for Windows and Linux are provided, by using different methods.

### Windows
For Windows, a [AutoHotKey](https://www.autohotkey.com/) based script is
provided which should work for most setups.

### Linux
For Linux and friends, two methods are provided

1. A more robust method makes use of the
   [interception](https://gitlab.com/interception/linux/tools) software and its
   [dual-function-keys](https://gitlab.com/interception/linux/plugins/dual-function-keys)
   plugin. See their readme for more information and installation process. This
   method supports both Wayland and X11. copy the `interception` folder to
   `/etc` and adapt `./interception/udevmon.d/my-kbds.yml` to your keyboards.
   Use the `xinput` command to find your input devices' (incl. keyboards) names
   and properties.
2. A less robust method relies on scripts for **qwerty keyboards** using the
  xmodmap and [xcape](https://github.com/alols/xcape) tools. Only X11 is
  supported (no Wayland).

### License
This code uses the Unlicense. Do what you want with it.
