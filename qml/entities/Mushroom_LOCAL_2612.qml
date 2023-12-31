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
        id: mushroom
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

    //为了让蘑菇升起后有一个停顿，设置一个定时器，一秒后再让isMoving为true
    Timer{
        id: timer
        interval: 1000 // 时间间隔为 1 秒
        repeat: false // 只执行一次
        running: false // 启动定时器

        onTriggered: {
            mushRoom.isMoving=true
        }

    }




    Timer{
                    id: dietimer
                    interval: 1000 // 时间间隔为 1 秒
                    repeat: false // 只执行一次
                    running: false // 启动定时器

                    onTriggered: {
                      mushRoom.visible = false
                    }


                }







    function moveMushroom() {
        if(direction == 0)
            mushRoom.x -= mushRoom.moveSpeed
        if(direction == 1)
            mushRoom.x += mushRoom.moveSpeed

        }





    function appearl()
    {
        mushRoom.visible=true  //蘑菇被顶后才显现出来

        mushRoom.anchors.centerIn = undefined  //释放蘑菇

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
            if (mushRoom.isMoving) {

                moveMushroom()
            }


        }
    }

    Timer {
            id: resurgenceTimer
            interval: 3000 // 适当的时间间隔
            running: false
            repeat: false


            onTriggered: {

                console.log("Mario was killed by a mushroom")
                collider.active=true
                if(marioLives > 0){
                   marioLives--
                   mario.collider.active = true
                   mario.closeKeep()
                   mario.changeState("../../assets/img/img/basePerson.png")
                   mario.y=0
                   mario.x=128
                   mario.visible=true


                    mario.helpMushroom()



              }
                else{
                    console.log("Mario is really dead")

                }

            }
        }





    BoxCollider {
        id: collider

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


        fixture.onBeginContact: {
          var otherEntity = other.getBody().target
          if(otherEntity.entityType === "mario" && mario.y < mushRoom.y-30 ){         //如果马里奥接触的是蘑菇盖
              console.log("Mario stepped on the mushrooms")
              mushRoom.isdead = true                     //蘑菇被踩死
              mushroom.source = "../../assets/img/img/mushroom-die.gif"       //蘑菇图片设置为死亡的蘑菇
              mushRoom.isMoving = false      //蘑菇不动了
              scores += 100     //踩死蘑菇得100分
              dietimer.running = true       //调用计时器，蘑菇消失
              mario.contacts++


          }

          if(otherEntity.entityType === "mario" && mario.y > mushRoom.y-30 && mushRoom.isdead == false){     //如果马里奥接触的是蘑菇身子
              //console.log("Mario killed the mushroom")
              //mushroom.source = "../../assets/img/mushroomR.gif"
              //mushRoom1.isMoving = false
              //drop.start()
              //collider.active=false
              mario.hitKill()     //首先马里奥展现死亡动画

              resurgenceTimer.running = true      //处理马里奥死亡后的场景重建等
              collider.active=false   //马里奥不能再撞到蘑菇


          }


 }          fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "mario" && mario.y < mushRoom.y-30) mario.contacts--
        }

  }
}
