import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import SddmComponents
import "./components"

Rectangle {
   id: root

   TextConstants {
      id: textConstants
   }

   Connections {
      target: sddm

      onLoginSucceeded: {
	 console.log("Login succeeded");
      }

      onLoginFailed: {
	 console.log("Login failed");
      }

      onInformationMessage: {
	 console.log("infomration message succeeded");
      }
   }

   AppStyle {
      id:style
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

      height: parent.height
      width: login_box.width + root.width * 0.08

      anchors.verticalCenter: root.verticalCenter
      anchors.horizontalCenter: login_box.horizontalCenter
   }
   GaussianBlur {
      anchors.fill: background_blur
      source: background_blur
      radius: 10
   }
   Rectangle {
      anchors.fill: background_blur

      gradient: Gradient {
	 GradientStop {
	    position: 0.0
	    color: "#11000000"
	 }
	 GradientStop {
	    position: 0.25
	    color: "#44000000"
	 }
	 GradientStop {
	    position: 0.25
	    color: "#44000000"
	 }
	 GradientStop {
	    position: 0.0
	    color: "#11000000"
	 }
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

   Rectangle {
      id: login_box

      height: root.height / 2
      width: root.width / 4

      anchors.right: root.right
      anchors.rightMargin: root.width * 0.075
      anchors.verticalCenter: root.verticalCenter

      radius: style.containerCornerRadius

      // Shadow around
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

	 height: parent.height * 0.7
	 width: parent.width * 0.8

	 spacing: 10.0

	 Text {
	    text: "Login"
	    font.pixelSize: parent.height * 0.1
	    font.weight: 800
	    anchors.horizontalCenter: parent.horizontalCenter
	 }

	 InputField {
	    width: parent.width * 0.8
	    height:30
	    anchors.horizontalCenter: parent.horizontalCenter

	    placeholderText: "Username"
	 }



	 Rectangle {

	    width: parent.width * 0.8
	    height: 30
	    radius: style.containerCornerRadius

	    anchors.horizontalCenter: parent.horizontalCenter

	    border.color: style.primaryColor
	    border.pixelAligned: true
	    border.width: 2.0

	    TextField {
	       id: username

	       placeholderText: "Password"

	       width: parent.width
	       height: parent.height

	       leftPadding: style.paddingMedium
	       rightPadding: style.paddingMedium

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

	 Rectangle {

	    width: parent.width * 0.8
	    height: 30
	    radius: style.containerCornerRadius

	    anchors.horizontalCenter: parent.horizontalCenter

	    border.color: style.primaryColor
	    border.pixelAligned: true
	    border.width: 2.0

	    TextField {
	       id: password

	       placeholderText: "Password"

	       width: parent.width
	       height: parent.height

	       leftPadding: style.paddingMedium
	       rightPadding: style.paddingMedium

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
