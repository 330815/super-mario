import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    entityType: "platform"
    id:mushroomBrick
    height: 25
    width: 32

    AnimatedImage {
        id: mushroombrick
        anchors.centerIn: parent
        source: "../../assets/img/map-ask.gif"

    }

    BoxCollider {
      id: collider
      anchors.fill: parent
      bodyType: Body.Static

      fixture.onBeginContact: {
        var otherEntity = other.getBody().target
        if(otherEntity.entityType === "mario") {
          console.debug("contact platform begin")

          // increase the number of active contacts the player has
          mario.contacts++
        }
      }

      fixture.onEndContact: {
        var otherEntity = other.getBody().target
        if(otherEntity.entityType === "mario") {
          console.debug("contact platform end")

          // if the player leaves a platform, we decrease its number of active contacts
          mario.contacts--
        }
      }
    }

}
