import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {


    id:mushRoom
    entityType: "mushRoom"
    height: 25
    width: 32
    visible: false


    property bool isMoving: false  //默认状态下不移动
    property real moveSpeed: 1 // 设置水平移动的速度
    property int direction:0     //用于指定蘑菇的移动方向
    property bool isdead:false  //默认蘑菇存活
    property int distance : mushRoom.x-mario.x     //蘑菇和马里奥的距离
    property var kind


    AnimatedImage {
        id: mushroomImage
        anchors.centerIn: parent
        source: "../../assets/img/mushroom.gif"


        SequentialAnimation{
            id:rise
            NumberAnimation {


               target: mushRoom
               property: "y"
               from: mushRoom.y+20
               to: mushRoom.y-15 // 向上移动的距离
               duration: 350 // 动画时长
               easing.type: Easing.OutQuint // 缓动效果



            }
        }
        //定义mushroom被撞后下落的动画
        SequentialAnimation{
            id:drop
            NumberAnimation{
                target: mushRoom
                property: "y"
                from:mushRoom.y
                to:mushRoom.y-50
                duration: 200


            }
            NumberAnimation{
                target: mushRoom
                property: "y"
                from:mushRoom.y-50
                to:mushRoom.y+100
                duration: 800


            }
        }


    }

    //蘑菇和马里奥的距离小于五百，蘑菇就开始移动
    onDistanceChanged: {
        if(distance < 500 && kind ===  "wild")
            mushRoom.isMoving = true
    }


    //蘑菇移动
    function moveMushroom() {
        if(direction == 0)
            mushRoom.x -= mushRoom.moveSpeed
        if(direction == 1)
            mushRoom.x += mushRoom.moveSpeed
    }

    //蘑菇出现
    function appearl()
    {
        mushRoom.visible=true  //蘑菇被顶后才显现出来

        mushRoom.anchors.centerIn = undefined  //释放蘑菇

        rise.start()   //蘑菇开始升起
        standtimer.running=true

    }

    function mushroomDie(){
        isdead = true                     //蘑菇被踩死
        isMoving = false      //蘑菇不动了
        height= 16
        mushroomImage.source = "../../assets/img/img/mushroom-die.gif"       //蘑菇图片设置为死亡的蘑菇
        scores += 100     //踩死蘑菇得100分
        dietimer.running = true       //调用计时器，蘑菇消失
        collider.active = false
    }

    //定时器反复调用move函数使蘑菇持续移动
    Timer {
        id: moveTimer
        interval: 5 // 适当的时间间隔
        running: true
        repeat: true

        onTriggered: {
            if (mushRoom.isMoving) {

                moveMushroom()
            }
        }
    }










    //为了让蘑菇升起后有一个停顿，设置一个定时器，一秒后再让isMoving为true
    Timer{
        id: standtimer
        interval: 1000 // 时间间隔为 1 秒
        repeat: false // 只执行一次
        running: false // 启动定时器

        onTriggered: {
            mushRoom1.isMoving=true
        }

    }
    //呈现踩扁状态1s
    Timer{
        id: dietimer
        interval: 1000 // 时间间隔为 1 秒
        repeat: false // 只执行一次
        running: false // 启动定时器

        onTriggered: {
            mushRoom1.visible = false
        }

    }







    BoxCollider {
        id: collider

        anchors.fill: parent

        //anchors.horizontalCenter: parent.horizontalCenter
        // 动态 this collider must be dynamic because we are moving it by applying forces and impulses
        bodyType: Body.Dynamic // this is the default value but I wanted to mention it ;)
        fixedRotation: true // we are running, not rolling...
        bullet: true // for super accurate collision detection, use this sparingly, because it's quite performance greedy
        sleepingAllowed: false
        gravityScale: 5


        fixture.onBeginContact: {


            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario" && mario.y < mushRoom.y-30 && mario.isdead === false ){         //如果马里奥接触的是蘑菇盖
                mushroomDie()
            }


          if(otherEntity.entityType === "mario" && mario.y > mushRoom.y-30 && mushRoom.isdead == false){     //如果马里奥接触的是蘑菇身子
              mario.hitKill()     //首先马里奥展现死亡动画
          }


 }          fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario" && mario.y < mushRoom.y-30) {
                mario.contacts--

            }
        }

  }




}
