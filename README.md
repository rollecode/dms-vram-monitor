# VRAM Monitor

NVIDIA VRAM usage as an animated progress bar in your [DankBar](https://github.com/AvengeMedia/DankMaterialShell), updated every second.

![Screenshot](Screenshot.png)

Shown next to its sibling [RAM Monitor](https://github.com/rollecode/dms-ram-monitor).

## What it does

- Compact bar pill: icon, optional label, animated progress bar and percentage
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

- **Show label**: toggle the text label between the icon and the bar (on by default)
- **Label text**: customize the label (default `VRAM`)

## License

MIT
