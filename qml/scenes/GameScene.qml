import QtQuick 2.0
import Felgo 3.0
import "../entities"
import "../"
import "../levels"
import "../common"

SceneBase {
    id:gameScene
    gridSize: 32
    //马里奥固定位置X坐标
    property int offsetBeforeScrollingStarts: 240


    EntityManager {
        id: entityManager
    }

    State {
        name: "play"
        StateChangeScript {script: audioManager.handleMusic()}
    }



    Item{
        id: viewPort
        height: level.height
        width: level.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x: mario.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-mario.x : 0
        Level1{
            id:level
            z:100
        }
        //主背景
        BackgroundImage{
            fillMode: Image.TileHorizontally    //水平平铺
            verticalAlignment: Image.AlignLeft
            source: "../../assets/img/gk1.jpg"
            z:0     //最底层
            width: parent.width
        }
        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 30)
            z: 1000
        }


        Mario {
            id: mario
            x:128
        }


        ResetSensor{

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
