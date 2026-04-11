import QtQuick 2.15
import QtQuick.Layouts 1.15

RowLayout {
    property string text: ""
    property bool small: false
    spacing: 0
    Layout.fillWidth: true

    Text {
        text: "\u251C\u2500 "
        color: DSTheme.border
        font.family: DSTheme.fontFamily
        font.pixelSize: parent.small ? DSTheme.fontSizeMedium : DSTheme.fontSizeLarge
    }
    Text {
        text: parent.text
        color: DSTheme.fg
        font.family: DSTheme.fontFamily
        font.pixelSize: parent.small ? DSTheme.fontSizeMedium : DSTheme.fontSizeLarge
        font.bold: true
    }
    Text {
        text: " \u2500"
        color: DSTheme.border
        font.family: DSTheme.fontFamily
        font.pixelSize: parent.small ? DSTheme.fontSizeMedium : DSTheme.fontSizeLarge
        Layout.fillWidth: true
    }
}
