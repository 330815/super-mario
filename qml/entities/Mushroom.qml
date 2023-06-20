import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {

    id:mushRoom1
    entityType: "mushRoom1"
    height: 25
    width: 32
    visible: false


    property bool isMoving: false  //默认状态下不移动
    property real moveSpeed: 1 // 设置水平移动的速度


    AnimatedImage {
        id: mushroom
        anchors.centerIn: parent
        source: "../../assets/img/mushroom.gif"

    }

    //为了让蘑菇升起后有一个停顿，设置一个定时器，一秒后再让isMoving为true
    Timer{
        id: timer
        interval: 1000 // 时间间隔为 1 秒
        repeat: false // 只执行一次
        running: false // 启动定时器

        onTriggered: {
            mushRoom1.isMoving=true
        }

    }

    // 定义mushroom顶起的动画
    SequentialAnimation{
        id:rise
        NumberAnimation {

            target: mushRoom1
            property: "y"
            from: mushRoom1.y+20
            to: mushRoom1.y-15 // 向上移动的距离
            duration: 350 // 动画时长
            easing.type: Easing.OutQuint // 缓动效果
            running: true // 默认不运行动画
        }


    }
    function moveMushroom() {
        mushRoom1.x -= mushRoom1.moveSpeed
    }




    function appearl()
    {
        mushRoom1.visible=true  //蘑菇被顶后才显现出来

        mushRoom1.anchors.centerIn = undefined  //释放蘑菇

        rise.start()   //蘑菇开始升起
        timer.running=true


    }

    //定时器反复调用move函数使蘑菇持续移动

    Timer {
        id: moveTimer
        interval: 5 // 适当的时间间隔
        running: true
        repeat: true


        onTriggered: {
            if (mushRoom1.isMoving) {

                moveMushroom()
            }


        }
    }



    BoxCollider {
        //id: collider

        anchors.fill: parent

        anchors.horizontalCenter: parent.horizontalCenter
        // 动态 this collider must be dynamic because we are moving it by applying forces and impulses
        bodyType: Body.Dynamic // this is the default value but I wanted to mention it ;)
        fixedRotation: true // we are running, not rolling...
        bullet: true // for super accurate collision detection, use this sparingly, because it's quite performance greedy
        sleepingAllowed: false

        // apply the horizontal value of the TwoAxisController as force to move the player left and right
        //force: Qt.point(controller.xAxis*10*3,0)
        gravityScale: 5




    }

}
