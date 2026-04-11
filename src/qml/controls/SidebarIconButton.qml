import QtQuick
import QtQuick.Controls
import theme 1.0

AbstractButton {
    id: root

    implicitHeight: 42
    checkable: true
    autoExclusive: true

    background: Rectangle {
        radius: 0
        color: root.checked ? DSTheme.activeBg : "transparent"
    }

    contentItem: Item {
        Text {
            anchors.centerIn: parent
            font.family: DSTheme.fontFamily
            font.pixelSize: 16
            text: "\u2726"
            color: root.checked ? DSTheme.yellow : DSTheme.dimFg
        }
    }
}
