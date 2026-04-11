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
        spacing: 0

        // ── Top title bar ────────────────────────────────────────────
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 22
            color: DSTheme.statusBg

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: DSTheme.spacingMd
                anchors.rightMargin: DSTheme.spacingMd
                spacing: DSTheme.spacingMd

                Text {
                    text: "\u27E1 Logos Basecamp \u2502 v0.1.0-dev"
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    color: DSTheme.fg
                }

                Item { Layout.fillWidth: true }

                Repeater {
                    model: DSTheme.themeNames
                    delegate: Text {
                        required property string modelData
                        text: modelData
                        font.family: DSTheme.fontFamily
                        font.pixelSize: DSTheme.fontSizeSmall
                        color: DSTheme.currentTheme === modelData ? DSTheme.yellow : DSTheme.dimFg
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: DSTheme.setTheme(modelData)
                        }
                    }
                }
            }
        }

        // ── Top border ───────────────────────────────────────────────
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: DSTheme.border
        }

        // ── Content stack ────────────────────────────────────────────
        StackLayout {
            id: contentStack
            Layout.fillWidth: true
            Layout.fillHeight: true

            currentIndex: Math.max(0, backend.currentActiveSectionIndex - 1)

            DashboardView {
                id: dashboardView
            }

            ModulesView {
                id: modulesView
            }

            SettingsView {
                id: settingsView
            }
        }

        // ── Bottom border ────────────────────────────────────────────
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: DSTheme.border
        }

        // ── Bottom status bar ────────────────────────────────────────
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            color: DSTheme.statusBg

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: DSTheme.spacingMd
                anchors.rightMargin: DSTheme.spacingMd
                spacing: DSTheme.spacingMd

                Text {
                    text: {
                        var idx = Math.max(0, backend.currentActiveSectionIndex - 1)
                        var names = ["Dashboard", "Modules", "Settings"]
                        return "[" + (names[idx] || "Dashboard") + "]"
                    }
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    color: DSTheme.dimFg
                }

                Text {
                    text: "Logos Basecamp"
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    color: DSTheme.blue
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "modules: " + (backend.coreModules ? backend.coreModules.length : 0)
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    color: DSTheme.dimFg
                }
            }
        }
    }
}
