import QtQuick
import SddmComponents 2.0

QtObject {
    // Todo:: Modifyable in config
    readonly property color primaryColor: config.primaryColor ? config.primaryColor : "#dd5555"
    readonly property color secondaryColor: config.secondaryColor ? config.secondaryColor : "#992222"

    readonly property color primaryContainerColor: config.primaryContainerColor ? config.primaryContainerColor : "#222222"
    readonly property color secondaryContainerColor: config.secondaryContainerColor ? config.secondaryContainerColor : "#444444"

    readonly property real paddingSmall: config.paddingSmall ? config.paddingSmall : 12.0
    readonly property real paddingMedium: config.paddingMedium ? config.paddingMedium : 24.0
    readonly property real paddingBig: config.paddingBig ? config.paddingBig : 36.0

    readonly property string passwordCharacter: config.passwordCharacter ? config.passwordCharacter : "●"
}
