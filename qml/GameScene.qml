import QtQuick 2.0
import Felgo 3.0
import "entities"
import QtLocation 5.15

import "levels"
import QtPositioning 5.15

// EMPTY SCENE

Scene {
    id:gameScene
    width: 480
    height: 480
    gridSize: 32

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
            model:100//gameWindow.width/32
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


//    Timer {
//            id: groundMovementTimer
//            interval: 50
//            running: true
//            repeat: true
//            onTriggered: {
//                // 移动地面块
//                for (var i = 0; i < groundRepeater.count; i++) {
//                    var groundBlock = groundRepeater.itemAt(i)
//                    groundBlock.x -= 5
//                }
//                // 动态添加新的地面块
//               for (var j = 0; j < groundRepeater.count; j++) {
//                     groundBlock = groundRepeater.itemAt(j)
//                    if (groundBlock.x + groundBlock.width < 0) {
//                        groundBlock.x += groundRepeater.count * groundBlock.width
//                    }
//                }
//            }
//        }



    Mario {
        id: mario
        x: 50// 设置初始位置
        y: groundRow.y
        anchors.bottom: groundRow.top


    }

    Level1{
        id:level
    }

    Keys.onLeftPressed: {
        // 左键按下
        //mario.x -=10
        level.x+=10
        gameScene.x-=10
        console.log("turn left")
        mario.changeState("../../assets/img/img/basePersonL.gif") // 设置为奔跑状态的GIF
        for (var i = 0; i < groundRepeater.count; i++) {
                         var groundBlock = groundRepeater.itemAt(i)
                         groundBlock.x += 10

                    }
        if(mario.x > gameWindow.width*0.1){
            mario.x-=5
        }


    }





    Keys.onRightPressed: {
        // 左键按下
        //mario.x += 10
        level.x -= 10
        gameScene.x +=10
        console.log("turn Right")
        mario.changeState("../../assets/img/img/basePerson.gif") // 设置为奔跑状态的GIF
        for (var i = 0; i < groundRepeater.count; i++) {
                         var groundBlock = groundRepeater.itemAt(i)

                          groundBlock.x -= 10
                    }
        if(mario.x<gameWindow.width*0.4){
            mario.x+=5
        }

    }

    Keys.onReleased: {
        // 左键或右键松开
        if (event.key === Qt.Key_Left) {
            mario.changeState("../../assets/img/img/basePersonL.png")
        }else if(event.key === Qt.Key_Right){
            mario.changeState("../../assets/img/img/basePerson.png")
        }
    }




}
