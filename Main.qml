import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import SddmComponents as SDDM
import "./components"

Rectangle {
    id: root

    SDDM.TextConstants {
        id: textConstants
    }

    Connections {
        target: sddm

        function onLoginSucceeded() {
            console.log("Login succeeded");
        }

        function onLoginFailed() {
            console.log("Login failed");
        }

        function onInformationMessage() {
            console.log("infomration message succeeded");
        }
    }

    AppStyle {
        id: style
    }

    signal tryLogin

    onTryLogin: {
        sddm.login(username.text, password.text, session.index);
    }

    Image {
        id: background_img
        source: "images/eclipse.jpg"
        anchors.fill: parent
    }
    ShaderEffectSource {
        id: background_blur
        sourceItem: background_img

        height: root.height
        width: login_box.width + root.width * 0.08

        anchors.verticalCenter: root.verticalCenter
        anchors.horizontalCenter: login_box.horizontalCenter

        sourceRect: Qt.rect(x, y, width, height)
    }
    MultiEffect {
        source: background_blur

        blur: 1
        blurMax: 64
        blurMultiplier: 0.5
        blurEnabled: true

        brightness: -0.03

        autoPaddingEnabled: true
        height: background_blur.height
        width: background_blur.width
        anchors.centerIn: background_blur
    }

    // Power off hiberante suspend
    Item {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.01
        anchors.bottomMargin: parent.height * 0.01

        height: parent.height * 0.07
        width: parent.width * 0.15

        Button {
            id: poweroff

            icon.name: "power-off"
            icon.source: "images/poweroff.svg"
            icon.width: width
            icon.height: height
            icon.color: (focus) ? style.primaryColor : style.secondaryColor

            width: parent.width * 0.33
            height: parent.height

            anchors.left: parent.left

	    KeyNavigation.tab: hibernate
	    KeyNavigation.backtab: login

	    Behavior on icon.color { ColorAnimation { duration:100 } }

            background: Rectangle {
                color: "transparent"
            }
            onClicked: {
                sddm.powerOff();
            }
        }
        Button {
            id: hibernate

            icon.name: "hibernate"
            icon.source: "images/hibernate.svg"
            icon.width: width
            icon.height: height
            icon.color: (focus) ? style.primaryColor : style.secondaryColor

            width: parent.width * 0.33
            height: parent.height

            anchors.horizontalCenter: parent.horizontalCenter

	    KeyNavigation.tab: reboot
	    KeyNavigation.backtab: poweroff

	    Behavior on icon.color { ColorAnimation { duration:100 } }

            onClicked: {
                sddm.hibernate();
            }
            background: Rectangle {
                color: "transparent"
            }
        }
        Button {
            id: reboot

            icon.name: "reboot"
            icon.source: "images/reboot.svg"
            icon.width: width
            icon.height: height
            icon.color: (focus) ? style.primaryColor : style.secondaryColor

            width: parent.width * 0.33
            height: parent.height

            anchors.right: parent.right

	    KeyNavigation.tab: sessionComboBox
	    KeyNavigation.backtab: hibernate

	    Behavior on icon.color { ColorAnimation { duration:100 } }

            onClicked: {
                sddm.reboot();
            }
            background: Rectangle {
                color: "transparent"
            }
        }
        MultiEffect {
            shadowEnabled: true
            shadowBlur: 1
            shadowColor: "black"
            autoPaddingEnabled: true
            source: poweroff
            anchors.fill: poweroff
        }
        MultiEffect {
            shadowEnabled: true
            shadowBlur: 1
            shadowColor: "black"
            autoPaddingEnabled: true
            source: hibernate
            anchors.fill: hibernate
        }
        MultiEffect {
            shadowEnabled: true
            shadowBlur: 1
            shadowColor: "black"
            autoPaddingEnabled: true
            source: reboot
            anchors.fill: reboot
        }
    }

    // Date and time
    Item {
        width: time.paintedWidth
        height: root.height * 0.23

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: parent.width * 0.03
        anchors.topMargin: parent.height * 0.05

        Timer {
            id: timer
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
                date.text = Qt.formatDateTime(new Date(), "ddd, dd MMM yyyy");
                time.text = Qt.formatDateTime(new Date(), "hh:mmAP");
            }
        }

        Text {
            id: date
            height: parent.height * 0.25
            text: Qt.formatDateTime(new Date(), "ddd, dd MMM yyyy")
            font.pixelSize: parent.height * 0.22
            font.weight: 600
            color: style.primaryColor

            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: time
            height: parent.height * 0.75
            text: Qt.formatDateTime(new Date(), "hh:mmAP")
            font.pixelSize: parent.height * 0.6
            font.weight: 900
            color: style.primaryColor

            anchors.top: date.bottom
            anchors.left: parent.left
        }

        MultiEffect {
            source: date
            anchors.fill: date
            autoPaddingEnabled: true
            shadowBlur: 1
            shadowColor: "black"
            shadowEnabled: true
        }
        MultiEffect {
            source: time
            anchors.fill: time
            autoPaddingEnabled: true
            shadowBlur: 1
            shadowColor: "black"
            shadowEnabled: true
        }
    }

    // session and keyboard
    Item {
        width: login_box.width
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: login_box.horizontalCenter

        Text {
            id: session_label
            text: textConstants.session
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height
        }
        DropDownMenu {
            id: sessionComboBox

            model: sessionModel
            currentIndex: sessionModel.lastIndex
            textRole: "name"

            width: parent.width * 0.3
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: session_label.right

            KeyNavigation.tab: keyboard_layout
            KeyNavigation.backtab: login
        }

        //Keyboard Layout
        Text {
            id: layout_label
            text: textConstants.layout
            verticalAlignment: Text.AlignVCenter

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: keyboard_layout.left
            font.pixelSize: parent.height
        }

        SDDM.LayoutBox {
            id: keyboard_layout
            width: parent.width * 0.3
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right

            KeyNavigation.tab: userList 
            KeyNavigation.backtab: sessionComboBox
        }
    }

    Item {
        id: login_box

        height: root.height / 2
        width: root.width / 4

        anchors.right: root.right
        anchors.rightMargin: root.width * 0.075
        anchors.verticalCenter: root.verticalCenter

        Column {

            anchors.centerIn: parent

            height: parent.height * 0.8
            width: parent.width * 0.8




	    UserList {
	       id:userList

	       width:parent.width
	       height:parent.height*0.3

	       KeyNavigation.tab: username
	       KeyNavigation.backtab: keyboard_layout
	    }

            Item {
                width: 1
                height: parent.height * 0.1
            }

            InputField {
                id: username

                width: parent.width
                height: parent.height * 0.15

                anchors.horizontalCenter: parent.horizontalCenter

                label: textConstants.userName
                placeholderText: textConstants.promptUser

                KeyNavigation.tab: password
                KeyNavigation.backtab: keyboard_layout

                Keys.onPressed: function (event) {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin();
                    }
                }
            }

            // Spacer
            Item {
                height: parent.height * 0.08
                width: 1
            }

            InputField {
                id: password

                width: parent.width
                height: parent.height * 0.15
                anchors.horizontalCenter: parent.horizontalCenter

                placeholderText: textConstants.promptPassword
                label: textConstants.password

                isPassword: true

                KeyNavigation.tab: login
                KeyNavigation.backtab: username

                Keys.onPressed: function (event) {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin();
                    }
                }
            }

            Item {
                height: parent.height * 0.15
                width: 1
            }

            Button {
                id: login

                text: textConstants.login

                font.pixelSize: parent.height * 0.05
                font.weight: 700

                width: parent.width * 0.4
                height: parent.height * 0.1

                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    root.tryLogin();
                }

                background: Rectangle {
                    radius: 10
                    color: (login.hovered || login.focus) ? style.primaryColor : style.secondaryColor
                }
            }
        }
    }
}
