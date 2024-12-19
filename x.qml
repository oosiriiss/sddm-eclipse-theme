import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    visible: true
    width: 400
    height: 200

    property int currentIndex: 0
    property var items: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

    Row {
        id: container
        anchors.centerIn: parent
        spacing: 10

        // Left Navigation Button
        Button {
            text: "<"
            enabled: currentIndex > 0
            onClicked: currentIndex--
        }

        // Centralized Item List
        Row {
            id: itemRow
            width: 300
            height: 120
            spacing: 10
            clip: true // Ensures items outside the visible area are not shown

            Repeater {
                model: items
                delegate: Item {
		     
                    width: 100
                    height: 100
                    opacity: index === currentIndex ? 1 : 0.5 // Adjust opacity dynamically
                    x: (index - currentIndex) * (width + itemRow.spacing) + itemRow.width / 2 - width / 2

                    Rectangle {
                        id: itemRect
                        anchors.centerIn: parent
                        width: index === currentIndex ? 120 : 100
                        height: index === currentIndex ? 120 : 100
                        color: index === currentIndex ? "blue" : "lightgray"
                        border.color: "black"

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            color: index === currentIndex ? "white" : "black"
                        }
                    }

                    // Smooth animation for position, scaling, and opacity
                    Behavior on x {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.InOutQuad
                        }
                    }
                    Behavior on opacity {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.InOutQuad
                        }
                    }

                    // Smooth transition for scaling
                    states: State {
                        name: "selected"
                        when: index === currentIndex
                        PropertyChanges {
                            target: itemRect
                            width: 120
                            height: 120
                        }
                    }
                    transitions: Transition {
                        NumberAnimation {
                            properties: "width, height"
                            duration: 300
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }

        // Right Navigation Button
        Button {
            text: ">"
            enabled: currentIndex < items.length - 1
            onClicked: currentIndex++
        }
    }
}

