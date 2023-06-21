import QtQuick 2.0
import Felgo 3.0
import QtQml 2.0
import "../levels"

BrickBase {
    id:mushroomBrick

    height: 25
    width: 32
    property Mushroom thismush    //用于传入场景中不同的蘑菇



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


      fixture.onEndContact: {
        var otherEntity = other.getBody().target
        if(otherEntity.entityType === "mario"&& mario.y>mushroomBrick.y+25 && mario.x>mushroomBrick.x-31 ) {
          mushroombrick.source = "../../assets/img/img/map-nothing.png"
          brickrise.start()
          if(  thismush.isdead == false){
              console.log("dddd")
              thismush.appearl()
          }
//thismush.isMoving==false &&

        }
    }
}


}
