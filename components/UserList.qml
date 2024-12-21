import QtQuick

Row {
    id: userList

    clip: true

    // Todo:: set selectedIndex to the index of LastUser
    property int selectedIndex: 0
    spacing: 15

    Keys.onPressed: function (event) {
        if (event.key == Qt.Key_Left && selectedIndex !== 0) {
            selectedIndex = selectedIndex - 1;
        } else if (event.key == Qt.Key_Right && selectedIndex < userModel.count - 1) {
            selectedIndex = selectedIndex + 1;
        }
    }

    Repeater {
        model: userModel

        delegate: Item {

            height: Math.min((userList.width - 2 * userList.spacing) / 3, userList.height)
            width: Math.min((userList.width - 2 * userList.spacing) / 3, userList.height)

            opacity: (index === userList.selectedIndex) ? 1 : 0.5

            scale: ((index === userList.selectedIndex) ? (userList.focus ? 1.0 : 0.95) : 0.75)

            x: (index - userList.selectedIndex) * (width + userList.spacing) + userList.width / 2 - width / 2

            Rectangle {
                anchors.fill: parent
                radius: 12
                color: (index === userList.selectedIndex && userList.focus) ? style.primaryColor : style.secondaryColor

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Behavior on x {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            Behavior on y {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            Behavior on scale {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

            Component.onCompleted: {
                if (index === userList.selectedIndex)
                    username.text = name;
            }

            Column {
                anchors.centerIn: parent

                width: parent.width
                height: parent.height

                padding: parent.width * 0.1

                Image {
                    width: parent.width * 0.6
                    height: parent.height * 0.6
                    source: icon
                    fillMode: Image.PreserveAspectCrop
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: nameText
                    text: name

                    width: parent.width * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter

                    horizontalAlignment: Text.AlignHCenter

                    font.pixelSize: parent.height * 0.17
                    font.weight: 500
                    wrapMode: Text.Wrap
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    userList.selectedIndex = index;
                    username.text = name;
                    userList.forceActiveFocus();
                }
            }
        }
    }
}
