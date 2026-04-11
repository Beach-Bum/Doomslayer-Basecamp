import QtQuick 2.15

Rectangle {
    property int orientation: Qt.Horizontal

    implicitWidth:  orientation === Qt.Horizontal ? parent.width : 1
    implicitHeight: orientation === Qt.Horizontal ? 1 : parent.height
    color: DSTheme.border
}
