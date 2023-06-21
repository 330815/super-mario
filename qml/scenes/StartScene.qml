import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0

import "../entities"

import "../levels"
import "../common"

SceneBase {
    id:startScene
    gridSize: 32
    //signal gameStart

    //按下P键，进行游戏，该函数对游戏进行初始化
    //deathscene呈现两秒，，加载地图，，马里奥初始状态
    function initGame(){
        //boardBox.active = false //板子不再可碰撞

        worlds = lvImage1.visible ? "1-1":"1-2"

        gameWindow.state = "death"
        deathScene.state = "play"
    }

    EntityManager {
        id: entityManager
    }

    //中心板
    Image{
        id:startBoard
//        width: 32
//        fillMode: Image.PreserveAspectFit
//        source: "../../assets/img/B88A5C5EA393A27FDC967B74A7BBB72B.png"
        source:"../../assets/img/startBoard.png"
        x:180
        y:80
        z:5
//        BoxCollider {
//            id:boardBox
//            anchors.fill: parent
//            bodyType: Body.Static
//            enabled: false
//            active: false
//        }
    }
    //小声明
    Text{
        id:author
        font.family: themeFont.name  // 使用自定义字体
        font.pointSize: 7  // 设置字体大小
        anchors.top: startBoard.bottom
        anchors.right: startBoard.right
        text:qsTr("@2023 by DuJiangxin,XiangYuhan")
        color: "#ff9900"
        z:2
    }

    /*********关卡选择********/
    ThemeText{
        id:selectLevel
        anchors.top: startBoard.bottom
        anchors.topMargin: 30
        text:qsTr("SELECT:TAB   CONFIRM:P")
        x:200
    }
    ThemeText{
        id:slctLevel1
        anchors.top: selectLevel.bottom
        anchors.topMargin: 30
        AnimatedImage{
            id:lvImage1
            x:-20
            y:-3
            source:"../../assets/img/macadam.gif"
            playing:true
            visible: true
        }
        text:qsTr("WORLD~1-1")
        x:210
    }
    ThemeText{
        id:slctLevel2
        anchors.top: selectLevel.bottom
        anchors.right: selectLevel.right
        anchors.topMargin: 30
        AnimatedImage{
            id:lvImage2
            x:-20
            y:-3
            source:"../../assets/img/macadam.gif"
            playing:true
            visible: false
        }
        text:qsTr("WORLD~1-2")
    }

    Keys.onPressed:  {
        //SELECT
        if(event.key === Qt.Key_Tab){
            lvImage1.visible =!lvImage1.visible
            lvImage2.visible =!lvImage2.visible

            //handle level
            gameScene.activeLevelString = lvImage1.visible ? "Level1":"Level2"
        }

        //CONFIRM
        if (event.key === Qt.Key_P) {
            initGame()

        }

    }

    //实体
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
        }

        LevelStart{
            id:level
            z:1
        }

        Mario {
            id: mario
            z:10
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
