import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../entities"
import "../levels"
SceneBase {
    id:deathScene

    //修改可见界面，并设置计时器
    states: [
        State {
            name: "play"
            PropertyChanges {target: lifeLose; visible: true}
            PropertyChanges {target: gameover; visible: false}
            PropertyChanges {target: timeup; visible: false}
            PropertyChanges {target: deathSceneTimer; onTriggered:{gameScene.resetLeftTime();gameWindow.state = "game"}}
            StateChangeScript {script: startdsTimer()}
        },
        State {
            name: "gameover"
            PropertyChanges {target: lifeLose; visible: false}
            PropertyChanges {target: gameover; visible: true}
            PropertyChanges {target: timeup; visible: false}
            //回到初始界面
            PropertyChanges {target: deathSceneTimer; onTriggered:{gameWindow.state = "start";gameScene.reloader();marioLives = 3;
                }}
            StateChangeScript {script: startdsTimer()}
        },
        State {
            name: "timeup"
            PropertyChanges {target: lifeLose; visible: false}
            PropertyChanges {target: gameover; visible: false}
            PropertyChanges {target: timeup; visible: true}
            PropertyChanges {target: deathSceneTimer; onTriggered:{state = marioLives >0? "play": "gameover"}}
            StateChangeScript {script: startdsTimer()}

        }
    ]


    //开始计时
    function startdsTimer(){
        deathSceneTimer.running = true
    }



    //mario die and life>0 生命值-1,本关重新开始
    Rectangle{
        id:lifeLose
        visible: false
        x:300
        y:170
        ThemeText {
            id:currentWorld

            text: "WORLD "+worlds

        }
        Image {
            id:hpImg
            anchors.top: currentWorld.bottom
            anchors.topMargin: 25
            source: "../../assets/img/img/basePerson.png"
        }
        ThemeText {
            anchors.top: currentWorld.bottom
            anchors.topMargin: 35
            anchors.left: hpImg.right
            anchors.leftMargin: 15
            text: " X " + marioLives

        }
    }
    //mario die and life=0 游戏重新开始
    Rectangle{
        id:gameover
        visible: false
        x:300
        y:220
        ThemeText {
            text: "GAME OVER"

        }
    }
    //timeup 生命值-1,本关重新开始
    Rectangle{
        id:timeup
        visible: false
        x:300
        y:220
        ThemeText {
            text: "TIME UP"
        }
    }

    //死亡界面倒计时
    Timer {
        id: deathSceneTimer
        interval: 2000 // 2秒钟
        running: false
        repeat: false
        onTriggered: {
            gameScene.resetLeftTime()
            gameWindow.state = "game"


        }
    }
}
