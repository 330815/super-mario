import QtQuick 2.0
import Felgo 3.0

 TiledEntityBase{

    id:coinBrick
    height: 25
    width: 32

    AnimatedImage {
        id: coinbrick
        anchors.centerIn: parent
        source: "../../assets/img/map-ask.gif"

    }
}
