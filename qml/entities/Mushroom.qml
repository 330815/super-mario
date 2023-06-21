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
    property int direction:0     //用于指定蘑菇的移动方向
    property bool isdead:false  //默认蘑菇存活


    AnimatedImage {
        id: mushroom
        anchors.centerIn: parent
        source: "../../assets/img/mushroom.gif"


        SequentialAnimation{
            id:rise
            NumberAnimation {

               target: mushRoom1
               property: "y"
               from: mushRoom1.y+20
               to: mushRoom1.y-15 // 向上移动的距离
               duration: 350 // 动画时长
               easing.type: Easing.OutQuint // 缓动效果


         }
    }
       //定义mushroom被撞后下落的动画
        SequentialAnimation{
            id:drop
            NumberAnimation{
                target: mushRoom1
                property: "y"
                from:mushRoom1.y
                to:mushRoom1.y-50
                duration: 200


            }
            NumberAnimation{
                target: mushRoom1
                property: "y"
                from:mushRoom1.y-50
                to:mushRoom1.y+100
                duration: 800


            }
        }


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




    Timer{
                    id: dietimer
                    interval: 1000 // 时间间隔为 1 秒
                    repeat: false // 只执行一次
                    running: false // 启动定时器

                    onTriggered: {
                      mushRoom1.visible = false
                    }


                }


  //蘑菇的重生
    function resetMushroom(){
        mushroom.playing = true
        mushroom.source = "../../assets/img/mushroom.gif"
        mushRoom1.visible =false
        collider.active = true
        mushRoom1.isMoving = false
        mushRoom1.isdead = false

        dietimer.running = false
    }




    function moveMushroom() {
        if(direction == 0)
            mushRoom1.x -= mushRoom1.moveSpeed
        if(direction == 1)
            mushRoom1.x += mushRoom1.moveSpeed
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
          if(otherEntity.entityType === "mario" && mario.y < mushRoom1.y-30 ){         //如果马里奥接触的是蘑菇盖
              console.log("Mario stepped on the mushrooms")
              mushRoom1.isdead = true                     //蘑菇被踩死
              mushroom.source = "../../assets/img/img/mushroom-die.gif"       //蘑菇图片设置为死亡的蘑菇
              mushRoom1.isMoving = false      //蘑菇不动了
              scores += 100     //踩死蘑菇得100分
              dietimer.running = true       //调用计时器，蘑菇消失

          }

          if(otherEntity.entityType === "mario" && mario.y > mushRoom1.y-30 && mushRoom1.isdead == false){     //如果马里奥接触的是蘑菇身子
              //console.log("Mario killed the mushroom")
              //mushroom.source = "../../assets/img/mushroomR.gif"
              //mushRoom1.isMoving = false
              //drop.start()
              //collider.active=false
              mario.hitKill()     //首先马里奥展现死亡动画

              resurgenceTimer.running = true      //处理马里奥死亡后的场景重建等
              collider.active=false   //马里奥不能再撞到蘑菇


          }



   }
  }
}
