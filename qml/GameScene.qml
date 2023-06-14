import QtQuick 2.0
import Felgo 3.0
import "entities"

// EMPTY SCENE

Scene {
    id:gameScene
    width: 480
    height: 480
    gridSize: 32
    property int offsetBeforeScrollingStarts: 240

    EntityManager {
        id: entityManager
    }

    //主背景
    ParallaxScrollingBackground {
        sourceImage: "../assets/img/gk1.jpg"
        movementVelocity: Qt.point(-10,0)
        //height: parent.height
        anchors.left: gameScene.gameWindowAnchorItem.left
        //anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        // the speed then gets multiplied by this ratio to create the parallax effect
        ratio: Qt.point(0.3,0)
    }

    //创建地面方块
    Row {
        id: groundRow
        spacing: 0      //每个方块空隙为0
        anchors.bottom: parent.bottom  //对齐底部
        Repeater {
            id: groundRepeater
            model:gameWindow.width/32
            delegate: Rectangle{
                id:groundColumn
                width: 32
                height: width*2
                Image{
                    width: parent.width
                    height: parent.height/2
                    source: "../assets/img/img/map-land.png"
                    fillMode: Image.Stretch
                    anchors.top: parent.top
                }
                Image{
                    width: parent.width
                    height: parent.height/2
                    source: "../assets/img/img/map-land.png"
                    fillMode: Image.Stretch
                    anchors.bottom:  parent.bottom
                }
            }
        }

    }


    //        Timer {
    //                id: groundMovementTimer
    //                interval: 50
    //                running: true
    //                repeat: true
    //                onTriggered: {
    //                    // 移动地面块
    //                    for (var i = 0; i < groundRepeater.count; i++) {
    //                        var groundBlock = groundRepeater.itemAt(i)
    //                        groundBlock.x -= 5
    //                    }
    //                    // 动态添加新的地面块
    //                   for (var j = 0; j < groundRepeater.count; j++) {
    //                         groundBlock = groundRepeater.itemAt(j)
    //                        if (groundBlock.x + groundBlock.width < 0) {
    //                            groundBlock.x += groundRepeater.count * groundBlock.width
    //                        }
    //                    }
    //                }
    //            }


    Item{
        //        id: viewPort
        //height: level.height
        //width: level.width
        //anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.bottom: groundRow.top
        //        x: mario.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-mario.x : 0

        PhysicsWorld {
            id: physicsWorld
//            gravity: Qt.point(0, 25)
//            debugDrawVisible: true // enable this for physics debugging
//            z: 1000

//            onPreSolve: {
//                //this is called before the Box2DWorld handles contact events
//                var entityA = contact.fixtureA.getBody().target
//                var entityB = contact.fixtureB.getBody().target
//                if(entityB.entityType === "platform" && entityA.entityType === "player" &&
//                        entityA.y + entityA.height > entityB.y) {
//                    //by setting enabled to false, they can be filtered out completely
//                    //-> disable cloud platform collisions when the player is below the platform
//                    contact.enabled = false
//                }
//            }
        }
        Mario {
            id: mario
            x:128
            y:-32
        }
    }



    Keys.forwardTo: controller
    //控制多轴运动
    TwoAxisController {
        id: controller
        onInputActionPressed: {
            console.debug("key pressed actionName " + actionName)
            if(actionName == "left") {
                // 左键按下
                console.log("turn left")
                mario.changeState("../../assets/img/img/basePersonL.gif") // 设置为奔跑状态的GIF
                mario.changeDirection(actionName)//修改方向
            }
            if(actionName == "right") {
                // 左键按下
                console.log("turn right")
                mario.changeState("../../assets/img/img/basePerson.gif") // 设置为奔跑状态的GIF
                mario.changeDirection(actionName)//修改方向
            }
            if(actionName == "up") {
                console.log("jump")
                mario.jump()
                if(mario.isRight){
                    mario.changeState("../../assets/img/img/basePersonUp.png")  //rightJump
                }else{
                    mario.changeState("../../assets/img/img/basePersonUpL.png") //leftJump
                }
            }
        }
        onInputActionReleased: {
            if(mario.isRight){
                mario.changeState("../../assets/img/img/basePerson.png")
            }else{
                mario.changeState("../../assets/img/img/basePersonL.png")
            }
        }
    }

}
