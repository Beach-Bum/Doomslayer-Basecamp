import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme"

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        RowLayout {
            spacing: 0
            Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 13 }
            Text { text: "UI Modules"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: 13; font.bold: true }
            Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: 13 }
        }

        Text {
            text: "Available UI plugins in the system"
            font.family: DSTheme.fontFamily
            font.pixelSize: 11
            color: DSTheme.dimFg
        }

        // Header row
        Rectangle {
            Layout.fillWidth: true
            height: 20
            color: DSTheme.statusBg

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                spacing: 12

                Text { text: "NAME"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: 10; font.bold: true; Layout.preferredWidth: 160 }
                Text { text: "STATUS"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: 10; font.bold: true; Layout.preferredWidth: 100 }
                Item { Layout.fillWidth: true }
                Text { text: "ACTION"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: 10; font.bold: true }
            }
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 0

                Repeater {
                    model: backend.uiModules

                    Rectangle {
                        Layout.fillWidth: true
                        height: 32
                        color: index % 2 === 0 ? DSTheme.bg : DSTheme.altBg

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            anchors.rightMargin: 8
                            spacing: 12

                            Text {
                                text: modelData.name
                                font.family: DSTheme.fontFamily
                                font.pixelSize: 12
                                font.bold: true
                                color: DSTheme.yellow
                                Layout.preferredWidth: 160
                                elide: Text.ElideRight
                            }

                            Text {
                                text: modelData.isLoaded ? "loaded" : "not loaded"
                                font.family: DSTheme.fontFamily
                                font.pixelSize: 11
                                color: modelData.isLoaded ? DSTheme.cyan : DSTheme.dimFg
                                Layout.preferredWidth: 100
                            }

                            Item { Layout.fillWidth: true }

                            // Load button
                            Rectangle {
                                visible: !modelData.isMainUi && !modelData.isLoaded
                                width: 60
                                height: 20
                                color: "transparent"
                                border.color: DSTheme.cyan
                                border.width: 1

                                Text {
                                    anchors.centerIn: parent
                                    text: "[Load]"
                                    color: DSTheme.cyan
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: 11
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: backend.loadUiModule(modelData.name)
                                }
                            }

                            // Unload button
                            Rectangle {
                                visible: !modelData.isMainUi && modelData.isLoaded
                                width: 72
                                height: 20
                                color: "transparent"
                                border.color: DSTheme.red
                                border.width: 1

                                Text {
                                    anchors.centerIn: parent
                                    text: "[Unload]"
                                    color: DSTheme.red
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: 11
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: backend.unloadUiModule(modelData.name)
                                }
                            }

                            // Main UI label (no button)
                            Text {
                                visible: modelData.isMainUi === true
                                text: "(main)"
                                font.family: DSTheme.fontFamily
                                font.pixelSize: 10
                                color: DSTheme.dimFg
                            }
                        }
                    }
                }

                Text {
                    text: "No UI plugins found."
                    font.family: DSTheme.fontFamily
                    font.pixelSize: 11
                    color: DSTheme.dimFg
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 16
                    visible: backend.uiModules.length === 0
                }
            }
        }
    }
}
