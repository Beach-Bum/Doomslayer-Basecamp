import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme 1.0

Item {
    id: root

    property string pluginName: ""
    property var methods: []
    property string resultText: ""

    signal backClicked()

    Component.onCompleted: loadMethods()
    onPluginNameChanged: loadMethods()

    function loadMethods() {
        if (pluginName.length > 0) {
            let methodsJson = backend.getCoreModuleMethods(pluginName)
            try {
                methods = JSON.parse(methodsJson)
            } catch (e) {
                methods = []
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: DSTheme.spacingMd

        // Header with back button
        RowLayout {
            Layout.fillWidth: true
            spacing: DSTheme.spacingMd

            DSButton {
                text: "\u2190 Back"
                onClicked: root.backClicked()
            }

            DSSectionTitle {
                text: "Methods: " + root.pluginName
                small: true
                Layout.fillWidth: true
            }
        }

        // Methods list
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 2

                Repeater {
                    model: root.methods

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: methodCol.implicitHeight + DSTheme.spacingMd
                        color: index % 2 === 0 ? DSTheme.bg : DSTheme.altBg
                        radius: 0

                        ColumnLayout {
                            id: methodCol
                            anchors.fill: parent
                            anchors.margins: DSTheme.spacingMd
                            spacing: DSTheme.spacingSm

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: DSTheme.spacingMd

                                Text {
                                    text: modelData.name || modelData
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: DSTheme.fontSizeDefault
                                    font.bold: true
                                    color: DSTheme.blue
                                }

                                Text {
                                    text: modelData.signature || ""
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: DSTheme.fontSizeDefault
                                    color: DSTheme.dimFg
                                    visible: modelData.signature !== undefined
                                }

                                Item { Layout.fillWidth: true }

                                DSButton {
                                    text: "Call"
                                    primary: true
                                    onClicked: {
                                        let methodName = modelData.name || modelData
                                        root.resultText = backend.callCoreModuleMethod(root.pluginName, methodName, "[]")
                                    }
                                }
                            }

                            Text {
                                text: modelData.description || ""
                                font.family: DSTheme.fontFamily
                                font.pixelSize: DSTheme.fontSizeDefault
                                color: DSTheme.dimFg
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                                visible: modelData.description !== undefined && modelData.description.length > 0
                            }
                        }
                    }
                }

                // Empty state
                Text {
                    text: "No methods available for this plugin."
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    color: DSTheme.dimFg
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: DSTheme.spacingXl
                    visible: root.methods.length === 0
                }
            }
        }

        // Result area
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            color: DSTheme.bg
            radius: 0
            border.color: DSTheme.border
            border.width: 1
            visible: root.resultText.length > 0

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: DSTheme.spacingMd
                spacing: DSTheme.spacingSm

                Text {
                    text: "Result:"
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    font.bold: true
                    color: DSTheme.dimFg
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    TextArea {
                        text: root.resultText
                        font.family: DSTheme.fontFamily
                        font.pixelSize: DSTheme.fontSizeDefault
                        color: DSTheme.cyan
                        readOnly: true
                        wrapMode: Text.Wrap
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
        }
    }
}
