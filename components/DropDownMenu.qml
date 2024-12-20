import QtQuick
import QtQuick.Controls

ComboBox {
    id: sessionComboBox

    //model: sessionModel
    //currentIndex:sessionModel.lastIndex
    textRole: "name"


    Behavior on currentIndex{
        NumberAnimation {
            duration: 200
        }
    }


    onCurrentIndexChanged: {
        console.log("Selected color value:", sessionComboBox.valueAt(sessionComboBox.currentIndex).name);
    }

}
