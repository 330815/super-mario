import QtQuick 2.0
import Felgo 3.0

BrickBase {

    id:ordinaryBrick

//    AnimatedImage {
//        id: ordinarybrick
//        anchors.centerIn: parent
//        source: "../../assets/img/img/map-stone.png"

//    }
    Row {

        id: groundRow
        spacing: 0      //每个方块空隙为0
        Repeater {
            id: brickRepeater
            model:size//gameWindow.width/32
            delegate:
                Image{
                width: 32
                height: 32
                source: "../../assets/img/img/map-stone.png"
                fillMode: Image.Stretch
            }
        }
    }

}
