import QtQuick



Rectangle {

   width: parent.width * 0.8
   height: 30

   radius: 40

   anchors.horizontalCenter: parent.horizontalCenter

   border.color: root.primary
   border.pixelAligned: true
   border.width: 2.0

   property string placeholderText: ""
   property real inputPadding: 12

   TextInput {
      id: username

      width: parent.width - (2* )
      height: parent.height 

      anchors.centerIn: parent

      verticalAlignment: TextInput.AlignVCenter
      horizontalAlignment: TextInput.AlignHCenter

   }
}
