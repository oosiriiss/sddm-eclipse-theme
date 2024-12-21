import QtQuick
import QtQuick.Controls

ComboBox {
    id: comboBox

    property real cornerRadius: 5

    AppStyle {
        id: style
    }

    onFocusChanged: {
       if(comboBox.focus) {

       }
    }

    //contentItem: Rectangle {
    //    text: comboBox.model.valueAt(comboBox.currentIndex).
    //}

    popup.y: comboBox.height
    popup.background: Rectangle {
        radius: 5
    }

    delegate: ItemDelegate {
        id: item

        width: comboBox.width
        height: comboBox.height

        background: Rectangle {
            width: parent.width
            height: parent.height

            radius: comboBox.cornerRadius

            color: item.hovered ? style.primaryColor : "white"
        }

        Text {
            anchors.centerIn: parent
            text: name
        }
    }

    Behavior on currentIndex {
        NumberAnimation {
            duration: 200
        }
    }

    onCurrentIndexChanged: {
        console.log("Selected color value:", comboBox.valueAt(comboBox.currentIndex));
    }
}
