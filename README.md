# VRAM Monitor

NVIDIA VRAM usage as an animated chart in your [DankBar](https://github.com/AvengeMedia/DankMaterialShell), updated every second.

![Screenshot](Screenshot.png)

Shown next to its sibling [RAM Monitor](https://github.com/rollecode/dms-ram-monitor).

## What it does

- Compact bar pill: icon, optional label, animated chart and percentage
- Six chart styles: horizontal bar, vertical bar, gauge, donut, pie, or none
- The round styles can hold the icon in their middle instead of beside them
- Works in horizontal and vertical bars; the vertical pill stacks icon, chart and percentage, and drops the label
- Updates every second from `nvidia-smi --query-gpu=memory.used,memory.total`
- Fill follows your theme accent, turns orange above 75% and red above 90%

## Requirements

- NVIDIA GPU with the proprietary driver (`nvidia-smi` must be on PATH)

## Installation

From the DMS plugin browser (Settings, Plugins tab, Browse), or manually:

```bash
git clone https://github.com/rollecode/dms-vram-monitor ~/.config/DankMaterialShell/plugins/vramMonitor
```

Then enable it in Settings, Plugins, and add the widget to your bar layout in Settings, Bar.

## Settings

- **Show label**: toggle the text label between the icon and the chart (on by default, horizontal bars only)
- **Label text**: customize the label (default `VRAM`)
- **Icon**: pick any Material Symbol — search the full catalog, browse categories, or type a name (default `developer_board`)
- **Chart style**: horizontal bar, vertical bar, gauge, donut, pie or none (default horizontal bar)
- **Icon inside chart**: for gauge, donut and pie, draw the icon in the middle of the chart (on by default)
- **Bar height / width**: how thick the bar styles are drawn (default 35%)
- **Entries to show**: how many rows the popout lists, 5 to 60 (default 30)

## License

MIT
