import QtQuick 2.0
import QtQuick.Controls 2.0
import SddmComponents 2.0

/* Colors:
 *	- Hex format: "#AARRGGBB"
 *
 * Components: Rectangle, Text, Item, MouseArea
 *
 */

Rectangle {
    id: root

    readonly property color primary: config.primary ? config.primary : "#bb3333"
    readonly property color secondary: config.secondary ? config.secondary : "#992222"

    readonly property color primaryContainer: config.primaryContainer ? config.primaryContainer : "#222222"
    readonly property color secondaryContainer: config.secondaryContainer ? config.secondaryContainer : "#444444"

    readonly property real containerCornerRadius: config.containerCornerRadius ? config.containerCornerRadius : 12

    readonly property real paddingSmall: 8.0
    readonly property real paddingMedium: 12.0
    readonly property real paddingBig: 16.0

    // Hex color like: "
    color: primaryContainer

    signal tryLogin

    onTryLogin: {
        sddm.login(username.text, password.text, session.index);
    }

    Connections {
        target: sddm

        function onLogiSucceeded() {
            console.log("Login succeeded");
        }

        function onLoginFailed() {
            console.log("Login failed");
        }

        function onInformationMessage() {
            console.log("infomration message succeeded");
        }
    }

    Rectangle {
       width: root.width*0.5
       height: root.height*0.3

       color: "#88ffffff"

        anchors.left: parent.left
        anchors.bottom: parent.bottom

        Timer {
            id: timer
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
                date.text = Qt.formatDateTime(new Date(), "ddd, dd MMMM yyyy");
		time.text = Qt.formatDateTime(new Date(), "HH:mmap");

            }
        }


	Text {
	   id: date

	   width: parent.width
	   height:parent.height * 0.33

	   font.pixelSize: parent.height * 0.33


	   anchors.left: parent.left
	   anchors.bottom: time.top
	}

	Text {
	   id: time

	   width: parent.width
	   height:parent.height * 0.66

	   font.pixelSize: parent.height * 0.66
	   font.weight: 900

	   anchors.bottom: parent.bottom
	   anchors.right: date.right
	}

    }

    Rectangle {

        height: root.height / 2
        width: root.width / 4

        anchors.right: root.right
	anchors.rightMargin: root.width*0.05
	anchors.verticalCenter: root.verticalCenter


        radius: root.containerCornerRadius

        Column {

            width: parent.width
            height: parent.height

	    spacing: 10.0

            Text {
                id: helloText
                text: "Hello world!"
                y: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 24
                font.bold: true
            }

            Rectangle {

                width: parent.width * 0.8
                height: 30
                radius: root.containerCornerRadius

                anchors.horizontalCenter: parent.horizontalCenter

                border.color: root.primary
                border.pixelAligned: true
                border.width: 2.0

                TextField {
                    id: username

                    placeholderText: "Username"

                    width: parent.width
                    height: parent.height

                    leftPadding: root.paddingMedium
                    rightPadding: root.paddingMedium

                    color: root.primaryContainer

                    KeyNavigation.tab: password
                    KeyNavigation.backtab: login

                    verticalAlignment: TextInput.AlignVCenter
                    horizontalAlignment: TextInput.AlignHCenter

                    Keys.onPressed: function (event) {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            root.tryLogin();
                        }
                    }
                }
            }

            Rectangle {

                width: parent.width * 0.8
                height: 30
                radius: root.containerCornerRadius

                anchors.horizontalCenter: parent.horizontalCenter

                border.color: root.primary
                border.pixelAligned: true
                border.width: 2.0

                TextField {
                    id: password

                    placeholderText: "Password"

                    width: parent.width
                    height: parent.height

                    leftPadding: root.paddingMedium
                    rightPadding: root.paddingMedium

                    echoMode: TextField.Password

                    KeyNavigation.tab: login
                    KeyNavigation.backtab: username
                    Keys.onPressed: function (event) {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            root.tryLogin();
                        }
                    }
                }
            }

            // Session Row
            Row {
                Text {
                    height: 80
                    text: "Session:"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ComboBox {
                    id: session

                    model: sessionModel
                    index: sessionModel.lastIndex

                    width: 200
                    height: parent.height
                }
            }

            Button {
                id: login

                text: "Login"

		anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    root.tryLogin();
                }
            }
        }
    }
}
