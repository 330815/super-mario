import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {

    id:mushroomBrick
    height: 25
    width: 32

    AnimatedImage {
        id: mushroombrick
        anchors.centerIn: parent
        source: "../../assets/img/map-ask.gif"

    }

}
