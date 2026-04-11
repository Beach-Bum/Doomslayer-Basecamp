import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme 1.0
import controls

Control {
    id: root

    /** All sidebar sections (workspaces + views) **/
    property var sections: backend.sections
    /** Property to set the different ui modules discovered **/
    property var launcherApps: backend.launcherApps
    /** Current active section index **/
    property int currentActiveSectionIndex: backend.currentActiveSectionIndex

    signal launchUIModule(string name)
    signal updateLauncherIndex(int index)

    padding: 0
    bottomPadding: DSTheme.spacingXl
    topPadding: DSTheme.spacingXl + _d.systemTitleBarPadding
    topInset: _d.systemTitleBarPadding

    QtObject {
        id: _d

        readonly property var workspaceSections: (root.sections || []).filter(function(item) {
            return item && item.type === "workspace"
        })

        readonly property var viewSections: (root.sections || []).filter(function(item) {
            return item && item.type === "view"
        })

        readonly property var loadedApps: (root.launcherApps || []).filter(function(item) {
            return item && item.isLoaded === true
        })

        readonly property var unloadedApps: (root.launcherApps || []).filter(function(item) {
            return item && item.isLoaded === false
        })

        readonly property int systemTitleBarPadding: Qt.platform.os === "osx" ? 30 : 0
    }

    background: Rectangle {
        radius: 0
        color: DSTheme.bg
    }

    contentItem: ColumnLayout {
        spacing: DSTheme.spacingMd

        // Logo — Doomguy
        Image {
            source: "../icons/doomguy.png"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            Layout.alignment: Qt.AlignHCenter
            fillMode: Image.PreserveAspectFit
            smooth: false
        }

        SeparatorLine {}

        // Workspaces
        Column {
            Layout.fillWidth: true
            spacing: DSTheme.spacingSm

            Repeater {
                id: workspaceRepeater

                model: _d.workspaceSections

                SidebarIconButton {
                    required property int index
                    required property var modelData

                    width: parent.width
                    checked: root.currentActiveSectionIndex === index
                    icon.source: modelData.iconPath
                    onClicked: root.updateLauncherIndex(index)
                }
            }
        }

        SeparatorLine {}

        // Scrollable container for apps
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            contentItem: Flickable {
                clip: true
                contentWidth: width
                contentHeight: appsColumn.implicitHeight
                boundsBehavior: Flickable.StopAtBounds
                flickableDirection: Flickable.VerticalFlick
                interactive: contentHeight > height

                ColumnLayout {
                    id: appsColumn

                    width: parent.width
                    spacing: 2

                    // Loaded apps
                    Repeater {
                        id: loadedAppsRepeater
                        model: _d.loadedApps
                        delegate: SidebarAppDelegate {
                            Layout.fillWidth: true
                            loaded: true
                            loading: backend.loadingModules.indexOf(modelData.name) >= 0
                            enabled: !loading
                            checked: modelData.name === (backend.currentVisibleApp || "")
                            text: modelData.name
                            icon.source: modelData.iconPath
                            onClicked: root.launchUIModule(modelData.name)
                        }
                    }

                    SeparatorLine {
                        Layout.topMargin: DSTheme.spacingSm
                        Layout.bottomMargin: DSTheme.spacingSm
                        visible: loadedAppsRepeater.count > 0
                    }

                    // Unloaded apps
                    Repeater {
                        model: _d.unloadedApps
                        delegate: SidebarAppDelegate {
                            Layout.fillWidth: true
                            loaded: false
                            loading: backend.loadingModules.indexOf(modelData.name) >= 0
                            enabled: !loading
                            text: modelData.name
                            icon.source: modelData.iconPath
                            onClicked: root.launchUIModule(modelData.name)
                        }
                    }
                }
            }
        }

        SeparatorLine {}

        // View sections (Dashboard, Modules, Settings)
        ColumnLayout {
            spacing: DSTheme.spacingSm
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            Repeater {
                model: _d.viewSections
                delegate: SidebarCircleButton {
                    checked: backend.currentActiveSectionIndex - 1 === index
                    text: modelData.name
                    icon.source: modelData.iconPath
                    onClicked: root.updateLauncherIndex(_d.workspaceSections.length + index)
                }
            }
        }
    }

    // Reusable component for SeparatorLine
    component SeparatorLine: Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 1
        Layout.leftMargin: DSTheme.spacingXs
        Layout.rightMargin: DSTheme.spacingXs
        color: DSTheme.border
    }
}
