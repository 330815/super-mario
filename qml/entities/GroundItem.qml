import QtQuick 2.0
import Felgo 3.0

TiledEntityBase{

    entityType: "ground"
    Row {

        id: groundRow
        spacing: 0      //每个方块空隙为0
        anchors.bottom: parent.bottom  //对齐底部
        Repeater {
            id: groundRepeater
            model:size//gameWindow.width/32
            delegate:
                Image{
                width: 32
                height: 32
                source: "../../assets/img/img/map-land.png"
                fillMode: Image.Stretch
            }
        }
    }

    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static
        //和马里奥碰撞
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario") mario.contacts++
         }
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario") mario.contacts--
        }
    }
}

