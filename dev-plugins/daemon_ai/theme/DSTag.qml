import QtQuick 2.15

Rectangle {
    property string text: ""
    property color  tagColor: DSTheme.cyan

    implicitWidth:  label.implicitWidth + DSTheme.spacingMd + 2
    implicitHeight: DSTheme.headerHeight
    radius: 0
    color: "transparent"
    border.color: DSTheme.border
    border.width: 1

    Text {
        id: label
        anchors.centerIn: parent
        text: parent.text
        color: parent.tagColor
        font.family: DSTheme.fontFamily
        font.pixelSize: DSTheme.fontSizeSmall
    }
}
