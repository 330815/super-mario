import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {

    id: level1
    // we need to specify the width to get correct debug draw for our physics
    // the PhysicsWorld component fills it's parent by default, which is the viewPort Item of the gameScene and this item uses the size of the level
    // NOTE: thy physics will also work without defining the width here, so no worries, you can ignore it untill you want to do some physics debugging
    width: 77 * gameScene.gridSize // 42 because our last tile is a size 30 Ground at row 12


    // you could draw your level on a graph paper and then add the tiles here only by defining their row, column and size
    //---------------地面-------------
    GroundItem{
        row:0
        column: 0
        size: 30
    }
    GroundItem{
        row:0
        column: 1
        size: 30
    }


    GroundItem{
        row:32
        column: 0
        size: 15
    }

    GroundItem{
        row:32
        column: 1
        size: 15
    }

    GroundItem{
        row:47
        column: 0
        size: 30
    }
    GroundItem{
        row:47
        column: 1
        size: 30
    }





    Coinbrick{
        row: 8
        column: 5
        size: 4
    }

    Mushroom{
        id:textmushroom
        row:15
        column: 6
        size: 4
    }

    Mushroombrick{
        row:15
        column: 5
        size: 4
    }

    Ordinarybrick{
        row:16
        column: 5
        size: 4
    }

    Coinbrick{
        row: 17
        column: 5
        size: 4
    }

    Coinbrick{
        row: 16
        column: 8
        size:4
    }

    Ordinarybrick{
        row:26
        column: 5
        size: 4
    }

    Mushroom{
        id:mushroom1
        row:27
        column: 6
        size:4
    }

    Mushroombrick2{
        row:27
        column: 5
        size: 4
    }


    Ordinarybrick{
        row:28
        column: 5
        size: 4
    }




}
