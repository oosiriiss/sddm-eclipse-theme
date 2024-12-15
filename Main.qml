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

    readonly property real containerCornerRadius: config.containerCornerRadius ? config.containerCornerRadius : 5.0


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
       onLogiSucceeded: {
	  console.log("Login succeeded");
       }

       onLoginFailed: {
	  console.log("Login failed");
       }

       onInformationMessage: {
	  console.log("infomration message succeeded");
       }
    }



    Rectangle {

        height: root.height / 2
        width: root.width / 4

        anchors.horizontalCenter: root.horizontalCenter
        radius: root.containerCornerRadius

        Column {

	   width: parent.width
	   height: parent.height

            Text {
                id: helloText
                text: "Hello world!"
                y: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 24
                font.bold: true
            }

	    Rectangle {

	       width: parent.width*0.8
	       height: 30
	       radius: containerCornerRadius


	       anchors.horizontalCenter: parent.horizontalCenter

	       border.color: primary
	       border.pixelAligned: True
	       border.width: 2.0

	       TextField {
		  id: username

		  width:parent.width
		  height:parent.height

		  leftPadding: paddingMedium
		  rightPadding: paddingMedium

		  color : primaryContainer

		  KeyNavigation.tab: password
		  KeyNavigation.backtab: login

		  verticalAlignment: TextInput.AlignVCenter
		  horizontalAlignment: TextInput.AlignHCenter


		  Keys.onPressed: {
		     if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
			root.tryLogin();
		     }
		  }
	       }
	    }

	    Rectangle {

	       width: parent.width*0.8
	       height: 30
	       radius: containerCornerRadius

	       anchors.horizontalCenter: parent.horizontalCenter

	       border.color: primary
	       border.pixelAligned: True
	       border.width: 2.0

	       TextField {
		  id: password

		  width:parent.width
		  height:parent.height

		  leftPadding: paddingMedium
		  rightPadding: paddingMedium

		  echoMode: TextField.Password

		  KeyNavigation.tab: login
		  KeyNavigation.backtab: username
		  Keys.onPressed: {
		     if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
			root.tryLogin();
		     }
		  }
	       }
	    }

	    // Session Row
	    Row {
	       Text {
		  height : 80
		  text : "Session:"
		  verticalAlignment : Text.AlignVCenter
		  horizontalAlignment : Text.AlignHCenter

	       }
	       ComboBox {
		  id: session

		  model: sessionModel
		  index: sessionModel.lastIndex

		  width : 200
		  height: parent.height
	       }

	    }


            Button {
                id: login
                text: "Login"
                onClicked: {
                    root.tryLogin();
                }
            }
        }
    }
}
