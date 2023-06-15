import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id:player
    height: 32
    width: 32
    entityType: "player"
    //修改马里奥的运动状态资源
    function changeState(source){
        mario.source =source
        mario.playing = true

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

    //实现马里奥跳跃
    function jump() {
        console.debug("jump requested at player.state " + state)
        //if(player.state == "walking") {
        console.debug("do the jump")
        // for the jump, we simply set the upwards velocity of the collider
        collider.linearVelocity.y = -30
        //}
    }
    //添加别名
    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x
    //derection
    property bool isRight:true  //默认马里奥朝右
    //马里奥外观
    AnimatedImage {
        id: mario
        anchors.centerIn: parent
        source: "../../assets/img/img/basePerson.png"
        playing: true
    }
    //碰撞组件
    BoxCollider {
        id: collider
        height: parent.height
        width: 30
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
                if(Math.abs(player.horizontalVelocity) > 10) player.horizontalVelocity /= 1.5
                else player.horizontalVelocity = 0
            }
        }
    }
}
