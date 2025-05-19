import QtQuick
import SddmComponents 2.0

QtObject {

    readonly property string backgroundImage: Qt.resolvedUrl(config.backgroundImage ? config.backgroundImage : "../images/eclipse.png")

    readonly property color primaryColor: config.primaryColor ? config.primaryColor : "#ee5555"
    readonly property color secondaryColor: config.secondaryColor ? config.secondaryColor : "#bb4444"
    readonly property color tertiaryColor: config.tertiaryColor ? config.tertiaryColor : "#dd7777"

    readonly property color primaryContainerColor: config.primaryContainerColor ? config.primaryContainerColor : "#222222"
    readonly property color secondaryContainerColor: config.secondaryContainerColor ? config.secondaryContainerColor : "#444444"

    readonly property string passwordCharacter: config.passwordCharacter ? config.passwordCharacter : "●"
}
