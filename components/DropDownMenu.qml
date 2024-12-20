import QtQuick
import QtQuick.Controls

ComboBox {
    id: sessionComboBox

    //model: sessionModel
    //currentIndex:sessionModel.lastIndex
    textRole: "name"

    contentItem: Rectangle { color:"lightgray" }

    popup: Popup {
        background: Rectangle {
            color: "black"
            width: sessionComboBox.width
            height: sessionComboBox.height
        }
    }

    delegate: ItemDelegate {

        width: sessionComboBox.width

        background: Rectangle {
            width: sessionComboBox.width
            radius: 5
            color: "red"
        }

        Text {
            text: name
        }
    }

    Behavior on currentIndex {
        NumberAnimation {
            duration: 200
        }
    }

    onCurrentIndexChanged: {
        console.log("Selected color value:", sessionComboBox.valueAt(sessionComboBox.currentIndex).name);
    }
}
