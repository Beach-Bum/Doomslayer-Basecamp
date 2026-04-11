import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme 1.0

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: DSTheme.bg
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: DSTheme.spacingXl
        spacing: DSTheme.spacingMd

        DSSectionTitle { text: "Dashboard" }

        Text {
            text: "System overview and node health"
            font.family: DSTheme.fontFamily
            font.pixelSize: DSTheme.fontSizeDefault
            color: DSTheme.dimFg
        }

        // ── Stats row ────────────────────────────────────────────────
        RowLayout {
            Layout.fillWidth: true
            spacing: DSTheme.spacingXl

            Text {
                text: "Modules Loaded: "
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.dimFg
            }
            Text {
                text: "2"
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.cyan
            }

            Text {
                text: "Messaging: "
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.dimFg
            }
            Text {
                text: "live"
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.green
            }

            Text {
                text: "Blockchain: "
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.dimFg
            }
            Text {
                text: "testnet"
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.yellow
            }

            Text {
                text: "Storage: "
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.dimFg
            }
            Text {
                text: "mock"
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.magenta
            }

            Text {
                text: "Uptime: "
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.dimFg
            }
            Text {
                text: "4h 23m"
                font.family: DSTheme.fontFamily
                font.pixelSize: DSTheme.fontSizeDefault
                color: DSTheme.fg
            }
        }

        DSSeparator {}

        // ── Node Health ──────────────────────────────────────────────
        DSSectionTitle { text: "Node Health"; small: true }

        DSProgressBar { prefixText: "cpu"; value: 0.92 }
        DSProgressBar { prefixText: "mem"; value: 0.67 }
        DSProgressBar { prefixText: "net"; value: 0.34 }

        Item { Layout.fillHeight: true }
    }
}
