import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    property alias model: logView.model

    function appendLine(message, color) {
        if (!model) return
        model.append({ msg: message, clr: color || DSTheme.dimFg })
        logView.positionViewAtEnd()
    }

    function clear() {
        if (model) model.clear()
    }

    color: DSTheme.bg
    border.color: DSTheme.border
    border.width: 1
    radius: 0

    ListView {
        id: logView
        anchors.fill: parent
        anchors.margins: DSTheme.spacingSm + 2
        spacing: 0
        clip: true
        ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

        delegate: Text {
            width: logView.width
            text: model.msg
            color: model.clr
            font.family: DSTheme.fontFamily
            font.pixelSize: DSTheme.fontSizeDefault
            lineHeight: 1.6
            wrapMode: Text.WrapAnywhere
        }
    }
}
