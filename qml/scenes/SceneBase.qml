import QtQuick 2.0
import Felgo 3.0
import "../common"
import QtQuick.Controls 2.0
// EMPTY SCENE

Scene {
    id:sceneBase
    // the "logical size" - the scene content is auto-scaled to match
    // the gameWindow's size
    width: 480
    height: 480

    // by default, set the opacity to 0
    // We handle this property from PlatformerMain via PropertyChanges
    opacity: 0

    // the scene is only visible if the opacity is > 0
    // this improves the performance
    visible: opacity > 0

    // only enable scene if it is visible
    enabled: visible

    //the mario's score
    property int scores : 0

    property int sumCoins : 0

    property string worlds: "0-0"

    property int times:0
    Rectangle {
        z:1
        anchors.top: parent.top
        color: "blue"
        width:gameWindowAnchorItem.width
        //height:gridSize*2
        Row{
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 15
            anchors.leftMargin: 10
            spacing: 145
            ThemeText {
                id: scoreTxt

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        scores += 100
                    }
                }
                //六位数字
                text: qsTr("MARIO\n\n"+String(scores).padStart(6, "0"))
            }

            ThemeText {
                id: coinTxt
                AnimatedImage{
                    x:5
                    y:25
                    source:"../../assets/img/coins.gif"
                    playing:true
                }
                text: qsTr("COINS\n\nX"+sumCoins)
            }
            ThemeText {
                id: worldTxt
                text: qsTr("WORLD\n\n"+worlds)

            }
            ThemeText {
                id: timeTxt
                text: qsTr("TIME\n\n"+times)

            }
        }

    }
}
