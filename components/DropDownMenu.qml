import QtQuick
import QtQuick.Controls

ComboBox {
    id: comboBox

    property real cornerRadius: 5
    property int hoveredIndex: -1

    AppStyle {
        id: style
    }

    Keys.onPressed: function (event) {
        if (comboBox.focus && comboBox.activated) {
            if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter)
                comboBox.currentIndex = comboBox.hoveredIndex;
            else if ((event.key == Qt.Key_S || event.key == Qt.Key_Down) && comboBox.hoveredIndex < comboBox.model.count - 1)
                comboBox.hoveredIndex += 1;
            else if ((event.key == Qt.Key_W || event.key == Qt.Key_Up) && comboBox.hoveredIndex > 0)
                comboBox.hoveredIndex -= 1;
        }
    }

    contentItem: Rectangle {

        clip: true
        color: "transparent"

        height: comboBox.height
        width: comboBox.width * 0.8

        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: comboBox.displayText
            elide: Text.ElideRight
            font.pixelSize: parent.height * 0.4

            width: parent.width

            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            anchors.left: parent.left
        }
    }

    background: Rectangle {
        radius: comboBox.cornerRadius
        height: comboBox.height

        color: style.tertiaryColor

        width: comboBox.width

        border.width: (comboBox.hovered || comboBox.focus) ? 3 : 0
        border.color: (comboBox.hovered || comboBox.focus) ? style.primaryColor : "black"
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

            color: (index == comboBox.hoveredIndex) ? style.primaryColor : (index == comboBox.currentIndex ? style.secondaryColor : "transparent")
        }

        onHoveredChanged: {
            if (item.hovered) {
                comboBox.hoveredIndex = index;
            }
        }

        Text {
            text: model[comboBox.textRole]
            elide: Text.ElideRight
            font.pixelSize: parent.height * 0.4

            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            anchors.left: parent.left
        }
    }
}
