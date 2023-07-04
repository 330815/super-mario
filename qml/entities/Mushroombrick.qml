import QtQuick 2.0
import Felgo 3.0
import QtQml 2.0
import "../levels"

BrickBase {
    id:mushroomBrick


    property Mushroom thismush    //用于传入场景中不同的蘑菇

    height: 32
    width: 32


    AnimatedImage {
        id: mushroombrick
        anchors.centerIn: parent
        source: "../../assets/img/map-ask.gif"

    }

    //砖块被顶后上下移动的动画
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


<<<<<<< HEAD

=======
>>>>>>> superMario/main
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario"&& mario.y>mushroomBrick.y+25 && mario.x>mushroomBrick.x-31 ) {
                mushroombrick.source = "../../assets/img/img/map-nothing.png"
                brickrise.start()
                if(thismush.isMoving==false && thismush.isdead == false)
                    //蘑菇出现
                    thismush.appearl()
<<<<<<< HEAD

=======
>>>>>>> superMario/main

            }
        }
    }
<<<<<<< HEAD




=======
>>>>>>> superMario/main
    function mushroombrickReset(){
        mushroombrick.playing = true
        mushroombrick.source = "../../assets/img/map-ask.gif"
    }


}
