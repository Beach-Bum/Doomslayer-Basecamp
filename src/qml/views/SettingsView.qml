import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme"

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: DSTheme.bg
    }

    ScrollView {
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        ColumnLayout {
            width: parent.width
            spacing: 8

            Item { height: 8 }

            // ── Settings ────────────────────────────────────────────
            RowLayout {
                spacing: 0; Layout.leftMargin: 16
                Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 14 }
                Text { text: "Settings"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: 14; font.bold: true }
                Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 14 }
            }

            // ── Appearance ──────────────────────────────────────────
            RowLayout {
                spacing: 0; Layout.leftMargin: 16
                Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 13 }
                Text { text: "Appearance"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: 13; font.bold: true }
                Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 13 }
            }

            // Theme picker inline
            Repeater {
                model: DSTheme.themeNames
                delegate: Rectangle {
                    Layout.fillWidth: true
                    Layout.leftMargin: 20
                    Layout.rightMargin: 16
                    height: 22
                    color: DSTheme.currentTheme === modelData ? DSTheme.activeBg : tpMa.containsMouse ? DSTheme.statusBg : "transparent"

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        spacing: 8
                        Text { text: DSTheme.currentTheme === modelData ? "\u2713" : " "; color: DSTheme.cyan; font.family: DSTheme.fontFamily; font.pixelSize: 12; Layout.preferredWidth: 14 }
                        Text { text: modelData; color: DSTheme.currentTheme === modelData ? DSTheme.fg : DSTheme.blue; font.family: DSTheme.fontFamily; font.pixelSize: 12 }
                    }

                    MouseArea { id: tpMa; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: DSTheme.setTheme(modelData) }
                }
            }

            // Separator
            Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border; Layout.leftMargin: 16; Layout.rightMargin: 16; Layout.topMargin: 4; Layout.bottomMargin: 4 }

            // ── Network ─────────────────────────────────────────────
            RowLayout {
                spacing: 0; Layout.leftMargin: 16
                Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 13 }
                Text { text: "Network"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: 13; font.bold: true }
                Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 13 }
            }

            Repeater {
                model: [
                    { label: "Waku endpoint",  value: "ws://127.0.0.1:8546" },
                    { label: "Codex endpoint", value: "http://127.0.0.1:8080" },
                    { label: "Nomos endpoint", value: "http://127.0.0.1:8090" },
                ]
                delegate: RowLayout {
                    spacing: 12
                    Layout.leftMargin: 20
                    Text { text: modelData.label + ":"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: 11; Layout.preferredWidth: 120 }
                    Text { text: modelData.value; color: DSTheme.cyan; font.family: DSTheme.fontFamily; font.pixelSize: 11 }
                }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border; Layout.leftMargin: 16; Layout.rightMargin: 16; Layout.topMargin: 4; Layout.bottomMargin: 4 }

            // ── Plugin Directory ─────────────────────────────────────
            RowLayout {
                spacing: 0; Layout.leftMargin: 16
                Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 13 }
                Text { text: "Plugin Directory"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: 13; font.bold: true }
                Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 13 }
            }

            RowLayout {
                spacing: 12
                Layout.leftMargin: 20
                Text { text: "Path:"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: 11; Layout.preferredWidth: 120 }
                Text { text: "~/.logos-basecamp/plugins"; color: DSTheme.cyan; font.family: DSTheme.fontFamily; font.pixelSize: 11 }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
