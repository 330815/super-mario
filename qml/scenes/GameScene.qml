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

    // the name of the currently loaded level
    property string activeLevelString : "Level1"
    property Loader scenelevel: level

    // reset time and timer
    function resetLeftTime() {

      times = 40  //游戏限时400s
      timer.running = true

    }

    function reloader(){
        activeLevelString = "LevelBase"
        activeLevelString = "Level1"
        sumCoins = 0
        scores = 0
    }

    EntityManager {
        id: entityManager
    }

    //实体
    Item{
        id: viewPort
        height: level.height
        width: level.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x: mario.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-mario.x : 0  //控制马里奥始终在中心
        //加载地图
        Loader {
          id: level
          // this binding gets cleared when restart city is pressed
          source: "../levels/"+ activeLevelString + ".qml"
          z:10
        }

        //主背景
        BackgroundImage{
            fillMode: Image.TileHorizontally    //水平平铺
            //verticalAlignment: Image.AlignLeft
            source: "../../assets/img/gk1.jpg"
            z:0     //最底层
            width: parent.width
        }
        //实现物理世界
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

    //游戏时间倒计时
    Timer {
        id: timer
        interval: 1000 // 1秒钟
        running: false
        repeat: true
        onTriggered: {
            times--
            //时间到，，跳转death界面，此时death界面state为timeup
            if(times <= 0) {
                timer.stop()
                gameWindow.state = "death"
                deathScene.state = "timeup"
            }
        }
    }

    Keys.forwardTo: controller
    //控制多轴运动
    TwoAxisController {

        id: controller
        //处理按键变化时，图片的变化
        onInputActionPressed: {
            if(mario.canControl == true){
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




