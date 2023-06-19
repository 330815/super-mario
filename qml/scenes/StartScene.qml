import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0

import "../entities"

import "../levels"
import "../common"

SceneBase {
    id:startScene
    gridSize: 32
    signal gametest

    Rectangle {
        //Text: "Felgo"
        color: "red"
        z:1000
        anchors.centerIn: parent
        Button{
            onClicked:{
                gametest()
            }
        }

    }

    EntityManager {
        id: entityManager
    }

    State {
        name: "start"
        StateChangeScript {script: audioManager.handleMusic()}
    }


    Item{
        height: level.height
        width: level.width
        anchors.bottom: startScene.gameWindowAnchorItem.bottom
        //主背景
        BackgroundImage{
            source: "../../assets/img/gk1.jpg"
            z:0     //最底层
        }
        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 30)
            z: 1000
        }
        LevelStart{
            id:level
            z:100
        }

        Mario {
            id: mario
            x:128
            //不允许出界
            onXChanged: {
                if(x>level.width)
                    x = level.width
            }
        }
    }

    Keys.forwardTo: controller
    //控制多轴运动
    TwoAxisController {

        id: controller
        //处理按键变化时，图片的变化
        onInputActionPressed: {
            if(mario.state == "walking"){
                if(actionName == "left") {
                    // 左键按下
                    mario.isPress = true
                    mario.changeState("../../assets/img/img/basePersonL.gif") // 设置为奔跑状态的GIF
                    mario.changeDirection(actionName)//修改方向
                }
                if(actionName == "right") {
                    // 右键按下
                    mario.isPress = true
                    mario.changeState("../../assets/img/img/basePerson.gif") // 设置为奔跑状态的GIF
                    mario.changeDirection(actionName)//修改方向
                }
            }else if(mario.state == "jumping"){
                if(actionName == "left") {
                    // 左键按下
                    mario.isPress = true
                    mario.changeState("../../assets/img/img/basePersonUpL.png")
                    mario.changeDirection(actionName)//修改方向
                }
                if(actionName == "right") {
                    // 右键按下
                    mario.isPress = true
                    mario.changeState("../../assets/img/img/basePersonUp.png")
                    mario.changeDirection(actionName)//修改方向
                }
            }
            if(actionName == "up") {    //跳跃
                mario.jump()
            }
        }
        onInputActionReleased: {
            if(mario.state == "walking"){
                if(actionName == "left") {
                    mario.isPress = false
                    mario.changeState("../../assets/img/img/basePersonL.png")
                }else if(actionName == "right") {
                    mario.isPress = false
                    mario.changeState("../../assets/img/img/basePerson.png")
                }
            }else if(mario.state == "jumping"){
                if(actionName == "left" || actionName == "right") {
                    mario.isPress = false
                }
            }
        }
    }

}
