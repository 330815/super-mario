import QtQuick 2.0
import Felgo 3.0

BrickBase {

    id:rockBrick

    width: gameScene.gridSize-4
    height: gameScene.gridSize* size

    Column {
        id: groundRow
        spacing: 0      //每个方块空隙为0
        Repeater {
            id: brickRepeater
            model:size//gameWindow.width/32
            delegate:
                Image{
                width: 32
                height: 32
                source: "../../assets/img/img/map-rock.png"
                fillMode: Image.Stretch
            }
        }
    }

}
