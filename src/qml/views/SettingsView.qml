import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme 1.0

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

        DSSectionTitle { text: "Settings" }

        // ── Appearance ───────────────────────────────────────────────
        DSSectionTitle { text: "Appearance"; small: true }

        DSThemePicker {}

        DSSeparator {}

        // ── Network ─────────────────────────────────────────────────
        DSSectionTitle { text: "Network"; small: true }

        DSKeyValueRow { label: "Waku endpoint";   value: "ws://127.0.0.1:8546" }
        DSKeyValueRow { label: "Codex endpoint";  value: "http://127.0.0.1:8080" }
        DSKeyValueRow { label: "Nomos endpoint";  value: "http://127.0.0.1:8090" }

        DSSeparator {}

        // ── Plugin Directory ─────────────────────────────────────────
        DSSectionTitle { text: "Plugin Directory"; small: true }

        DSKeyValueRow { label: "Path"; value: "~/.logos-basecamp/plugins"; copyable: false }

        Item { Layout.fillHeight: true }
    }
}
