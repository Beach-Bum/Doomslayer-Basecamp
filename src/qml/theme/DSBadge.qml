import QtQuick 2.15

Rectangle {
    property int    count:   0
    property string variant: "default"

    implicitWidth:  label.implicitWidth + DSTheme.spacingMd
    implicitHeight: DSTheme.headerHeight
    radius: 0
    color: "transparent"

    border.color: {
        switch (variant) {
        case "success": return DSTheme.cyan
        case "warning": return DSTheme.yellow
        case "error":   return DSTheme.red
        default:        return DSTheme.border
        }
    }
    border.width: 1

    Text {
        id: label
        anchors.centerIn: parent
        text: count.toString()
        color: {
            switch (parent.variant) {
            case "success": return DSTheme.cyan
            case "warning": return DSTheme.yellow
            case "error":   return DSTheme.red
            default:        return DSTheme.fg
            }
        }
        font.family: DSTheme.fontFamily
        font.pixelSize: DSTheme.fontSizeSmall
        font.bold: true
    }
}
