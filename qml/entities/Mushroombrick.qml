import QtQuick 2.0
import Felgo 3.0
import QtQml 2.0


BrickBase {
    id:mushroomBrick


    AnimatedImage {
        id: mushroombrick
        anchors.centerIn: parent
        source: "../../assets/img/map-ask.gif"

    }

    SequentialAnimation{
        id:brickrise
        NumberAnimation{
            target: mushroomBrick
            property: "y"
            from:mushroomBrick.y
            to:mushroomBrick.y - 10
            duration: 500
            easing.type: Easing.OutQuint
            running: false
        }
        NumberAnimation{
            target: mushroomBrick
            property: "y"
            from:mushroomBrick.y - 10
            to:mushroomBrick.y
            duration: 500
            easing.type: Easing.OutQuint
            running: false
        }
    }


    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static

        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario"&&mario.y>mushroomBrick.y+25 && mario.x>mushroomBrick.x-31) {
                brickrise.start()
                textmushroom.appearl()
            }

        }

    }

}
