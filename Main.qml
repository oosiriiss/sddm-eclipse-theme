import QtQuick 2.0
import QtQuick.Controls 2.0
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

    readonly property real containerCornerRadius: config.containerCornerRadius ? config.containerCornerRadius : 5.0

    // Hex color like: "
    color: primaryContainer

    signal tryLogin

    onTryLogin: {
        sddm.login(username.text, password.text, session.index);
    }

    Rectangle {

        height: root.height / 2
        width: root.width / 4

        anchors.horizontalCenter: root.horizontalCenter
        radius: root.containerCornerRadius

        Column {

            Text {
                id: helloText
                text: "Hello world!"
                y: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 24
                font.bold: true
            }

            TextInput {
                id: username

                KeyNavigation.tab: password
                KeyNavigation.backtab: login

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin();
                    }
                }
            }

            PasswordBox {
                id: password

                KeyNavigation.tab: login
                KeyNavigation.backtab: username

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin();
                    }
                }
            }

            Button {
                id: login
                text: "Login"
                onClicked: {
                    root.tryLogin();
                }
            }
        }
    }
}
