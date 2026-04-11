import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

// Usage:
//   DSTable {
//       columns: [ {title:"NAME", width:180, role:"name", color: DSTheme.yellow},
//                  {title:"ID",   width:200, role:"id",   color: DSTheme.cyan} ]
//       model: myListModel
//   }
Item {
    id: root
    property var columns: []
    property alias model: listView.model

    implicitHeight: DSTheme.headerHeight + 1 + (listView.count * DSTheme.rowHeight)

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Header
        Rectangle {
            Layout.fillWidth: true
            height: DSTheme.headerHeight
            color: DSTheme.statusBg

            Row {
                anchors.fill: parent
                anchors.leftMargin: DSTheme.spacingSm + 2
                spacing: 0

                Repeater {
                    model: root.columns
                    delegate: Text {
                        text: modelData.title
                        color: DSTheme.dimFg
                        font.family: DSTheme.fontFamily
                        font.pixelSize: DSTheme.fontSizeSmall
                        font.bold: true
                        width: modelData.width || 100
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border }

        // Rows
        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
            clip: true
            ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

            delegate: Rectangle {
                width: listView.width
                height: DSTheme.rowHeight
                color: rowMa.containsMouse ? DSTheme.statusBg : index % 2 === 0 ? DSTheme.bg : DSTheme.altBg

                MouseArea { id: rowMa; anchors.fill: parent; hoverEnabled: true }

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: DSTheme.spacingSm + 2
                    spacing: 0

                    Repeater {
                        model: root.columns
                        delegate: Text {
                            text: {
                                var val = listView.model.get(index)
                                return val ? (val[modelData.role] || "") : ""
                            }
                            color: modelData.color || DSTheme.fg
                            font.family: DSTheme.fontFamily
                            font.pixelSize: DSTheme.fontSizeDefault
                            font.bold: modelData.bold || false
                            width: modelData.width || 100
                            elide: Text.ElideRight
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
}
