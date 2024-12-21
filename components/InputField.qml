import QtQuick

Item {
    id: root

    property alias text: textInput.text
    property string placeholderText: ""
    property string label: ""
    property bool isPassword: false

    AppStyle {
        id: style
    }

    onFocusChanged: {
        if (root.focus)
            textInput.forceActiveFocus();
    }

    Text {
        id: labelText
        text: root.label
        font.pixelSize: parent.height * 0.25
        font.weight: 600
        color: style.secondaryColor
        anchors.bottom: bg.top
        anchors.bottomMargin: 2
    }

    Rectangle {
        id: bg

        height: root.label ? parent.height * 0.75 : parent.height
        width: parent.width

        radius: 10
        border.color: style.primaryColor
        border.pixelAligned: true
        border.width: 2.0

        layer.enabled: true
        layer.smooth: true

        color: "transparent"

        Behavior on border.width {
            SmoothedAnimation {
                velocity: 200
            }
        }

        Text {
            text: root.placeholderText
            visible: !root.text && !textInput.activeFocus
            font.pixelSize: parent.height * 0.4
            anchors.centerIn: parent
            color: "#cc444444"
        }

        TextInput {
            id: textInput

            clip: true

            echoMode: root.isPassword ? TextInput.Password : TextInput.Normal
            passwordCharacter: style.passwordCharacter

            font.pixelSize: parent.height * 0.4

            width: parent.width - 35
            height: parent.height
            anchors.centerIn: parent

            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter

            color: style.primaryColor

            state: "unfocused"

            states: [
                State {
                    name: "focused"
                    when: textInput.activeFocus
                    PropertyChanges {
                        bg.border.color: style.primaryColor
                        bg.border.width: 3.0
                        labelText.color: style.primaryColor
                    }
                },
                State {
                    name: "unfocused"
                    when: !textInput.activeFocus
                    PropertyChanges {
                        bg.border.color: style.secondaryColor
                        bg.border.width: 2.0
                        labelText.color: style.secondaryColor
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "unfocused"
                    to: "focused"
                    ColorAnimation {
                        properties: "bg.border.color; textLabel.color"
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                },
                Transition {
                    from: "focused"
                    to: "unfocused"
                    ColorAnimation {
                        properties: "bg.border.color; textLabel.color"
                        duration: 50
                        easing.type: Easing.InOutQuad
                    }
                }
            ]
        }
    }
}
