import QtQuick 2.15

Rectangle {
    id: root
    property var    model: []
    property int    currentIndex: 0
    signal tabClicked(int index)

    implicitHeight: DSTheme.buttonHeight
    color: "transparent"
    border.color: DSTheme.border
    border.width: 1
    radius: 0

    Row {
        anchors.fill: parent
        anchors.margins: 1

        Repeater {
            model: root.model
            delegate: Rectangle {
                width: root.width / root.model.length
                height: parent.height
                color: root.currentIndex === index ? DSTheme.activeBg : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: modelData
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    color: root.currentIndex === index ? DSTheme.yellow : DSTheme.dimFg
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: { root.currentIndex = index; root.tabClicked(index) }
                }
            }
        }
    }
}
