import QtQuick

Rectangle {

   AppStyle {
      id:style
   }

    radius: 25
    border.color: style.primaryColor 
    border.pixelAligned: true
    border.width: 2.0

    property alias text: textInput.text
    property string placeholderText: ""
    property real horizontalPadding: 15

    TextInput {
        id: textInput

        width: parent.width - (2 * parent.horizontalPadding)
        height: parent.height

        anchors.centerIn: parent

	clip:true

        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignHCenter
    }

    Text {
      text:placeholderText
      visible: !parent.text && !textInput.activeFocus

      anchors.centerIn: parent

      color: "#cc444444"
    }



 }
