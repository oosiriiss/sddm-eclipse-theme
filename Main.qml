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
            background: Rectangle {
                color: "transparent"
            }
            icon.name: "power-off"
            icon.source: "images/poweroff.svg"
            icon.width: width
            icon.height: height
            icon.color: style.secondaryColor
            anchors.left: parent.left
            width: parent.width * 0.33
            height: parent.height

            onClicked: {
                sddm.powerOff();
            }
        }
        Button {
            id: hibernate
            background: Rectangle {
                color: "transparent"
            }
            icon.name: "hibernate"
            icon.source: "images/hibernate.svg"
            icon.width: width
            icon.height: height
            icon.color: style.secondaryColor

            anchors.horizontalCenter: parent.horizontalCenter

            width: parent.width * 0.33
            height: parent.height

            onClicked: {
                sddm.hibernate();
            }
        }
        Button {
            id: reboot
            background: Rectangle {
                color: "transparent"
            }
            icon.name: "reboot"
            icon.source: "images/reboot.svg"
            icon.width: width
            icon.height: height
            icon.color: style.secondaryColor

            anchors.right: parent.right

            width: parent.width * 0.33
            height: parent.height

            onClicked: {
                sddm.reboot();
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
        }


	DropDownMenu {
	   id: sessionComboBox

	   model: sessionModel
	   currentIndex:sessionModel.lastIndex
	   textRole: "name" 

	   width: 200
	   anchors.verticalCenter:parent.verticalCenter
	   anchors.left:session_label.right

	    
	   onCurrentIndexChanged: {
	      console.log("Selected color value:", sessionComboBox.valueAt(sessionComboBox.currentIndex).name)
	   }

	}

        //ComboBox {
        //    id: session
        //    model: sessionModel
	//    currentIndex: sessionModel.lastIndex
        //    anchors.verticalCenter: parent.verticalCenter
        //    anchors.left: session_label.right

	//    //arrowColor: "transparent"

        //    //color: style.secondaryColor
        //    //focusColor: "white"
        //    //hoverColor: style.primaryColor
        //    //menuColor: style.secondaryColor
        //    //textColor: "white"
        //}

        //Keyboard Layout
        Text {
            id: layout_label
            text: textConstants.layout
            verticalAlignment: Text.AlignVCenter

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: keyboard_layout.left
        }
        SDDM.LayoutBox {
            id: keyboard_layout
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
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


	    Row {
	       id: userList
	       width: parent.width
	       height: parent.height*0.3

	       clip:true

	       // Todo:: set selectedIndex to the index of LastUser
	       property int selectedIndex: 0
	       spacing:15

	       Repeater {
		  model: userModel

		  delegate: Item {

		     height: Math.min((userList.width-2*userList.spacing)/3,userList.height)
		     width: Math.min((userList.width-2*userList.spacing)/3,userList.height)

		     opacity: (index === userList.selectedIndex) ? 1 : 0.5

		     scale: (index === userList.selectedIndex) ? 1 : 0.8

		     x: (index- userList.selectedIndex) * (width + userList.spacing) + userList.width/2 - width/2

		     Rectangle {
			anchors.fill:parent

			radius:12
			color: (index === userList.selectedIndex) ? style.primaryColor : style.secondaryColor

			Behavior on color { ColorAnimation { duration: 100; easing.type:Easing.InOutQuad } }

		     }


		     Behavior on x { NumberAnimation { duration:200; easing.type: Easing.InOutQuad } }
		     Behavior on y { NumberAnimation { duration:200; easing.type: Easing.InOutQuad } }
		     Behavior on scale { NumberAnimation { duration:200; easing.type: Easing.InOutQuad} }

		     Component.onCompleted: {
			if(index === userList.selectedIndex)
			   username.text = name
		     }



		     Column {
			anchors.centerIn:parent

			width: parent.width
			height:parent.height

			
			padding: parent.width*0.1

			Image {
			   width: parent.width*0.6
			   height: parent.height*0.6
			   source: icon
			   fillMode:Image.PreserveAspectCrop
			   anchors.horizontalCenter: parent.horizontalCenter


			   
			}



			Text { 
			   id: nameText
			   text: name 

			   width: parent.width*0.9
			   anchors.horizontalCenter: parent.horizontalCenter

			   horizontalAlignment: Text.AlignHCenter

			   font.pixelSize:parent.height*0.17
			   font.weight:500
			   wrapMode: Text.Wrap
			}
		     }

		     MouseArea {
			anchors.fill:parent
			onClicked: {
			   userList.selectedIndex = index
			   username.text = name
			   userList.forceActiveFocus()
			}

		     }

		  }

	       }






	    }



            //ListView {
            //    id: userList

            //    width: parent.width
            //    height: parent.height*0.3

	    //    orientation: Qt.Horizontal
	    //    focus:true

	    //    clip:true

            //    highlight: Rectangle {
            //        color: style.primaryColor
            //        radius: 10
            //    }

	    //    model: userModel
	    //    currentIndex: userModel.lastIndex

	    //    Component.onCompleted: {
	    //       username.text = userList.currentItem.text
	    //    }

	    //    delegate: Item {
	    //       id: listItem

	    //       width: Math.min(userList.width*0.35,userList.height)
	    //       height: Math.min(userList.width*0.35,userList.height)

	    //       property alias text: usrnm.text

	    //       Column {
	    //          anchors.centerIn:parent
	    //          Image {
	    //    	 width: listItem.width*0.6
	    //    	 height: listItem.height*0.6
	    //    	 source: icon
	    //    	 fillMode:Image.PreserveAspectCrop
	    //    	 anchors.horizontalCenter: parent.horizontalCenter
	    //          }
	    //          Text { 
	    //    	 id:usrnm 
	    //    	 text: name 

	    //    	 width: listItem.width*0.9
	    //    	 anchors.horizontalCenter: parent.horizontalCenter

	    //    	 horizontalAlignment: Text.AlignHCenter

	    //    	 font.pixelSize:listItem.height*0.17
	    //    	 font.weight:500
	    //    	 wrapMode: Text.Wrap
	    //          }
	    //         
	    //       }

	    //       MouseArea {
	    //          anchors.fill:parent
	    //          onClicked: {
	    //    	 userList.currentIndex = index
	    //    	 userList.forceActiveFocus()
	    //    	 // Setting 
	    //    	 username.text = name
	    //          }
	    //       }
            //    }
            //}

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
                    color: login.hovered ? style.primaryColor :  style.secondaryColor
                }
            }
        }
    }
}
