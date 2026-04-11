import QtQuick
import QtQuick.Controls
import theme 1.0

AbstractButton {
    id: root

    property bool loaded: false
    property bool loading: false

    implicitHeight: 50

    // Resolve icons via absolute file path
    readonly property string _iconsDir: "file:///Users/beachbum/Downloads/logos-basecamp/src/qml/icons/"

    readonly property string _iconSource: {
        var n = root.text.toLowerCase()
        if (n.indexOf("daemon") >= 0)      return _iconsDir + "daemon.png"
        if (n.indexOf("counter_qml") >= 0) return _iconsDir + "terminal.png"
        if (n.indexOf("counter") >= 0)     return _iconsDir + "counter.png"
        if (n.indexOf("package") >= 0)     return _iconsDir + "packages.png"
        if (n.indexOf("webview") >= 0)     return _iconsDir + "globe.png"
        return _iconsDir + "module.png"
    }

    background: Rectangle {
        radius: 0
        color: root.checked ? DSTheme.activeBg
             : root.hovered ? DSTheme.statusBg
             : "transparent"

        Rectangle {
            anchors.left: parent.left
            width: 3
            height: parent.height
            color: root.checked ? DSTheme.yellow : "transparent"
        }
    }

    contentItem: Item {
        Image {
            id: appIcon
            anchors.centerIn: parent
            width: 28
            height: 28
            source: root._iconSource
            fillMode: Image.PreserveAspectFit
            visible: !root.loading && appIcon.status === Image.Ready
            opacity: root.loaded ? (root.checked ? 1.0 : 0.6) : 0.25
        }

        Text {
            anchors.centerIn: parent
            font.family: DSTheme.fontFamily
            font.pixelSize: 14
            text: "\u2026"
            color: DSTheme.dimFg
            visible: root.loading
        }

        Text {
            anchors.centerIn: parent
            font.family: DSTheme.fontFamily
            font.pixelSize: 14
            font.bold: true
            text: root.text.substring(0, 2)
            color: root.loaded ? DSTheme.fg : DSTheme.dimFg
            visible: !root.loading && !appIcon.visible
        }
    }
}
