import QtQuick 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    spacing: 0

    Repeater {
        model: DSTheme.themeNames
        delegate: Rectangle {
            Layout.fillWidth: true
            height: DSTheme.headerHeight
            color: DSTheme.currentTheme === modelData ? DSTheme.activeBg : themeMa.containsMouse ? DSTheme.statusBg : "transparent"

            Row {
                anchors.fill: parent
                anchors.leftMargin: DSTheme.spacingSm
                spacing: DSTheme.spacingSm + 2

                Text {
                    text: DSTheme.currentTheme === modelData ? "\u2713" : " "
                    color: DSTheme.cyan
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    width: 12
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: modelData
                    color: DSTheme.currentTheme === modelData ? DSTheme.fg : DSTheme.blue
                    font.family: DSTheme.fontFamily
                    font.pixelSize: DSTheme.fontSizeDefault
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                id: themeMa
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: DSTheme.setTheme(modelData)
            }
        }
    }
}
