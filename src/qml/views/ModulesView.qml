import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme 1.0
import panels

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: DSTheme.bg
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: DSTheme.spacingXl
        spacing: DSTheme.spacingMd

        RowLayout {
            Layout.fillWidth: true

            DSSectionTitle {
                text: "Modules"
                Layout.fillWidth: true
            }

            DSButton {
                text: "Install LGX Package"
                primary: true
                onClicked: backend.openInstallPluginDialog()
            }
        }

        DSTabBar {
            id: tabBar
            Layout.fillWidth: true
            model: ["UI Modules", "Core Modules"]
            currentIndex: 0
            onTabClicked: function(index) {
                if (index === 1) {
                    backend.refreshCoreModules()
                }
            }
        }

        DSSeparator {}

        StackLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: tabBar.currentIndex

            // UI Modules tab
            UiModulesTab {
                id: uiModulesTab
            }

            // Core Modules tab
            CoreModulesView {
                id: coreModulesTab
            }
        }
    }
}
