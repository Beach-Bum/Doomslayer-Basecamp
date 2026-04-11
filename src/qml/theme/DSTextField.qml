import QtQuick 2.15

Rectangle {
    id: root
    property alias text: input.text
    property string placeholderText: ""
    property bool readOnly: false

    signal accepted()

    implicitHeight: DSTheme.inputHeight
    color: DSTheme.bg
    border.color: input.activeFocus ? DSTheme.blue : DSTheme.border
    border.width: 1
    radius: 0

    TextInput {
        id: input
        anchors.fill: parent
        anchors.margins: DSTheme.spacingSm
        color: DSTheme.fg
        font.family: DSTheme.fontFamily
        font.pixelSize: DSTheme.fontSizeMedium
        readOnly: root.readOnly
        clip: true
        onAccepted: root.accepted()

        Text {
            anchors.fill: parent
            text: root.placeholderText
            color: DSTheme.dimFg
            font.family: DSTheme.fontFamily
            font.pixelSize: DSTheme.fontSizeMedium
            visible: !input.text && !input.activeFocus
        }
    }
}
