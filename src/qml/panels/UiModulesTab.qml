import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme 1.0

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: DSTheme.spacingMd

        DSSectionTitle { text: "UI Modules"; small: true }

        Text {
            text: "Available UI plugins in the system"
            font.family: DSTheme.fontFamily
            font.pixelSize: DSTheme.fontSizeDefault
            color: DSTheme.dimFg
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 2

                Repeater {
                    model: backend.uiModules

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: DSTheme.rowHeight
                        color: index % 2 === 0 ? DSTheme.bg : DSTheme.altBg
                        radius: 0

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: DSTheme.spacingMd
                            anchors.rightMargin: DSTheme.spacingMd
                            spacing: DSTheme.spacingMd

                            Text {
                                text: modelData.name
                                font.family: DSTheme.fontFamily
                                font.pixelSize: DSTheme.fontSizeDefault
                                font.bold: true
                                color: DSTheme.yellow
                                Layout.preferredWidth: 160
                            }

                            Text {
                                text: modelData.isLoaded ? "(loaded)" : "(not loaded)"
                                font.family: DSTheme.fontFamily
                                font.pixelSize: DSTheme.fontSizeDefault
                                color: modelData.isLoaded ? DSTheme.cyan : DSTheme.dimFg
                            }

                            Item { Layout.fillWidth: true }

                            DSButton {
                                text: "Load"
                                primary: true
                                visible: !modelData.isMainUi && !modelData.isLoaded
                                onClicked: backend.loadUiModule(modelData.name)
                            }

                            DSButton {
                                text: "Unload"
                                danger: true
                                visible: !modelData.isMainUi && modelData.isLoaded
                                onClicked: backend.unloadUiModule(modelData.name)
                            }
                        }
                    }
                }

                // Empty state
                Text {
                    text: "No UI plugins found in the plugins directory."
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    color: DSTheme.dimFg
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: DSTheme.spacingXl
                    visible: backend.uiModules.length === 0
                }
            }
        }
    }
}
