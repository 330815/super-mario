import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {

    id: level2
    // we need to specify the width to get correct debug draw for our physics
    // the PhysicsWorld component fills it's parent by default, which is the viewPort Item of the gameScene and this item uses the size of the level
    // NOTE: thy physics will also work without defining the width here, so no worries, you can ignore it untill you want to do some physics debugging
    width: 176* gameScene.gridSize


    // you could draw your level on a graph paper and then add the tiles here only by defining their row, column and size
    //---------------地面-------------
    GroundItem{

        row:0
        column: 0
        size: 60
    }
    GroundItem{
        row:0
        column: 1
        size: 60
    }
    GroundItem{

        row:92
        column: 0
        size: 31
    }
    GroundItem{
        row:92
        column: 1
        size: 31
    }
    GroundItem{

        row:126
        column: 0
        size: 50
    }
    GroundItem{
        row:126
        column: 1
        size: 50
    }
    //end---------------地面-------------


    //brick
    //最开始的区域
    Mushroom{
        id:mushroom0
        direction: 1
        row:20
        column: 6
    }
    Mushroombrick{
        thismush: mushroom0
        id:mushbrick1
        row:20
        column: 5
        size: 1
    }

    Coinbrick{
        row: 27
        column: 5
        coinsQuantity: 1
    }
    Ordinarybrick{
        row:28
        column: 5
        size: 3
    }

    Coinbrick{
        row: 31
        column: 5
        coinsQuantity: 2
    }
    //最开始的区域end
    //垂直障碍
    Rockbrick{
        row:35
        column: 2
        size: 1
    }

    Rockbrick{
        row:37
        column: 3
        size: 2
    }

    Rockbrick{
        row:39
        column: 4
        size: 3
    }

    Rockbrick{
        row:41
        column: 5
        size: 4
    }

    Rockbrick{
        row:43
        column: 5
        size: 4
    }

    Rockbrick{
        row:45
        column: 4
        size: 3
    }

    Rockbrick{
        row:47
        column: 3
        size: 2
    }

    Rockbrick{
        row:49
        column: 2
        size: 1
    }
    //垂直障碍end
    //无地面区域
    Ordinarybrick{
        row:64
        column: 2
        size: 2
    }

    Ordinarybrick{
        row:68
        column: 4
        size: 1
    }
    Ordinarybrick{
        row:73
        column: 3
        size: 1
    }

    Coinbrick{
        row: 79
        column: 7
        coinsQuantity: 2
    }

    Ordinarybrick{
        row:78
        column: 4
        size: 3
    }

    Ordinarybrick{
        row:87
        column: 5
        size: 1
    }
    //无地面区域end

    //小机关
    Ordinarybrick{
        row:92
        column: 6
        size: 1
    }
    Ordinarybrick{
        row:92
        column: 5
        size: 10
    }
    Ordinarybrick{
        row:96
        column: 8
        size: 2
    }
    Mushroom{
        id:mushroom1
        direction: 0
        row:98
        column: 9
    }
    Mushroombrick{
        thismush: mushroom1
        row:98
        column: 8
        size: 1
    }

    Coinbrick{
        row: 99
        column: 8
                coinsQuantity: 2
    }
    Ordinarybrick{
        row:101
        column: 6
        size: 1
    }
    Ordinarybrick{
        row:101
        column: 7
        size: 1
    }
    Ordinarybrick{
        row:100
        column: 8
        size: 2
    }
    //小机关end
    //两个金币方块
    Coinbrick{
        row: 109
        column: 5
                coinsQuantity: 1
    }
    Coinbrick{
        row: 110
        column: 5
                coinsQuantity: 1
    }
    //两个金币方块end
    //可以顶超多次的方块
    Rockbrick{
        row:117
        column: 5
        size: 4
    }
    Coinbrick{
        row: 118
        column: 5
                coinsQuantity: 10
    }
    Ordinarybrick{
        row:119
        column: 5
        size: 4
    }
    //可以顶超多次的方块end
    //跳云台
    Ordinarybrick{
        row:130
        column: 5
        size: 1
    }
    Ordinarybrick{
        row:137
        column: 7
        size: 1
    }

    Ordinarybrick{
        row:137
        column: 11
        size: 1
    }
    Ordinarybrick{
        row:142
        column: 7
        size: 1
    }
    Rockbrick{
        row:145
        column: 12
        size: 11
    }
    //跳云台end
    //胜利的阶梯
    Rockbrick{
        row:150
        column: 2
        size: 1
    }
    Rockbrick{
        row:151
        column: 3
        size: 2
    }
    Rockbrick{
        row:152
        column: 4
        size: 3
    }
    Rockbrick{
        row:153
        column: 5
        size: 4
    }
    Rockbrick{
        row:154
        column: 6
        size: 5
    }
    Rockbrick{
        row:155
        column: 7
        size: 6
    }
    Rockbrick{
        row:156
        column: 8
        size: 7
    }
    Rockbrick{
        row:157
        column: 9
        size: 8
    }
    Rockbrick{
        row:158
        column: 9
        size: 8
    }
    //胜利的阶梯end

}
