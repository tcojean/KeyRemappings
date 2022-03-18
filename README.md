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

There are two versions:
* For Windows, a [AutoHotKey](https://www.autohotkey.com/) based script which
  should work for most setups
* For Linux and friends, a script for **qwerty keyboards** using xmodmap and
  [xcape](https://github.com/alols/xcape)

This code uses the Unlicense. Do what you want with it.
