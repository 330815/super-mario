import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {

    id:flag
    //property int iftouch: mario.x


    //旗帜
    Image {
        id: banner
        source: "../../assets/img/img/flag.png"
        y:25
        x:-18

        NumberAnimation{
            id:bannerdrop
            target: banner
            property: "y"
            from: 25
            to:230
            duration: 3000
        }

    }

    //旗杆
    Image {
        id: flagpole
        anchors.bottom: pedestal.top
        source: "../../assets/img/img/flagpole.png"
        width: 35
        height: 258
        x:-2


    }

    //底座
    Image {
        id: pedestal
        anchors.top: flagpole.bottom
        source: "../../assets/img/img/map-rock.png"

    }

BoxCollider {
     // anchors.fill: parent
      height: 300
      width: 5
       bodyType: Body.Static


      fixture.onBeginContact: {
       var otherEntity = other.getBody().target
       if(otherEntity.entityType === "mario") {
           bannerdrop.running = true
           //mario.state = "win"
           mario.marioClimb()


           }
       }

    }



}

