import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "vramMonitor"

    // A searchable Material Symbols picker. PluginSettings calls loadValue() on
    // every child, so this reloads with the rest of the settings; an empty value
    // means "not chosen", which the widget reads as its default icon.
    component IconSetting: Column {
        id: iconSetting

        property string settingKey: ""
        property string label: ""
        property string description: ""
        property string value: ""

        width: parent ? parent.width : 0
        spacing: Theme.spacingXS

        function loadValue() {
            value = String(root.loadValue(settingKey, ""))
            picker.currentIcon = value
        }

        Component.onCompleted: loadValue()

        StyledText {
            text: iconSetting.label
            font.pixelSize: Theme.fontSizeMedium
            font.weight: Font.Medium
            color: Theme.surfaceText
        }

        StyledText {
            width: iconSetting.width
            visible: iconSetting.description.length > 0
            text: iconSetting.description
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.surfaceVariantText
            wrapMode: Text.WordWrap
        }

        Row {
            width: parent.width
            spacing: Theme.spacingS

            DropdownIconPicker {
                id: picker
                width: Math.max(200, parent.width - 32 - Theme.spacingS)
                onIconSelected: iconName => {
                    iconSetting.value = iconName
                    root.saveValue(iconSetting.settingKey, iconName)
                }
            }

            DankActionButton {
                anchors.verticalCenter: parent.verticalCenter
                iconName: "close"
                tooltipText: "Use default icon"
                onClicked: {
                    picker.currentIcon = ""
                    iconSetting.value = ""
                    root.saveValue(iconSetting.settingKey, "")
                }
            }
        }
    }

    StyledText {
        width: parent.width
        text: "VRAM Monitor"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: "NVIDIA VRAM usage as an animated chart in your DankBar, updated every second. Works in both horizontal and vertical bars."
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }

    Rectangle {
        width: parent.width
        height: 1
        color: Theme.outline
        opacity: 0.3
    }

    StyledText {
        width: parent.width
        text: "Appearance"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    IconSetting {
        settingKey: "iconName"
        label: "Icon"
        description: "Which Material Symbol the pill shows. Clear it to go back to developer_board."
    }

    ToggleSetting {
        settingKey: "showLabel"
        label: "Show label"
        description: "Display a text label between the icon and the chart. Horizontal bars only — a vertical bar has no room for it"
        defaultValue: true
    }

    StringSetting {
        settingKey: "labelText"
        label: "Label text"
        description: "The label shown next to the icon"
        placeholder: "VRAM"
        defaultValue: "VRAM"
    }

    SelectionSetting {
        id: chartChoice
        settingKey: "chartStyle"
        label: "Chart style"
        description: "How VRAM usage is drawn"
        defaultValue: "hbar"
        options: [
            { "label": "Horizontal bar", "value": "hbar" },
            { "label": "Vertical bar", "value": "bar" },
            { "label": "Gauge", "value": "gauge" },
            { "label": "Donut", "value": "donut" },
            { "label": "Pie", "value": "pie" },
            { "label": "None", "value": "none" }
        ]
    }

    ToggleSetting {
        visible: chartChoice.value === "gauge" || chartChoice.value === "donut" || chartChoice.value === "pie"
        settingKey: "iconInChart"
        label: "Icon inside chart"
        description: "Draw the icon in the middle of the chart instead of beside it. The chart grows to make room, up to the thickness of your bar"
        defaultValue: true
    }

    SliderSetting {
        visible: chartChoice.value === "hbar" || chartChoice.value === "bar"
        settingKey: "chartBarThickness"
        label: chartChoice.value === "bar" ? "Bar width" : "Bar height"
        description: "How thick the bar is drawn, as a share of the space it is given"
        defaultValue: 35
        minimum: 5
        maximum: 100
        unit: "%"
    }

    Rectangle {
        width: parent.width
        height: 1
        color: Theme.outline
        opacity: 0.3
    }

    SliderSetting {
        settingKey: "topCount"
        label: "Entries to show"
        description: "How many rows the popout lists, biggest first"
        defaultValue: 30
        minimum: 5
        maximum: 60
        unit: ""
    }
}
