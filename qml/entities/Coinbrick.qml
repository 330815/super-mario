import QtQuick 2.0
import Felgo 3.0

BrickBase{
    id:coinBrick
    property int coinsQuantity: 1     //用于传入金币数量,默认为1


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
        quantity: coinsQuantity
    }






    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static

       fixture.onEndContact: {
        var otherEntity = other.getBody().target
        if(otherEntity.entityType === "mario"&& mario.y>coinBrick.y+25 && mario.x>coinBrick.x-31) {
            brickrise.start()
            if(coins.quantity == 1){                  //顶到最后一个金币时砖块变为普通砖块
                coinbrickImage.source = "../../assets/img/img/map-nothing.png"
               }
            if(coins.quantity > 0){
                coins.coinsAppear()        //     每顶一次，金币数量减1，数量减为0时重新设置为三
                coins.quantity--
                if(coins.circulate > 1)
                  coins.circulate--
                if(coins.circulate == 0)
                  coins.circulate=3
                }

          // if the player leaves a platform, we decrease its number of active contacts
          //mario.contacts--
        }
      }

    }

    function restoreCoinbrick(){
        coinbrickImage.source = "../../assets/img/map-ask.gif"
        coinbrickImage.playing = true
        coins.quantity = coinsQuantity

    }
}
