import QtQuick 2.0
import Felgo 3.0
//所有平台方块的父类
TiledEntityBase{

    entityType: "platform"
    id:brickBase
    height: 25
    width: 32

    BoxCollider {
        id: collider
        anchors.fill: parent
        bodyType: Body.Static

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario") {
                console.debug("contact platform start")
                mario.contacts++
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
