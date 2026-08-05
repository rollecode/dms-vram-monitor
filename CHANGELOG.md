# Changelog

### 1.6.0: 2026-08-05

* Render in vertical DankBars: the widget had no vertical pill and so drew nothing at all in a left or right bar
* Stack the icon, chart and percentage in a vertical bar, and drop the text label there — it never fits a bar one icon wide
* Add a chart style setting: horizontal bar, vertical bar, gauge, donut, pie, or none
* Add **Icon inside chart** for the round styles, drawing the icon in the middle instead of beside it; the chart grows to make room, capped at the thickness of your bar
* Add a thickness slider for the two bar styles
* Draw the round styles with GPU-accelerated shapes rather than Canvas, so nothing rasterizes on the CPU every second
* Add an icon picker: search the whole Material Symbols catalog, browse curated categories, or type a name directly; clear it to go back to `developer_board`
* Vendor the Material Symbols name index (`assets/`), which DMS ships the font for but not the index, and whose install path varies by version

### 1.5.0: 2026-07-26

* Warm the popout list in the background so it paints instantly instead of filling in up to a second after opening

### 1.4.0: 2026-07-26

* Follow the DankBar's own font scale and thickness: the icon, text and bar resize with the bar instead of staying fixed
* Keep the percentage beside its bar: the reserved width sits on the far side now, so single and double digit values no longer float away from it

### 1.3.0: 2026-07-17

* Pin Free topmost, then rows that cannot be killed (driver reserved), processes below
* Colour every popout bar with the orange and red thresholds; Free keeps the accent
* Keep the pill a constant width: digits changing every second no longer resize it and churn the bar layout
* Keep row explanations on one line, never wrapping

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
