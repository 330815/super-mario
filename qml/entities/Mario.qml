import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id:player
    height: 32
    width: 32
    // 用于控制移动的属性

    AnimatedImage {
        id: mario
        anchors.centerIn: parent
        source: "../../assets/img/img/basePerson.png"



    }




}
