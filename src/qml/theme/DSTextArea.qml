import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    property alias text: area.text
    property string placeholderText: ""
    property bool readOnly: false

    implicitHeight: 60
    color: DSTheme.bg
    border.color: area.activeFocus ? DSTheme.blue : DSTheme.border
    border.width: 1
    radius: 0

    TextArea {
        id: area
        anchors.fill: parent
        anchors.margins: DSTheme.spacingSm
        color: DSTheme.fg
        font.family: DSTheme.fontFamily
        font.pixelSize: DSTheme.fontSizeMedium
        placeholderText: root.placeholderText
        placeholderTextColor: DSTheme.dimFg
        readOnly: root.readOnly
        wrapMode: TextArea.Wrap
        background: null
    }
}
