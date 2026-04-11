import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string label: ""
    property string value: ""
    property bool   copyable: true
    signal copyRequested(string text)

    implicitHeight: DSTheme.rowHeight
    color: "transparent"
    radius: 0

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: DSTheme.spacingSm
        anchors.rightMargin: DSTheme.spacingSm
        spacing: DSTheme.spacingMd

        Text {
            text: parent.parent.label + ":"
            color: DSTheme.dimFg
            font.family: DSTheme.fontFamily
            font.pixelSize: DSTheme.fontSizeDefault
            Layout.minimumWidth: 120
        }

        Text {
            text: parent.parent.value
            color: DSTheme.cyan
            font.family: DSTheme.fontFamily
            font.pixelSize: DSTheme.fontSizeDefault
            wrapMode: Text.WrapAnywhere
            Layout.fillWidth: true
            elide: Text.ElideMiddle
        }

        Text {
            text: "[copy]"
            visible: parent.parent.copyable
            color: copyMouse.containsMouse ? DSTheme.blue : DSTheme.dimFg
            font.family: DSTheme.fontFamily
            font.pixelSize: DSTheme.fontSizeSmall
            MouseArea {
                id: copyMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: parent.parent.parent.parent.parent.copyRequested(parent.parent.parent.parent.parent.value)
            }
        }
    }
}
