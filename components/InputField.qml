import QtQuick



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

	       //autoScroll:true
	       clip: true
	       // maximumLineCount: 1
	       
	       // wrapMode: TextInput.Wrap
	       // maximumLength: 10

	       width: parent.width - (2* root.paddingMedium)
	       height: parent.height 

	       anchors.centerIn: parent

	       verticalAlignment: TextInput.AlignVCenter
	       horizontalAlignment: TextInput.AlignHCenter

	       //leftPadding: root.paddingMedium*3
	       //rightPadding: root.paddingMedium
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
