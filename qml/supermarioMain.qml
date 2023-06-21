import Felgo 3.0
import QtQuick 2.0
import "common"
import "scenes"

GameWindow {
    id: gameWindow


    activeScene: startScene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 960
    screenHeight: 640
    //the mario's score
    property int scores : 0

    property int sumCoins : 0

    property string worlds: "0-0"

    property int times:0

    property int marioLives: 3

    onMarioLivesChanged: {
        if(marioLives == 0){
            gameWindow.state = "death"
            deathScene.state = "gameover"
        }
    }

    onStateChanged: {
        audioManager.handleMusic()
    }

    AudioManager {
        id: audioManager
    }
    //font loader
    FontLoader {
        id: themeFont
        source: "../assets/fonts/themefont.ttf"  // 主题字体
    }

    FontLoader {
        id: introductionFont
        source: "../assets/fonts/introductionfont.ttf"  // 简介板中的字体
    }
    //Secene

    StartScene{
        id:startScene
        anchors.left: parent.left
    }


    GameScene {
        id: gameScene
        anchors.left: parent.left

    }


    DeathScene {
        id: deathScene
        anchors.left: parent.left

    }

    //states
    state: "start"

    // this state machine handles the transition between scenes
    states: [
        State {
            name: "start"
            PropertyChanges {target: startScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: startScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: gameScene}
        },
        State {
            name: "death"
            PropertyChanges {target: deathScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: deathScene}
        }

    ]


}
