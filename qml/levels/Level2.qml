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
        size: 54
    }
    GroundItem{
        row:0
        column: 1
        size: 54
    }
    GroundItem{

        row:92
        column: 0
        size: 26

    }
    GroundItem{
        row:92
        column: 1
        size: 26
    }
    GroundItem{

        row:126
        column: 0
        size: 70
    }
    GroundItem{
        row:126
        column: 1

        size: 70

    }
    //end---------------地面-------------


    //brick
    //最开始的区域
    Mushroom{
        id:mushroom0
        direction: 1
        row:12
        column: 6
    }
    Mushroombrick{
        thismush: mushroom0
        id:mushbrick1
        row:12
        column: 5
        size: 1
    }

    Coinbrick{
        row: 19
        column: 5
        coinsQuantity: 1
    }
    Ordinarybrick{
        row:20
        column: 5
        size: 3
    }

    Coinbrick{
        row: 23
        column: 5
        coinsQuantity: 2
    }
    //最开始的区域end
    //垂直障碍
    Rockbrick{
        row:27
        column: 2
        size: 1
    }

    Rockbrick{
        row:29
        column: 3
        size: 2
    }

    Rockbrick{
        row:31
        column: 4
        size: 3
    }

    Rockbrick{
        row:33
        column: 5
        size: 4
    }

    Rockbrick{
        row:35
        column: 5
        size: 4
    }

    Rockbrick{
        row:37
        column: 4
        size: 3
    }

    Rockbrick{
        row:39
        column: 3
        size: 2
    }

    Rockbrick{
        row:41
        column: 2
        size: 1
    }
    //垂直障碍end
    //无地面区域
    Ordinarybrick{
        row:56
        column: 2
        size: 2
    }

    Ordinarybrick{
        row:60
        column: 4
        size: 1
    }
    Ordinarybrick{
        row:65
        column: 3
        size: 1
    }

    Coinbrick{
        row: 71
        column: 7
        coinsQuantity: 2
    }

    Ordinarybrick{
        row:70
        column: 4
        size: 3
    }

    Ordinarybrick{
        row:79
        column: 5
        size: 1
    }
    //无地面区域end

    //小机关
    Ordinarybrick{
        row:84
        column: 6
        size: 1
    }
    Ordinarybrick{
        row:84
        column: 5
        size: 10
    }
    Ordinarybrick{
        row:88
        column: 8
        size: 2
    }
    Mushroom{
        id:mushroom1
        direction: 0
        row:90
        column: 9
    }
    Mushroombrick{
        thismush: mushroom1
        row:90
        column: 8
        size: 1
    }

    Coinbrick{
        row: 91
        column: 8
                coinsQuantity: 2
    }
    Ordinarybrick{
        row:93
        column: 6
        size: 1
    }
    Ordinarybrick{
        row:93
        column: 7
        size: 1
    }
    Ordinarybrick{
        row:92
        column: 8
        size: 2
    }
    //小机关end
    //两个金币方块
    Coinbrick{
        row: 101
        column: 5
                coinsQuantity: 1
    }
    Coinbrick{
        row: 102
        column: 5
                coinsQuantity: 1
    }
    //两个金币方块end
    //可以顶超多次的方块
    Rockbrick{
        row:109
        column: 5
        size: 4
    }
    Coinbrick{
        row: 110
        column: 5
                coinsQuantity: 10
    }
    Ordinarybrick{
        row:111
        column: 5
        size: 4
    }
    //可以顶超多次的方块end
    //跳云台
    Ordinarybrick{
        row:122
        column: 5
        size: 1
    }
    Ordinarybrick{
        row:129
        column: 7
        size: 1
    }

    Ordinarybrick{
        row:129
        column: 11
        size: 1
    }
    Ordinarybrick{
        row:134
        column: 7
        size: 1
    }
    Rockbrick{
        row:137
        column: 12
        size: 11
    }
    //跳云台end
    //胜利的阶梯
    Rockbrick{
        row:142
        column: 2
        size: 1
    }
    Rockbrick{
        row:143
        column: 3
        size: 2
    }
    Rockbrick{
        row:144
        column: 4
        size: 3
    }
    Rockbrick{
        row:145
        column: 5
        size: 4
    }
    Rockbrick{
        row:146
        column: 6
        size: 5
    }
    Rockbrick{
        row:147
        column: 7
        size: 6
    }
    Rockbrick{
        row:148
        column: 8
        size: 7
    }
    Rockbrick{
        row:149
        column: 9
        size: 8
    }
    Rockbrick{
        row:150
        column: 9
        size: 8
    }
    //胜利的阶梯end

    Flag{
        row:156
        column: 10
    }

    Castle{
        row:161
        column: 6
    }
                                                                                    p

}

