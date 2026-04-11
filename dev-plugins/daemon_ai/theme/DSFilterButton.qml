import QtQuick 2.15

Rectangle {
    id: root
    property string text:   ""
    property bool   active: false
    signal clicked()

    implicitWidth:  label.implicitWidth + DSTheme.spacingLg
    implicitHeight: DSTheme.rowHeight
    radius: 0

    color:        active ? DSTheme.activeBg : mouse.containsMouse ? DSTheme.statusBg : "transparent"
    border.color: active ? DSTheme.blue : DSTheme.border
    border.width: 1

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        font.family: DSTheme.fontFamily
        font.pixelSize: DSTheme.fontSizeDefault
        color: root.active ? DSTheme.yellow : mouse.containsMouse ? DSTheme.fg : DSTheme.dimFg
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
