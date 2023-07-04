import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id:mario
    height: 32
    width: 32
    entityType: "mario"
 signal timeup()
    //添加别名
    property alias collider: collider
    //speed
    property alias horizontalVelocity: collider.linearVelocity.x
    //derection
    property bool isRight:true  //默认马里奥朝右
    //left-right press
    property bool isPress: false //默认没按下
    // the contacts property is used to determine if the player is in touch with any solid objects (like ground or platform), because in this case the player is walking, which enables the ability to jump. contacts > 0 --> walking state
    property int contacts: 0
    //
    property bool runover: false
    // property binding to determine the state of the player like described abovestate = "jumping"
    state: contacts > 0 ? "walking" : "jumping"

    //修改马里奥的运动状态资源
    function changeState(source){
        marioImage.source =source
        marioImage.playing = true

    }
    function changeDirection(actionName){
        switch(actionName){
        case "left":
            isRight = false;
            break;
        case "right":
            isRight = true;
            break;
        default:
            break;
        }
    }

    function timeupslot(){

    }

    Timer{
        id:keep
        interval: 10 // 适当的时间间隔
        running: false
        repeat: true
        onTriggered: {

            marioImage.source = "../../assets/img/img/diePerson.png"

        }
    }

    //使马里奥保持死亡姿势
    function closeKeep(){
        keep.running = false
    }



    function hitKill(){

        keep.running=true
        mario.z = 150
        //collider.active = false
        die.running = true


    }

    function helpMushroom(){
        gameScene.reloader()
    }

    //实现马里奥跳跃
    function jump() {
        if(mario.state == "walking") {
        // for the jump, we simply set the upwards velocity of the collider
        collider.linearVelocity.y = -550
        audioManager.playSound("marioJump")
        }


    }

    onStateChanged: {
        //处理状态变化时，图片的变化
        if(state == "jumping"){ //跳跃时，，左右跳跃的状态
            marioImage.source = isRight ? "../../assets/img/img/basePersonUp.png":"../../assets/img/img/basePersonUpL.png"
        }else if(state == "walking"){   //更改到行走状态时，判断左右按键是否还在按下，进行选择运动还是站立
            if(isPress){
                marioImage.source = isRight ? "../../assets/img/img/basePerson.gif":"../../assets/img/img/basePersonL.gif"
            }else{
                marioImage.source = isRight ? "../../assets/img/img/basePerson.png":"../../assets/img/img/basePersonL.png"
            }
            marioImage.playing=true
        }
    }

    onYChanged: {
        if(y>800){

            if(marioLives > 0){
                console.log("Mario fell dead")
                mario.y=0
                mario.x=128
                mario.z=0
                marioLives--
                gameWindow.state = "death"
                deathScene.state = "play"
                gameScene.reloader()



            }
            else{

                console.log("Mario is really dead this time")

            }


        }

    }

    /*Timer {
            id: resurgenceTimer
            interval: 3000 // 适当的时间间隔
            running: false
            repeat: false


            onTriggered: {

                console.log("Mario was killed by a mushroom")
                collider.active=true
                if(marioLives > 0){
                   marioLives--

                    console.log(".....")
                   mario.collider.active = true
                   mario.closeKeep()
                   mario.changeState("../../assets/img/img/basePerson.png")
                   mario.y=0
                   mario.x=128
                   mario.visible=true

                   gameScene.reloader()

                    gameWindow.state = "death"
                    deathScene.state = "play"

              }
                else{
                    console.log("Mario is really dead")

                }

            }
        }*/



    SequentialAnimation{
        running: false
        id:die
        NumberAnimation{
            target: mario
            property: "y"
            from:mario.y
            to:mario.y-100
            duration: 700
        }
        NumberAnimation{
            target: mario
            property: "y"
            from:mario.y-100
            to:446
            duration: 1000

        }
        PropertyAction{
            target: mario
            property: "visible"
            value: false

        }
    }

    //马里奥外观
    AnimatedImage {
        id: marioImage
        anchors.centerIn: parent
        source: "../../assets/img/img/basePerson.png"
        playing: true

    }
    //碰撞组件
    BoxCollider {
        id: collider
        height: parent.height
        width: 32
        anchors.horizontalCenter: parent.horizontalCenter
        // 动态 this collider must be dynamic because we are moving it by applying forces and impulses
        bodyType: Body.Dynamic // this is the default value but I wanted to mention it ;)
        fixedRotation: true // we are running, not rolling...
        bullet: true // for super accurate collision detection, use this sparingly, because it's quite performance greedy
        sleepingAllowed: false
        // apply the horizontal value of the TwoAxisController as force to move the player left and right
        force: Qt.point(controller.xAxis*140*32,0)
        // limit the horizontal velocity
        onLinearVelocityChanged: {
            if(linearVelocity.x > 140) linearVelocity.x = 140
            if(linearVelocity.x < -140) linearVelocity.x = -140

        }
        /*fixture.onBeginContact: {
            var otherEntity = other.getBody().target
        if(otherEntity.entityType === "mushRoom1"  ){     //如果马里奥接触的是蘑菇身子
            //console.log("Mario killed the mushroom")
            //mushroom.source = "../../assets/img/mushroomR.gif"
            //mushRoom1.isMoving = false
            //drop.start()
            //collider.active=false
            mario.runover = true
            mario.hitKill()     //首先马里奥展现死亡动画

            resurgenceTimer.running = true      //处理马里奥死亡后的场景重建等
            collider.active=false   //马里奥不能再撞到蘑菇


           }
        }*/



    }


    //马里奥不允许出左边界
    onXChanged: {
        if (x < 0) {
            x = 0
        }
    }

    //实现减速
    Timer {
        id: updateTimer

        // Set this interval as high as possible to improve performance,
        // but as low as needed so it still looks good.
        interval: 60
        running: true
        repeat: true
        onTriggered: {
            var xAxis = controller.xAxis;
            // if xAxis is 0 (no movement command) we slow the player down until he stops
            if(xAxis == 0) {
                if(Math.abs(mario.horizontalVelocity) > 10) mario.horizontalVelocity /= 1.5
                else mario.horizontalVelocity = 0
            }
        }
    }
}
