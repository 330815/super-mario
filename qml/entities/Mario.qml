import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id:mario
    height: 32
    width: 32
    entityType: "mario"
    property int marioLives: 3

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

    Timer{
        id:keep
        interval: 10 // 适当的时间间隔
        running: false
        repeat: true


        onTriggered: {

            marioImage.source = "../../assets/img/img/diePerson.png"

        }
    }

    function closeKeep(){
        keep.running = false
    }



    function hitKill(){

        keep.running=true
        console.log(mario.z)
                    console.log(level.z)


        collider.active = false
        marioImage.source = "../../assets/img/img/diePerson.png"
        die.running = true


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
                marioLives--
                level.resetScene()
                mario.y=0
                mario.x=128
            }
            else{

                console.log("Mario is really dead this time")
            }


        }

    }

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
            to:500
            duration: 1000

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
