import QtQuick 2.0
import Felgo 3.0
//所有平台方块的父类
TiledEntityBase{

    entityType: "platform"
    id:brickBase


    BoxCollider {
        id: collider
        implicitWidth: parent.width-2
        height: parent.height
        bodyType: Body.Static

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario") {
                console.debug("contact platform start")
                mario.contacts++
                console.debug(width)
                console.debug(height)
            }
        }

        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario") {
                console.debug("contact platform end")
                mario.contacts--

            }
        }
    }
}
