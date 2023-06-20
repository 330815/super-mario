import QtQuick 2.0
import Felgo 3.0

BrickBase{
    id:coinBrick

    AnimatedImage {
        id: coinbrickImage
        anchors.centerIn: parent
        source: "../../assets/img/map-ask.gif"

    }

    AnimatedImage{
        id:coin
        width: 32
        height: 32
        source: "../../assets/img/gold.gif"
        visible: false

        function appear()
        {
            coin.visible=true
            brickrise.start()
            rise.start()
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

        // 定义金币顶起的动画
        SequentialAnimation{
            id:rise
            NumberAnimation {

                target: coin
                property: "y"
                from: coin.y
                to: coin.y - 60 // 金币向上移动的距离
                duration: 1000 // 动画时长
                easing.type: Easing.OutQuint // 缓动效果
                running: false // 默认不运行动画
            }
            PropertyAction{
                target: coin
                property: "visible"
                value: false
            }
        }
    }

    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static

        fixture.onEndContact: {
            //实现弹金币
            if(mario.y>coinBrick.y+25 && mario.x>coinBrick.x-31){
                if(coin.y==0)
                    coin.appear()
                else
                    brickrise.start()
            }
        }
    }
}
