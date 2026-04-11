import QtQuick 2.15
import QtQuick.Layouts 1.15

RowLayout {
    property real   value:      0.0
    property string prefixText: ""
    property string suffixText: ""

    spacing: DSTheme.spacingSm + 2

    Text {
        text: prefixText
        color: DSTheme.dimFg
        font.family: DSTheme.fontFamily
        font.pixelSize: DSTheme.fontSizeDefault
        visible: prefixText !== ""
    }

    Text {
        text: {
            var filled = Math.round(value * 20)
            var empty  = 20 - filled
            return "\u2588".repeat(filled) + "\u2591".repeat(empty)
        }
        color: value > 0.9 ? DSTheme.cyan : value > 0.75 ? DSTheme.yellow : DSTheme.red
        font.family: DSTheme.fontFamily
        font.pixelSize: DSTheme.fontSizeSmall
        Layout.fillWidth: true
    }

    Text {
        text: (value * 100).toFixed(1) + "%"
        font.family: DSTheme.fontFamily
        font.pixelSize: DSTheme.fontSizeDefault
        font.bold: true
        color: value > 0.9 ? DSTheme.cyan : value > 0.75 ? DSTheme.yellow : DSTheme.red
        Layout.minimumWidth: 42
        horizontalAlignment: Text.AlignRight
    }

    Text {
        text: suffixText
        font.family: DSTheme.fontFamily
        font.pixelSize: DSTheme.fontSizeDefault
        color: DSTheme.blue
        visible: suffixText !== ""
    }
}
