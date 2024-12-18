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
    border.width: 2.0

    layer.enabled: true
    layer.smooth: true

    color: "#55ffffff"

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
                    bg.border.color: style.primaryColor
                    bg.border.width: 3.0
                }
            },
            State {
                name: "unfocused"
                when: !textInput.activeFocus
                PropertyChanges {
                    bg.border.color: style.secondaryColor
                    bg.border.width: 2.0
                }
            }
        ]

        transitions: [
            Transition {
                from: "unfocused"
                to: "focused"
                NumberAnimation {
                    property: "bg.border.width"
                    duration: 100
                    easing.type: Easing.InBounce
                }
                ColorAnimation {
                    property: "bg.border.color"
                    duration: 200
                    easing.type: Easing.InBounce
                }
            },
            Transition {
                from: "focused"
                to: "unfocused"
                NumberAnimation {
                    property: "bg.border.width"
                    duration: 100
                    easing.type: Easing.OutBounce
                }
                ColorAnimation {
                    property: "bg.border.color"
                    duration: 200
                    easing.type: Easing.OutBounce
                }
            }
        ]
    }
}
