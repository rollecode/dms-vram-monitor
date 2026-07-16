# Changelog

### 1.2.0: 2026-07-17

* Add a popout listing what is actually using VRAM, biggest first, with a kill icon on each process
* Read the process table from plain `nvidia-smi` rather than `--query-compute-apps`, which omits graphics clients (driftwm, Xwayland, electron) and so misses most of the used VRAM
* Account for all of it: driver-reserved VRAM and free memory get their own rows
* Pin Free to the top of the list in the accent colour
* Show a second, dimmer word per process: the script for interpreters, the owner for WebKit webviews, the subprocess type for Electron apps. `nvidia-smi` truncates its own name column and picks up argv, so names come from `/proc/<pid>/comm`
* Add a slider for how many rows the popout lists, 5 to 60, default 30
* Only collect the list while the popout is open

### 1.1.0: 2026-07-07

* Add an optional text label after the icon, on by default, customisable

### 1.0.0: 2026-07-07

* Initial release: VRAM usage as an animated progress bar in the DankBar, updated every second
