import QtQuick
import Quickshell
import Quickshell.Io

import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    property real vramUsed: 0.0
    property real vramTotal: 0.0
    property real vramPercent: 0.0
    property bool showLabel: pluginData.showLabel !== false
    property string labelText: pluginData.labelText || "VRAM"

    function usageColor(percent) {
        if (percent > 90) return Theme.error
        if (percent > 75) return "#ffa500"
        return Theme.primary
    }

    function fmtVram() {
        if (root.vramTotal <= 0) return "n/a"
        return `${(root.vramUsed / 1024).toFixed(1)} / ${(root.vramTotal / 1024).toFixed(1)} GB`
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: vramProcess.running = true
    }

    Process {
        id: vramProcess
        command: ["nvidia-smi", "--query-gpu=memory.used,memory.total", "--format=csv,noheader,nounits"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(", ")
                if (parts.length < 2) return
                const used = parseFloat(parts[0])
                const total = parseFloat(parts[1])
                if (!(total > 0)) return
                root.vramUsed = used
                root.vramTotal = total
                root.vramPercent = (used / total) * 100
            }
        }
    }

    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingS

            DankIcon {
                name: "developer_board"
                size: Theme.fontSizeLarge
                color: Theme.surfaceText
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                visible: root.showLabel
                text: root.labelText
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.surfaceText
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                width: 44
                height: 6
                radius: 3
                color: Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.25)
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    width: parent.width * Math.min(root.vramPercent, 100) / 100
                    height: parent.height
                    radius: parent.radius
                    color: root.usageColor(root.vramPercent)
                    Behavior on width { NumberAnimation { duration: 400; easing.type: Easing.OutCubic } }
                    Behavior on color { ColorAnimation { duration: 400 } }
                }
            }

            StyledText {
                text: `${root.vramPercent.toFixed(0)}%`
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.surfaceText
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

}
