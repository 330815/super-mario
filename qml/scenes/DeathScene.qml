import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0

Scene {
    id:deathScene
    signal gametest
    opacity:0
    width: 480
    height: 480
    Rectangle {
        //Text: "Felgo"
        color: "red"
        anchors.centerIn: parent
        Button{
            onClicked:{
                gametest()
            }
        }


    }


}
