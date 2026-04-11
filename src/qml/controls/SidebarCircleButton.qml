import QtQuick
import QtQuick.Controls
import theme 1.0

AbstractButton {
    id: root

    implicitHeight: 46
    implicitWidth: 56

    readonly property string _iconsDir: "file:///Users/beachbum/Downloads/logos-basecamp/src/qml/icons/"

    readonly property string _iconSource: {
        var n = root.text.toLowerCase()
        if (n.indexOf("dash") >= 0)    return _iconsDir + "dashboard.png"
        if (n.indexOf("module") >= 0)  return _iconsDir + "modules.png"
        if (n.indexOf("setting") >= 0) return _iconsDir + "settings.png"
        return ""
    }

    background: Rectangle {
        radius: 0
        color: root.checked ? DSTheme.activeBg
             : root.hovered ? DSTheme.statusBg
             : "transparent"
        border.width: root.hovered ? 1 : 0
        border.color: DSTheme.border
    }

    contentItem: Item {
        Image {
            id: viewIcon
            anchors.centerIn: parent
            width: 24
            height: 24
            source: root._iconSource
            fillMode: Image.PreserveAspectFit
            visible: viewIcon.status === Image.Ready
            opacity: root.checked ? 1.0 : 0.5
        }

        Text {
            anchors.centerIn: parent
            font.family: DSTheme.fontFamily
            font.pixelSize: 12
            text: root.text.substring(0, 3)
            color: root.checked ? DSTheme.yellow : DSTheme.dimFg
            visible: !viewIcon.visible
        }
    }
}
