import QtQuick

Rectangle {
    id: bg
    property alias text: textInput.text
    property string placeholderText: ""
    property real horizontalPadding: 15
    property bool isPassword: false

    AppStyle {
        id: style
    }

    radius: 10
    border.color: style.primaryColor
    border.pixelAligned: true
    border.width: 3.0

    layer.enabled: true
    layer.smooth: true

    Text {
        text: bg.placeholderText
        visible: !bg.text && !textInput.activeFocus
        anchors.centerIn: parent
        color: "#cc444444"
    }

    TextInput {
        id: textInput

        width: parent.width - (2 * bg.horizontalPadding)
        height: parent.height

        anchors.centerIn: bg

        clip: true

        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignHCenter

        echoMode: bg.isPassword ? TextInput.Password : TextInput.Normal
        passwordCharacter: style.passwordCharacter

        state: "unfocused"

        states: [
            State {
                name: "focused"
                when: textInput.activeFocus
                PropertyChanges {
                    bg.border.color: "red"
                }
            },
            State {
                name: "unfocused"
                when: !textInput.activeFocus
                PropertyChanges {
                    bg.border.color: "green"
                }
            }
        ]

        transitions: [
            Transition {
                from: "unfocused"
                to: "focused"
                ColorAnimation {
                    property: "bg.border.color"
                    duration: 200
                    easing.type: Easing.InBounce
                }
            },
            Transition {
                from: "focused"
                to: "unfocused"
                ColorAnimation {
                    property: "bg.border.color"
                    duration: 200
                    easing.type: Easing.OutBounce
                }
            }
        ]
    }
}
