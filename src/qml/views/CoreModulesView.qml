import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme 1.0

Item {
    id: root

    property string selectedPlugin: ""
    property bool showingMethods: false

    onVisibleChanged: {
        if (visible) {
            backend.refreshCoreModules()
        }
    }

    Component.onCompleted: {
        backend.refreshCoreModules()
    }

    StackLayout {
        anchors.fill: parent
        currentIndex: root.showingMethods ? 1 : 0

        // Plugin list view
        ColumnLayout {
            spacing: DSTheme.spacingMd

            RowLayout {
                Layout.fillWidth: true
                spacing: DSTheme.spacingMd

                DSSectionTitle {
                    text: "Core Modules"
                    small: true
                    Layout.fillWidth: true
                }

                DSButton {
                    text: "Reload"
                    onClicked: backend.refreshCoreModules()
                }
            }

            Text {
                text: "All available plugins in the system"
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
                        model: backend.coreModules

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

                                // Plugin name
                                Text {
                                    text: modelData.name
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: DSTheme.fontSizeDefault
                                    font.bold: true
                                    color: DSTheme.yellow
                                    Layout.preferredWidth: 150
                                }

                                // Status
                                Text {
                                    text: modelData.isLoaded ? "(loaded)" : "(not loaded)"
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: DSTheme.fontSizeDefault
                                    color: modelData.isLoaded ? DSTheme.cyan : DSTheme.red
                                }

                                // CPU
                                Text {
                                    text: modelData.isLoaded ? "cpu:" + modelData.cpu + "%" : ""
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: DSTheme.fontSizeDefault
                                    color: DSTheme.blue
                                    Layout.preferredWidth: 80
                                }

                                // Memory
                                Text {
                                    text: modelData.isLoaded ? "mem:" + modelData.memory + "MB" : ""
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: DSTheme.fontSizeDefault
                                    color: DSTheme.blue
                                    Layout.preferredWidth: 100
                                }

                                Item { Layout.fillWidth: true }

                                // Load/Unload
                                DSButton {
                                    text: modelData.isLoaded ? "Unload" : "Load"
                                    danger: modelData.isLoaded
                                    primary: !modelData.isLoaded
                                    onClicked: {
                                        if (modelData.isLoaded) {
                                            backend.unloadCoreModule(modelData.name)
                                        } else {
                                            backend.loadCoreModule(modelData.name)
                                        }
                                    }
                                }

                                // View Methods
                                DSButton {
                                    text: "Methods"
                                    visible: modelData.isLoaded
                                    onClicked: {
                                        root.selectedPlugin = modelData.name
                                        root.showingMethods = true
                                    }
                                }
                            }
                        }
                    }

                    // Empty state
                    Text {
                        text: "No core modules available."
                        font.family: DSTheme.fontFamily
                        font.pixelSize: DSTheme.fontSizeDefault
                        color: DSTheme.dimFg
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: DSTheme.spacingXl
                        visible: backend.coreModules.length === 0
                    }
                }
            }
        }

        // Methods view
        PluginMethodsView {
            pluginName: root.selectedPlugin
            onBackClicked: root.showingMethods = false
        }
    }
}
