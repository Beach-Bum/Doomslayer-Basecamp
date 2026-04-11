import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "theme"

Item {
    id: root

    // ── State ─────────────────────────────────────────────────────
    property string daemonStatus: "disconnected"
    property string currentModel: "mamba-370m"
    property real tokensPerSec: 0
    property real memoryMb: 0
    property int totalTokens: 0
    property string currentView: "chat"  // chat | dashboard | agora

    // Chat state
    property string userInput: ""
    ListModel { id: chatModel }
    ListModel { id: agoraLogModel }

    // ── Simulated daemon connection ───────────────────────────────
    Timer {
        id: connectTimer
        interval: 2000
        onTriggered: {
            root.daemonStatus = "connected"
            root.tokensPerSec = 42.7
            root.memoryMb = 384
            appendChat("system", "daemon-ai connected · model: " + root.currentModel + " · ready for inference", DSTheme.cyan)
        }
    }

    Component.onCompleted: {
        appendChat("system", "Connecting to daemon-ai on localhost:8765…", DSTheme.dimFg)
        daemonStatus = "connecting"
        connectTimer.start()
    }

    function appendChat(role, message, color) {
        chatModel.append({ role: role, message: message, color: color || DSTheme.fg })
    }

    function sendMessage() {
        if (inputField.text.trim().length === 0) return
        var msg = inputField.text.trim()
        inputField.text = ""

        appendChat("user", msg, DSTheme.yellow)
        root.totalTokens += msg.split(" ").length

        // Simulate daemon-ai response
        appendChat("system", "daemon-ai reasoning…", DSTheme.dimFg)
        responseTimer.userMsg = msg
        responseTimer.start()
    }

    Timer {
        id: responseTimer
        property string userMsg: ""
        interval: 800 + Math.random() * 1200
        onTriggered: {
            // Remove "reasoning…" line
            if (chatModel.count > 0 && chatModel.get(chatModel.count - 1).message === "daemon-ai reasoning…")
                chatModel.remove(chatModel.count - 1)

            var responses = [
                "Based on the Mamba state space model analysis, the optimal approach involves leveraging sequential token processing with selective state updates. The model identifies key semantic patterns in your query and generates a response through efficient linear-time inference.",
                "Running local inference on " + root.currentModel + ". The SSM architecture processes your input through a series of state transitions, each capturing relevant context without the quadratic attention overhead of transformer models.",
                "Inference complete. daemon-ai processed " + (userMsg.split(" ").length * 3) + " tokens at " + root.tokensPerSec.toFixed(1) + " tok/s. Memory usage: " + root.memoryMb + " MB. No data left the local machine.",
                "The sovereign inference pipeline evaluated your query through the Mamba selective scan mechanism. All computation ran locally on your hardware — no external API calls, no data exfiltration, no cloud dependencies."
            ]
            var resp = responses[Math.floor(Math.random() * responses.length)]
            root.totalTokens += resp.split(" ").length
            appendChat("daemon", resp, DSTheme.fg)
        }
    }

    // ── Agora integration simulation ──────────────────────────────
    function simulateAgoraIntent() {
        agoraLogModel.append({ msg: "► Intent received via Logos Messaging", clr: DSTheme.dimFg })
        agoraLogModel.append({ msg: "  buyer: 0x3a9f…c7d2 · category: inference · budget: 50 NOM", clr: DSTheme.blue })
        agoraLogModel.append({ msg: "  task: Analyze market sentiment for NOM/ETH pair", clr: DSTheme.fg })

        Qt.callLater(function() {
            agoraEvalTimer.start()
        })
    }

    Timer {
        id: agoraEvalTimer
        interval: 1500
        onTriggered: {
            agoraLogModel.append({ msg: "  daemon-ai evaluating intent with " + root.currentModel + "…", clr: DSTheme.yellow })
            agoraResponseTimer.start()
        }
    }

    Timer {
        id: agoraResponseTimer
        interval: 2000
        onTriggered: {
            agoraLogModel.append({ msg: "  ✓ ACCEPT — task matches capabilities, price within margin", clr: DSTheme.cyan })
            agoraLogModel.append({ msg: "  Generating offer: 0.002 NOM/token · est. 2,400 tokens · total 4.80 NOM", clr: DSTheme.blue })
            agoraLogModel.append({ msg: "  Offer sent via Logos Messaging · session: " + Math.random().toString(16).slice(2, 10), clr: DSTheme.cyan })
            agoraLogModel.append({ msg: "", clr: DSTheme.dimFg })
            agoraLogModel.append({ msg: "  daemon-ai executing task locally…", clr: DSTheme.dimFg })
            agoraExecTimer.start()
        }
    }

    Timer {
        id: agoraExecTimer
        interval: 3000
        onTriggered: {
            root.totalTokens += 2400
            agoraLogModel.append({ msg: "  ✓ Task complete · 2,412 tokens generated · " + root.tokensPerSec.toFixed(1) + " tok/s", clr: DSTheme.cyan })
            agoraLogModel.append({ msg: "  Output pinned to Logos Storage · CID: QmXk3Np9r2fB7v…", clr: DSTheme.blue })
            agoraLogModel.append({ msg: "  LSSA escrow released · +4.80 NOM · reputation updated", clr: DSTheme.cyan })
            agoraLogModel.append({ msg: "  ─────────────────────────────────────────", clr: DSTheme.border })
        }
    }

    // ── UI ─────────────────────────────────────────────────────────
    Rectangle {
        anchors.fill: parent
        color: DSTheme.bg

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // ── Top bar with tabs ─────────────────────────────────
            Rectangle {
                Layout.fillWidth: true
                height: 22
                color: DSTheme.statusBg

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8

                    Text {
                        text: "◈ daemon-ai"
                        color: DSTheme.yellow
                        font.family: DSTheme.fontFamily
                        font.pixelSize: DSTheme.fontSizeMedium
                        font.bold: true
                    }
                    Text { text: " │ "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeMedium }
                    Text { text: root.currentModel; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeMedium }
                    Text { text: " │ "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeMedium }

                    // Status dot
                    Rectangle {
                        width: 6; height: 6; radius: 3
                        color: root.daemonStatus === "connected" ? DSTheme.cyan : root.daemonStatus === "connecting" ? DSTheme.yellow : DSTheme.red
                    }
                    Text {
                        text: root.daemonStatus
                        color: root.daemonStatus === "connected" ? DSTheme.cyan : DSTheme.yellow
                        font.family: DSTheme.fontFamily
                        font.pixelSize: DSTheme.fontSizeDefault
                    }

                    Item { Layout.fillWidth: true }

                    // Tab switcher
                    Repeater {
                        model: [
                            { label: "chat", view: "chat" },
                            { label: "dashboard", view: "dashboard" },
                            { label: "agora", view: "agora" }
                        ]
                        delegate: Text {
                            text: modelData.label
                            color: root.currentView === modelData.view ? DSTheme.yellow : tabMa.containsMouse ? DSTheme.fg : DSTheme.dimFg
                            font.family: DSTheme.fontFamily
                            font.pixelSize: DSTheme.fontSizeDefault
                            font.bold: root.currentView === modelData.view
                            MouseArea { id: tabMa; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: root.currentView = modelData.view }
                        }
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border }

            // ── Content ───────────────────────────────────────────
            StackLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: ["chat", "dashboard", "agora"].indexOf(root.currentView)

                // ══════════════════════════════════════════════════
                // CHAT VIEW
                // ══════════════════════════════════════════════════
                ColumnLayout {
                    spacing: 0

                    // Chat messages
                    ListView {
                        id: chatView
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: chatModel
                        clip: true
                        spacing: 2
                        ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

                        delegate: Rectangle {
                            width: chatView.width
                            height: msgCol.implicitHeight + 8
                            color: model.role === "user" ? DSTheme.statusBg : "transparent"

                            RowLayout {
                                id: msgCol
                                anchors.fill: parent
                                anchors.leftMargin: 8
                                anchors.rightMargin: 8
                                anchors.topMargin: 4
                                anchors.bottomMargin: 4
                                spacing: 8

                                Text {
                                    text: {
                                        if (model.role === "user") return ">"
                                        if (model.role === "daemon") return "◈"
                                        return "·"
                                    }
                                    color: {
                                        if (model.role === "user") return DSTheme.yellow
                                        if (model.role === "daemon") return DSTheme.cyan
                                        return DSTheme.dimFg
                                    }
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: DSTheme.fontSizeMedium
                                    font.bold: true
                                    Layout.alignment: Qt.AlignTop
                                }

                                Text {
                                    text: model.message
                                    color: model.color
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: DSTheme.fontSizeDefault
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                }
                            }
                        }

                        onCountChanged: positionViewAtEnd()
                    }

                    Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border }

                    // Input
                    Rectangle {
                        Layout.fillWidth: true
                        height: 28
                        color: DSTheme.bg

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            anchors.rightMargin: 8
                            spacing: 6

                            Text {
                                text: ">"
                                color: DSTheme.yellow
                                font.family: DSTheme.fontFamily
                                font.pixelSize: DSTheme.fontSizeMedium
                                font.bold: true
                            }

                            TextInput {
                                id: inputField
                                Layout.fillWidth: true
                                color: DSTheme.fg
                                font.family: DSTheme.fontFamily
                                font.pixelSize: DSTheme.fontSizeMedium
                                clip: true
                                onAccepted: root.sendMessage()

                                Text {
                                    anchors.fill: parent
                                    text: "Type a message… (Enter to send)"
                                    color: DSTheme.dimFg
                                    font.family: DSTheme.fontFamily
                                    font.pixelSize: DSTheme.fontSizeMedium
                                    visible: !parent.text && !parent.activeFocus
                                }
                            }
                        }
                    }
                }

                // ══════════════════════════════════════════════════
                // DASHBOARD VIEW
                // ══════════════════════════════════════════════════
                ScrollView {
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                    ColumnLayout {
                        width: parent.width
                        spacing: 8

                        Item { height: 8 }

                        // Section: Status
                        RowLayout {
                            spacing: 0
                            Layout.leftMargin: 16
                            Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                            Text { text: "Daemon Status"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge; font.bold: true }
                            Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                        }

                        // Stats
                        RowLayout {
                            spacing: 24
                            Layout.leftMargin: 16

                            Column {
                                spacing: 2
                                Text { text: root.daemonStatus === "connected" ? "ONLINE" : "OFFLINE"; color: root.daemonStatus === "connected" ? DSTheme.cyan : DSTheme.red; font.family: DSTheme.fontFamily; font.pixelSize: 18; font.bold: true }
                                Text { text: "Status"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeSmall }
                            }
                            Column {
                                spacing: 2
                                Text { text: root.tokensPerSec.toFixed(1); color: DSTheme.blue; font.family: DSTheme.fontFamily; font.pixelSize: 18; font.bold: true }
                                Text { text: "tok/s"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeSmall }
                            }
                            Column {
                                spacing: 2
                                Text { text: root.memoryMb.toFixed(0) + " MB"; color: DSTheme.yellow; font.family: DSTheme.fontFamily; font.pixelSize: 18; font.bold: true }
                                Text { text: "Memory"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeSmall }
                            }
                            Column {
                                spacing: 2
                                Text { text: root.totalTokens.toLocaleString(); color: DSTheme.magenta; font.family: DSTheme.fontFamily; font.pixelSize: 18; font.bold: true }
                                Text { text: "Total Tokens"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeSmall }
                            }
                        }

                        Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border; Layout.leftMargin: 16; Layout.rightMargin: 16 }

                        // Section: Model
                        RowLayout {
                            spacing: 0
                            Layout.leftMargin: 16
                            Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                            Text { text: "Model"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge; font.bold: true }
                            Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                        }

                        Repeater {
                            model: [
                                { key: "Active Model", val: root.currentModel },
                                { key: "Architecture", val: "Mamba SSM (Selective State Space)" },
                                { key: "Endpoint",     val: "localhost:8765" },
                                { key: "Runtime",      val: "C++ (daemon-ai)" },
                                { key: "Privacy",      val: "✓ Fully local — no external API calls" },
                            ]
                            delegate: RowLayout {
                                spacing: 8
                                Layout.leftMargin: 20
                                Text { text: modelData.key + ":"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault; Layout.minimumWidth: 130 }
                                Text { text: modelData.val; color: modelData.key === "Privacy" ? DSTheme.cyan : DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }
                            }
                        }

                        Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border; Layout.leftMargin: 16; Layout.rightMargin: 16 }

                        // Section: Available Models
                        RowLayout {
                            spacing: 0
                            Layout.leftMargin: 16
                            Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                            Text { text: "Available Models"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge; font.bold: true }
                            Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                        }

                        Repeater {
                            model: [
                                { name: "mamba-370m",  params: "370M",  size: "740 MB",  speed: "~45 tok/s", active: true },
                                { name: "mamba-1.4b",  params: "1.4B",  size: "2.8 GB",  speed: "~18 tok/s", active: false },
                                { name: "mamba-2.8b",  params: "2.8B",  size: "5.6 GB",  speed: "~9 tok/s",  active: false },
                            ]
                            delegate: Rectangle {
                                Layout.fillWidth: true
                                Layout.leftMargin: 16
                                Layout.rightMargin: 16
                                height: 24
                                color: modelData.active ? DSTheme.activeBg : modelMa.containsMouse ? DSTheme.statusBg : "transparent"
                                border.color: modelData.active ? DSTheme.cyan : "transparent"
                                border.width: modelData.active ? 1 : 0

                                MouseArea { id: modelMa; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                    onClicked: { root.currentModel = modelData.name; appendChat("system", "Switched to model: " + modelData.name, DSTheme.cyan) }
                                }

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 8
                                    spacing: 16
                                    Text { text: modelData.active ? "✓" : " "; color: DSTheme.cyan; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault; width: 12 }
                                    Text { text: modelData.name; color: modelData.active ? DSTheme.yellow : DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault; font.bold: modelData.active; Layout.minimumWidth: 120 }
                                    Text { text: modelData.params; color: DSTheme.blue; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault; Layout.minimumWidth: 60 }
                                    Text { text: modelData.size; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault; Layout.minimumWidth: 80 }
                                    Text { text: modelData.speed; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }
                                }
                            }
                        }

                        Item { height: 16 }
                    }
                }

                // ══════════════════════════════════════════════════
                // AGORA VIEW
                // ══════════════════════════════════════════════════
                ColumnLayout {
                    spacing: 0

                    // Header
                    ColumnLayout {
                        spacing: 4
                        Layout.margins: 16

                        RowLayout {
                            spacing: 0
                            Text { text: "\u251C\u2500 "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                            Text { text: "Agora Integration"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge; font.bold: true }
                            Text { text: " \u2500"; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeLarge }
                        }

                        Text {
                            text: "daemon-ai evaluates buy intents, generates offers, and executes tasks for the Agora marketplace"
                            color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault
                            wrapMode: Text.WordWrap; Layout.fillWidth: true
                        }

                        RowLayout {
                            spacing: 8
                            Rectangle {
                                implicitWidth: simLabel.implicitWidth + 20; implicitHeight: 22
                                color: "transparent"; border.color: DSTheme.blue; border.width: 1
                                Text { id: simLabel; anchors.centerIn: parent; text: "[Simulate Buy Intent]"; color: DSTheme.blue; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeMedium }
                                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.simulateAgoraIntent() }
                            }

                            Rectangle {
                                implicitWidth: clearLabel.implicitWidth + 20; implicitHeight: 22
                                color: "transparent"; border.color: DSTheme.border; border.width: 1
                                Text { id: clearLabel; anchors.centerIn: parent; text: "[Clear]"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeMedium }
                                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: agoraLogModel.clear() }
                            }
                        }
                    }

                    Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border }

                    // Agora log
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: DSTheme.bg

                        ListView {
                            id: agoraLog
                            anchors.fill: parent
                            anchors.margins: 8
                            model: agoraLogModel
                            clip: true
                            spacing: 0
                            ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

                            delegate: Text {
                                width: agoraLog.width
                                text: model.msg
                                color: model.clr
                                font.family: DSTheme.fontFamily
                                font.pixelSize: DSTheme.fontSizeDefault
                                lineHeight: 1.6
                                wrapMode: Text.WrapAnywhere
                            }

                            onCountChanged: positionViewAtEnd()
                        }
                    }

                    // Status bar
                    Rectangle { Layout.fillWidth: true; height: 1; color: DSTheme.border }
                    Rectangle {
                        Layout.fillWidth: true; height: 20; color: DSTheme.statusBg
                        RowLayout {
                            anchors.fill: parent; anchors.leftMargin: 8; anchors.rightMargin: 8
                            Text { text: "[agora]"; color: DSTheme.fg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeMedium; font.bold: true }
                            Text { text: " │ "; color: DSTheme.border; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeMedium }
                            Text { text: "Listening on Logos Messaging for buy intents"; color: DSTheme.blue; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }
                            Item { Layout.fillWidth: true }
                            Text { text: root.totalTokens + " tokens processed"; color: DSTheme.dimFg; font.family: DSTheme.fontFamily; font.pixelSize: DSTheme.fontSizeDefault }
                        }
                    }
                }
            }
        }
    }
}
