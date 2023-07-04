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
    // the contacts property is used to determine if the player is in touch with any solid objects (like ground or platform), because in this case the player is walking, which enables the ability to jump. contacts > 0 --> walking state
    property int contacts: 0

    property bool canControl: true

    //property int destination: value

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
        }
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

        die.running = true


    }

    function helpMushroom(){
        gameScene.reloader()
    }

    //结算动画
    function marioClimb(){

        marioImage.source = "../../assets/img/img/climbing.png"
        climb.start()
        collider.active = false

        changewalk.running=true




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

 //马里奥被蘑菇撞死的动画
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

    }

    //马里奥在旗杆上爬下来


       SequentialAnimation{
           id:climb
           NumberAnimation{
               target: mario
               property: "x"
               from:mario.x
               to:mario.x+20
               duration: 100

           }

           NumberAnimation{

               target: mario
               property: "y"
               from:150
               to:390
               duration: 3000
           }


       }



       SequentialAnimation{
           id:toend
           NumberAnimation{

                target: mario
                property: "x"
                from:1745
                to:2040
                duration: 4000
            }
           PropertyAction{
               target: marioImage
               property: "source"
               value: "../../assets/img/img/basePerson.png"
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




    }


    //马里奥不允许出左边界
    onXChanged: {
        if (x < 0) {
            x = 0
        }

        if (x >1737 && x<1743){
            console.log("llllll")

            state = "win"
            marioClimb()


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
