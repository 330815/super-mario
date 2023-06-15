import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {

    id:ordinaryBrick
    height: 25
    width: 32

    AnimatedImage {
        id: ordinarybrick
        anchors.centerIn: parent
        source: "../../assets/img/img/map-stone.png"

    }

}
