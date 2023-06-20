import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {

    id: level2
    // we need to specify the width to get correct debug draw for our physics
    // the PhysicsWorld component fills it's parent by default, which is the viewPort Item of the gameScene and this item uses the size of the level
    // NOTE: thy physics will also work without defining the width here, so no worries, you can ignore it untill you want to do some physics debugging
    width: 77 * gameScene.gridSize


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




//    Coinbrick{
//        id:coinbrick1
//        row: 8
//        column: 5
//        size: 4
//    }

//    Mushroom{
//        id:mushroom0
//        direction: 1
//        row:15
//        column: 6
//        size: 4
//    }

//    Mushroombrick{
//        thismush: mushroom0
//        id:mushbrick1
//        row:15
//        column: 5
//        size: 4
//    }

//    Ordinarybrick{
//        row:16
//        column: 5
//        size: 4
//    }

//    Coinbrick{
//        id:coinbrick2
//        row: 17
//        column: 5
//        size: 4
//    }

//    Coinbrick{
//        id:coinbrick3
//        row: 16
//        column: 8
//        size:4
//    }

//    Ordinarybrick{
//        row:26
//        column: 5
//        size: 4
//    }

//    Mushroom{
//        id:mushroom1
//        direction: 0
//        row:27
//        column: 6
//        size:4
//    }


//    Mushroombrick{
//        id:mushbrick2
//        thismush: mushroom1
//        row:27
//        column: 5
//        size: 4
//    }



//    Ordinarybrick{
//        row:28
//        column: 5
//        size: 4
//    }

//    function resetScene(){
//        mushroom0.resetMushroom()
//        mushroom0.x = 490
//        mushroom0.y = 270
//        mushroom1.resetMushroom()
//        mushroom1.x = 867
//        mushroom1.y = 270
//        mushbrick1.mushroombrickReset()
//        mushbrick2.mushroombrickReset()
//        coinbrick1.restoreCoinbrick()
//        coinbrick2.restoreCoinbrick()
//        coinbrick3.restoreCoinbrick()



//    }




}
