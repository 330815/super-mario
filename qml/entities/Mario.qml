import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id:mario
    height: 32
    width: 32
    z:10
    entityType: "mario"


    //添加别名
    property alias collider: collider
    //speed
    property alias horizontalVelocity: collider.linearVelocity.x
    //derection
    property bool isRight:true  //默认马里奥朝右
    //left-right press
    property bool isPress: false //默认没按下
    //按键是否有效
    property bool canControl:true
    // the contacts property is used to determine if the player is in touch with any solid objects (like ground or platform), because in this case the player is walking, which enables the ability to jump. contacts > 0 --> walking state
    property int contacts: 0

    //用于判断马里奥是否死亡
    property bool isdead: false




    // property binding to determine the state of the player like described abovestate = "jumping"
    state: (contacts > 0 &&canControl==true)? "walking" : "jumping"

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





    Timer{
        id:changewalk
        interval:3000
        running:false
        onTriggered: {

           changeState("../../assets/img/img/basePerson.gif")
            toend.start()
            //stoplevel.start()
            stopbackground.start()
        }
    }



    Timer{
        id:keep
        interval: 3200 // 适当的时间间隔
        running: false
        repeat: true
        onTriggered: {
            marioImage.playing = true

            marioImage.source = "../../assets/img/img/basePerson.gif"

        }
    }

    Timer{
        id: changelevel
        interval: 8000 // 适当的时间间隔
        running: false
        repeat: false
        onTriggered: {
            keep.running = false
            gameScene.reloader()
            if(activeLevelString === "Level1"){
            gameScene.activeLevelString = "Level2"
            collider.active = true

            background.x-=400

            console.log(mario.contacts)
            mario.x = 128
            mario.y = 0
            mario.changeState("../../assets/img/img/basePerson.png")
            gameScene.resetLeftTime()
            worlds = "1-2"

            }
            else
            {
              background.x-=400
              marioReset()
              marioLives = 0
            }


        }
    }

    //使马里奥保持死亡姿势
    function closeKeep(){
        keep.running = false
    }





    function helpMushroom(){
        gameScene.reloader()
    }

    //结算动画
    function marioClimb(){
        mario.canControl = false

        marioImage.source = "../../assets/img/img/climbing.png"
        climb.start()
        keep.running = true
        changewalk.running = true
        changelevel.running = true





    }


    //使马里奥恢复初始状态，生命值-1
    function marioReset(){

        canControl = false
        mario.isdead = false
        mario.changeState("../../assets/img/img/basePerson.png")
        mario.visible=true
        x=128
        y=0
        marioLives--
        //重新加载界面
        gameScene.reloader()
    }



    //马里奥死亡动画
    function hitKill(){
        audioManager.playSound("marioDies")
        canControl =false       //不再接受键盘消息
        collider.active=false   //马里奥不能再撞到蘑菇
        marioImage.source = "../../assets/img/img/diePerson.png"
        //最前面落下
        mario.z = 150
        //死亡画面和计时器同时进行
        die.running = true
        resurgenceTimer.running = true

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
        }else if(state == "win"){
            horizontalVelocity = 0
            collider.active = false
            marioImage.source = "../../assets/img/img/basePerson.gif"
        }
    }


    //马里奥不允许出左边界
    onXChanged: {
        if (x < 0) {
            x = 0
        }
    }

    //落下死亡
    onYChanged: {
        if(y>level.height){
            audioManager.playSound("marioDies")
            if(marioLives>0){       //gameover时不执行
                gameWindow.state = "death"
                deathScene.state = "play"
                deathScene.startdsTimer()
            }
            //马里奥死亡,,恢复初始状态
            marioReset()
            //            //重新加载界面
            //            gameScene.reloader()

        }

    }



 //马里奥被蘑菇撞死的动画

    SequentialAnimation {
        //running: false
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
            duration: 1300

        }
      }



    //马里奥在旗杆上爬下来


       SequentialAnimation{
           id:climb
           NumberAnimation{

               target: mario
               property: "y"
               from:150
               to:390
               duration: 3500
           }


       }



       SequentialAnimation{
           id:toend


           NumberAnimation{

                target: mario
                property: "x"
                from:mario.x
                to:mario.x+300
                duration: 4000
            }
           PropertyAction{
               target: marioImage
               property: "source"
               value: "../../assets/img/img/basePerson.png"
           }

       }

       SequentialAnimation{
           id:stopbackground
           NumberAnimation{
               target: background
               property: "x"
               from:background.x
               to:background.x+400
               duration: 4000
           }
       }










    //马里奥外观
    AnimatedImage {
        id: marioImage
        anchors.centerIn: parent
        source: "../../assets/img/img/basePerson.png"
        playing: true

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
                if(Math.abs(mario.horizontalVelocity) > 50) mario.horizontalVelocity /= 1.5
                else mario.horizontalVelocity = 0
            }
        }
    }

    //定时器结束，即死亡动画结束，，进行初始化
    Timer {
        id: resurgenceTimer
        interval: 3000 // 适当的时间间隔
        running: false
        repeat: false

        onTriggered: {
            console.log("Mario was killed by a mushroom")
            if(marioLives>0){       //gameover时不执行
                gameWindow.state = "death"
                deathScene.state = "play"
                deathScene.startdsTimer()
            }
            //马里奥死亡,,恢复初始状态
            mario.marioReset()

        }
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




    }




}

