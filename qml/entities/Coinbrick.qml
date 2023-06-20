import QtQuick 2.0
import Felgo 3.0

BrickBase{
    id:coinBrick



    AnimatedImage {
        id: coinbrickImage
        anchors.centerIn: parent
        source: "../../assets/img/map-ask.gif"

    }


    //Coinbrick's animation
    SequentialAnimation{
        id:brickrise
        NumberAnimation{
            target: coinBrick
            property: "y"
            from:coinBrick.y
            to:coinBrick.y - 10
            duration: 500
            easing.type: Easing.OutQuint
            running: false
        }
        NumberAnimation{
            target: coinBrick
            property: "y"
            from:coinBrick.y - 10
            to:coinBrick.y
            duration: 500
            easing.type: Easing.OutQuint
            running: false
        }
    }



    Coins{
        id:coins
        quatity: 5

    }


    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static

        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario"&& mario.y>coinBrick.y+25 && mario.x>coinBrick.x-31) {

                brickrise.start()
                if(coins.quatity == 1){
                    coinbrickImage.source = "../../assets/img/img/map-nothing.png"
                }
                if(coins.quatity > 0){
                    console.log(coins.quatity)

                    coins.coinsAppear()
                    coins.quatity--
                    if(coins.circulate>1)
                        coins.circulate--
                    if(coins.circulate==0)
                        coins.circulate=3
                }
            }
        }

    }

    function restoreCoinbrick(){
        coinbrick.source = "../../assets/img/map-ask.gif"
        coinbrick.playing = true

    }
}
