# Package

## 2026-06-14 switch cachyos-extra-v3/abseil-cpp to extra/abseil-cpp

**Why**: `start-hyprland` error:

```sh
ERR from start-hyprland ]: failed to obtain hyprland version string (bad .json)
ERR from start-hyprland ]: failed to obtain hyprland version string (bad .json)
ERR from start-hyprland ]: failed to obtain hyprland version string (bad .json)
Hyprland: error while loading shared libraries: libabsl_log_internal_check_op.so.2605.0.0: cannot open shared object file: No such file or directory
...
```

`hyprland` expect `libabsl_log_internal_check_op.so.2605.0.0` but installed (`cachyos-extra-v3/abseil-cpp`) is still `2601`.

**How**: `paru -S extra/abseil-cpp`
