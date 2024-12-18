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
	anchors.leftMargin: parent.width*0.01
	anchors.bottomMargin: parent.height*0.01

        height: parent.height * 0.07
        width: parent.width * 0.15

        Button {
	   id:poweroff
	   background: Rectangle {
	      color:"transparent"
	   }
	    icon.name:"power-off"
            icon.source: "images/poweroff.svg"
	    icon.width:width
	    icon.height:height
	    icon.color:style.secondaryColor
            anchors.left: parent.left
            width: parent.width * 0.33
            height: parent.height

            onClicked: {
                sddm.powerOff();
            }
        }
        Button {
	   id:hibernate
	   background: Rectangle {
	      color:"transparent"
	   }
	    icon.name:"hibernate"
            icon.source: "images/hibernate.svg"
	    icon.width:width
	    icon.height:height
	    icon.color:style.secondaryColor

            anchors.horizontalCenter: parent.horizontalCenter

            width: parent.width * 0.33
            height: parent.height

            onClicked: {
                sddm.hibernate();
            }
        }
        Button {
	   id:reboot
	    background: Rectangle {
	       color:"transparent"
	    }
	    icon.name:"reboot"
            icon.source: "images/reboot.svg"
	    icon.width:width
	    icon.height:height
	    icon.color:style.secondaryColor

            anchors.right: parent.right

            width: parent.width * 0.33
            height: parent.height

            onClicked: {
                sddm.reboot();
            }
        }


	MultiEffect {
	   shadowEnabled:true
	   shadowBlur:1
	   shadowColor:"black"
	   autoPaddingEnabled:true
	   source:poweroff
	   anchors.fill:poweroff 
	}
	MultiEffect {
	   shadowEnabled:true
	   shadowBlur:1
	   shadowColor:"black"
	   autoPaddingEnabled:true
	   source:hibernate
	   anchors.fill:hibernate 
	}
	MultiEffect {
	   shadowEnabled:true
	   shadowBlur:1
	   shadowColor:"black"
	   autoPaddingEnabled:true
	   source:reboot
	   anchors.fill:reboot
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
            text: Qt.formatDateTime(new Date(), "hh:mmap")
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

    Item {
        id: login_box

        height: root.height / 2
        width: root.width / 4

        anchors.right: root.right
        anchors.rightMargin: root.width * 0.075
        anchors.verticalCenter: root.verticalCenter

        // radius: style.containerCornerRadius

        // Shadow around
        //MultiEffect {
        //   source: login_box
        //   anchors.fill: login_box
        //   autoPaddingEnabled: true
        //   shadowBlur: 0.4
        //   shadowColor: 'black'
        //   shadowEnabled: true
        //   // shadowVerticalOffset: 10
        //}

        Column {

            anchors.centerIn: parent

            height: parent.height * 0.7
            width: parent.width * 0.8

            spacing: 10.0

            // Session Row
            Row {
                Text {
                    text: textConstants.session
                    verticalAlignment: Text.AlignVCenter
                }
                SDDM.ComboBox {
                    id: session
                    model: sessionModel
                    index: sessionModel.lastIndex
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // Keyboard Layout
            Row {
                Text {
                    height: 80
                    text: textConstants.layout
                    verticalAlignment: Text.AlignVCenter
                }
                SDDM.LayoutBox {
                    id: keyboard_layout

                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            //Text {
            //   text: textConstants.login
            //   font.pixelSize: parent.height * 0.1
            //   font.weight: 800
            //   anchors.horizontalCenter: parent.horizontalCenter
            //}

            InputField {
                id: username
                width: parent.width * 0.8
                height: parent.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter

                placeholderText: textConstants.promptUse

                KeyNavigation.tab: login
                KeyNavigation.backtab: username
                Keys.onPressed: function (event) {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin();
                    }
                }
            }

            InputField {
                id: password

                width: parent.width * 0.8
                height: parent.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter

                placeholderText: textConstants.promptPassword

                isPassword: true

                KeyNavigation.tab: login
                KeyNavigation.backtab: username
                Keys.onPressed: function (event) {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin();
                    }
                }
            }

            Button {
                id: login
                text: textConstants.login
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    root.tryLogin();
                }
            }
        }
    }
}
