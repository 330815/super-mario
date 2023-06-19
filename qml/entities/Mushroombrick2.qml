import QtQuick 2.0
import Felgo 3.0
import QtQml 2.0


TiledEntityBase {
    entityType: "mushroombrick"
    id:mushroomBrick
    height: 25
    width: 32


    AnimatedImage {
        id: mushroombrick
        anchors.centerIn: parent
        source: "../../assets/img/map-ask.gif"

    }


    /*AnimatedImage{
        id:mushroom
        width: 32
        height: 32
        source: "../../assets/img/mushroom.gif"
        visible: false
        */
    /*Mushroom{
        id:mushRoom
        anchors.centerIn: parent
        visible: false
        function appearl()
        {
            mushRoom.visible=true

            mushRoom.anchors.centerIn = undefined
            //console.log("lalala")
           mushRoom.startmove()
        }


    }*/

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
      id: collider
      anchors.fill: parent
      bodyType: Body.Static




      fixture.onBeginContact: {
        var otherEntity = other.getBody().target
        if(otherEntity.entityType === "mario" )
            mario.contacts++

      }

      fixture.onEndContact: {
        var otherEntity = other.getBody().target
        if(otherEntity.entityType === "mario"&& mario.y>mushroomBrick.y+25 && mario.x>mushroomBrick.x-31 ) {

          console.debug("contact platform end")
           brickrise.start()
           mushroom2.appearl()
          // if the player leaves a platform, we decrease its number of active contacts
           mario.contacts--
        }

      }


    }

}
