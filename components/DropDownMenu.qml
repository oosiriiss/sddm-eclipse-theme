import QtQuick
import QtQuick.Controls

ComboBox {
    id: comboBox

    property real cornerRadius: 5



    AppStyle {
        id: style
    }

    contentItem: Rectangle {
        height: comboBox.height
        width: comboBox.width * 0.8

        clip: true
        color: "transparent"

        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: comboBox.displayText
            elide: Text.ElideRight

            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    background: Rectangle {
        radius: comboBox.cornerRadius
        height: comboBox.height

        color: style.secondaryColor

        width: comboBox.width
    }

    popup.y: comboBox.height
    popup.background: Rectangle {
        radius: comboBox.cornerRadius
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
            text: model[comboBox.textRole]
            elide: Text.ElideRight

            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Behavior on currentIndex {
        NumberAnimation {
            duration: 200
        }
    }
}
