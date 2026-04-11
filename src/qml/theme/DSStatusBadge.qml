import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string text:    ""
    property string variant: "info"

    implicitWidth:  row.implicitWidth + DSTheme.spacingXl
    implicitHeight: DSTheme.rowHeight
    radius: 0
    color: "transparent"

    border.color: {
        switch (variant) {
        case "success": return DSTheme.cyan
        case "warning": return DSTheme.yellow
        case "error":   return DSTheme.red
        default:        return DSTheme.blue
        }
    }
    border.width: 1

    Row {
        id: row
        anchors.centerIn: parent
        spacing: DSTheme.spacingSm + 2

        Text {
            text: {
                switch (parent.parent.variant) {
                case "success": return "\u2713"
                case "warning": return "!"
                case "error":   return "\u2717"
                default:        return "\u00B7"
                }
            }
            font.family: DSTheme.fontFamily
            font.pixelSize: DSTheme.fontSizeMedium
            font.bold: true
            color: {
                switch (parent.parent.variant) {
                case "success": return DSTheme.cyan
                case "warning": return DSTheme.yellow
                case "error":   return DSTheme.red
                default:        return DSTheme.blue
                }
            }
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: row.parent.text
            font.family: DSTheme.fontFamily
            font.pixelSize: DSTheme.fontSizeDefault
            color: DSTheme.fg
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
