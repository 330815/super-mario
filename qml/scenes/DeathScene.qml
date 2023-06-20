import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase {
    id:deathScene
    signal gametest
    //mario die and life>0
    Rectangle{
        id:lifeLose
        visible: false
        x:300
        y:170
        ThemeText {
            id:currentWorld
            text: "WORLD 1-1"

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
            text: " X "+3

        }
    }
    //mario die and life=0
    Rectangle{
        id:gameover
        visible: false
        x:300
        y:220
        ThemeText {
            text: "GAME OVER"

        }
    }
    //timeup
    Rectangle{
        id:timeup
        visible: true
        x:300
        y:220
        ThemeText {
            text: "TIME UP"
        }
    }
}
