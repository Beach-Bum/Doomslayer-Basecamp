import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme 1.0

Item {
    id: root
    property int count: 0
    property string apiResult: ""
    property string httpStatus: "Not run"
    property string fileStatus: "Not run"
    property string openUrlStatus: "Not run"
    property string remoteLoadStatus: "Not run"
    property string imageStatus: "Not run"

    Rectangle {
        anchors.fill: parent
        color: DSTheme.bg
    }

    Flickable {
        anchors.fill: parent
        contentHeight: contentCol.implicitHeight + 48
        clip: true

        ColumnLayout {
            id: contentCol
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 16
            spacing: 8

            Row {
                spacing: 0
                Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                Text { text: "QML Counter"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge; font.bold: true }
                Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
            }

            Text {
                text: root.count.toString()
                font.family: DSTheme.fontFamily
                font.pixelSize: 32
                font.bold: true
                color: DSTheme.yellow
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: incLabel.implicitWidth + 20
                implicitHeight: 22
                color: "transparent"
                border.color: DSTheme.green
                border.width: 1

                Text { id: incLabel; anchors.centerIn: parent; text: "[Increment]"; color: DSTheme.green; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeMedium }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.count++ }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border; Layout.topMargin: 4; Layout.bottomMargin: 4 }

            Row {
                spacing: 0
                Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                Text { text: "Logos API bridge"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge; font.bold: true }
                Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
            }

            Text { text: "Call package_manager methods via the logos bridge."; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault; wrapMode: Text.WordWrap; Layout.fillWidth: true }

            Rectangle {
                implicitWidth: apiLabel.implicitWidth + 20; implicitHeight: 22; color: "transparent"; border.color: DSTheme.blue; border.width: 1
                Text { id: apiLabel; anchors.centerIn: parent; text: "[Get valid variants]"; color: DSTheme.blue; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeMedium }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                    onClicked: { if (typeof logos === "undefined" || !logos.callModule) { root.apiResult = "Logos bridge unavailable"; return }; root.apiResult = logos.callModule("package_manager", "getValidVariants", []) }
                }
            }

            Text { text: root.apiResult.length > 0 ? root.apiResult : "Result will appear here."; color: root.apiResult.length > 0 ? DSTheme.cyan : DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault; wrapMode: Text.WordWrap; Layout.fillWidth: true }

            Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border; Layout.topMargin: 4; Layout.bottomMargin: 4 }

            Row {
                spacing: 0
                Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                Text { text: "Sandbox probes"; color: DSTheme.yellow; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge; font.bold: true }
                Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
            }

            Text { text: "Trigger actions that would normally touch network or file system."; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault; wrapMode: Text.WordWrap; Layout.fillWidth: true }

            Rectangle {
                implicitWidth: httpLabel.implicitWidth + 20; implicitHeight: 22; color: "transparent"; border.color: DSTheme.border; border.width: 1
                Text { id: httpLabel; anchors.centerIn: parent; text: "[HTTP GET https://example.com]"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: { httpStatus = "Running..."; var xhr = new XMLHttpRequest(); xhr.onreadystatechange = function() { if (xhr.readyState === XMLHttpRequest.DONE) httpStatus = xhr.status === 0 ? "Blocked" : "Done: " + xhr.status }; xhr.onerror = function() { httpStatus = "Blocked" }; xhr.open("GET", "https://example.com", true); xhr.send() } }
            }
            Text { text: "HTTP: " + root.httpStatus; color: DSTheme.yellow; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }

            Rectangle {
                implicitWidth: fileLabel.implicitWidth + 20; implicitHeight: 22; color: "transparent"; border.color: DSTheme.border; border.width: 1
                Text { id: fileLabel; anchors.centerIn: parent; text: "[Read file:///etc/hosts]"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: { fileStatus = "Running..."; var xhr = new XMLHttpRequest(); xhr.timeout = 2000; xhr.onreadystatechange = function() { if (xhr.readyState === XMLHttpRequest.DONE) fileStatus = xhr.status === 0 ? "Blocked" : "Done: " + xhr.status }; xhr.onerror = function() { fileStatus = "Blocked" }; xhr.ontimeout = function() { fileStatus = "Timeout" }; xhr.open("GET", "file:///etc/hosts", true); xhr.send() } }
            }
            Text { text: "File: " + root.fileStatus; color: DSTheme.yellow; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }

            Rectangle {
                implicitWidth: urlLabel.implicitWidth + 20; implicitHeight: 22; color: "transparent"; border.color: DSTheme.border; border.width: 1
                Text { id: urlLabel; anchors.centerIn: parent; text: "[openUrlExternally(file:///etc/hosts)]"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: { try { openUrlStatus = "Return: " + Qt.openUrlExternally("file:///etc/hosts") } catch(e) { openUrlStatus = "Exception: " + e } } }
            }
            Text { text: "URL: " + root.openUrlStatus; color: DSTheme.yellow; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }

            Item { height: 20 }
        }
    }
}
