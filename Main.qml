import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Effects
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


   TextConstants{
      id:textConstants
   }

   // Hex color like: "
   color: primaryContainer

   signal tryLogin

   onTryLogin: {
      sddm.login(username.text, password.text, session.index);
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
   // Date and time
   Rectangle { 
      width: time.paintedWidth
      height: root.height * 0.23


      anchors.left: parent.left
      anchors.top: parent.top
      anchors.leftMargin: parent.width*0.03
      anchors.topMargin: parent.height*0.05


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
	 height:parent.height * 0.25
	 text: Qt.formatDateTime(new Date(), "ddd, dd MMM yyyy")
	 font.pixelSize: parent.height * 0.22
	 anchors.right: parent.right
      }
      

      Text {
	 id: time
	 height: parent.height * 0.75
	 text: Qt.formatDateTime(new Date(), "HH:mmap")
	 font.pixelSize: parent.height * 0.6
	 font.weight: 900	
	 anchors.top: date.bottom
	 anchors.left: parent.left
      }

      MultiEffect {
	 source:date
	 anchors.fill:date 
	 autoPaddingEnabled: true
	 shadowBlur: 0.4
	 shadowColor: root.primary
	 shadowEnabled: true
	 // shadowVerticalOffset: 10
      }
      MultiEffect {
	 source:time 
	 anchors.fill:time 
	 autoPaddingEnabled: true
	 shadowBlur: 0.4
	 shadowColor: root.primary
	 shadowEnabled: true
	 // shadowVerticalOffset: 10
      }
   }

   Rectangle {
      id: login_box

      height: root.height / 2
      width: root.width / 4

      anchors.right: root.right
      anchors.rightMargin: root.width * 0.05
      anchors.verticalCenter: root.verticalCenter

      radius: root.containerCornerRadius


      MultiEffect {
	 source: login_box
	 anchors.fill: login_box
	 autoPaddingEnabled: true
	 shadowBlur: 0.4
	 shadowColor: 'black'
	 shadowEnabled: true
	 // shadowVerticalOffset: 10
      }

      Column {

	 anchors.centerIn: parent

	 height: parent.height*0.7
	 width: parent.width*0.8

	 spacing: 10.0



	 Text {
	    text: "Login"
	    font.pixelSize: parent.height*0.1
	    font.weight: 800
	    anchors.horizontalCenter: parent.horizontalCenter
	 }

	 Rectangle {

	    width: parent.width * 0.8
	    height: 30

	    radius: 40

	    anchors.horizontalCenter: parent.horizontalCenter

	    border.color: root.primary
	    border.pixelAligned: true
	    border.width: 2.0

	    TextInput {
	       id: username

	       width: parent.width
	       height: parent.height

	       verticalAlignment: TextInput.AlignVCenter
	       horizontalAlignment: TextInput.AlignHCenter

	       leftPadding: root.paddingMedium
	       rightPadding: root.paddingMedium



	    }

	    //TextField {
	    //   id: username

	    //   placeholderText: "Username"

	    //   width: parent.width
	    //   height: parent.height

	    //   leftPadding: root.paddingMedium
	    //   rightPadding: root.paddingMedium

	    //   color: root.primaryContainer

	    //   KeyNavigation.tab: password
	    //   KeyNavigation.backtab: login

	    //   verticalAlignment: TextInput.AlignVCenter
	    //   horizontalAlignment: TextInput.AlignHCenter

	    //   Keys.onPressed: function (event) {
	    //      if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
	    //         root.tryLogin();
	    //      }
	    //   }
	    //}
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

	       verticalAlignment: TextInput.AlignVCenter
	       horizontalAlignment: TextInput.AlignHCenter

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
	       text: textConstants.session
	       verticalAlignment: Text.AlignVCenter
	    }
	    ComboBox {
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
	    LayoutBox {
	       id: keyboard_layout

	       anchors.verticalCenter: parent.verticalCenter
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
