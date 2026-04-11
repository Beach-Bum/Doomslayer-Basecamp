import QtQuick 2.15

Rectangle {
    default property alias content: inner.data
    property string title: ""

    color:        DSTheme.bg
    border.color: DSTheme.border
    border.width: 1
    radius:       0

    Column {
        id: inner
        anchors.fill: parent
        anchors.margins: DSTheme.spacingMd
        spacing: DSTheme.spacingSm
    }
}
