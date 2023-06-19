import QtQuick 2.0
import Felgo 3.0

Row {
    id: groundRow
    spacing: 0      //每个方块空隙为0
    anchors.bottom: parent.bottom  //对齐底部
    Repeater {
        id: groundRepeater
        model:10//gameWindow.width/32
        delegate: Rectangle{
            id:groundColumn
            width: 32
            height: width*2
            Image{
                width: parent.width
                height: parent.height/2
                source: "../assets/img/img/map-land.png"
                fillMode: Image.Stretch
                anchors.top: parent.top
            }
            Image{
                width: parent.width
                height: parent.height/2
                source: "../assets/img/img/map-land.png"
                fillMode: Image.Stretch
                anchors.bottom:  parent.bottom
            }
        }
    }
}
