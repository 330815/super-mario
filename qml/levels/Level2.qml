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
<<<<<<< HEAD
        size: 54
=======
        size: 60
>>>>>>> superMario/main
    }
    GroundItem{
        row:0
        column: 1
<<<<<<< HEAD
        size: 54
=======
        size: 60
>>>>>>> superMario/main
    }
    GroundItem{

        row:92
        column: 0
<<<<<<< HEAD
        size: 26
=======
        size: 31
>>>>>>> superMario/main
    }
    GroundItem{
        row:92
        column: 1
<<<<<<< HEAD
        size: 26
=======
        size: 31
>>>>>>> superMario/main
    }
    GroundItem{

        row:126
        column: 0
<<<<<<< HEAD
        size: 70
=======
        size: 50
>>>>>>> superMario/main
    }
    GroundItem{
        row:126
        column: 1
<<<<<<< HEAD
        size: 70
=======
        size: 50
>>>>>>> superMario/main
    }
    //end---------------地面-------------


    //brick
    //最开始的区域
    Mushroom{
        id:mushroom0
        direction: 1
<<<<<<< HEAD
        row:12
=======
        row:20
>>>>>>> superMario/main
        column: 6
    }
    Mushroombrick{
        thismush: mushroom0
        id:mushbrick1
<<<<<<< HEAD
        row:12
=======
        row:20
>>>>>>> superMario/main
        column: 5
        size: 1
    }

    Coinbrick{
<<<<<<< HEAD
        row: 19
=======
        row: 27
>>>>>>> superMario/main
        column: 5
        coinsQuantity: 1
    }
    Ordinarybrick{
<<<<<<< HEAD
        row:20
=======
        row:28
>>>>>>> superMario/main
        column: 5
        size: 3
    }

    Coinbrick{
<<<<<<< HEAD
        row: 23
=======
        row: 31
>>>>>>> superMario/main
        column: 5
        coinsQuantity: 2
    }
    //最开始的区域end
    //垂直障碍
    Rockbrick{
<<<<<<< HEAD
        row:27
=======
        row:35
>>>>>>> superMario/main
        column: 2
        size: 1
    }

    Rockbrick{
<<<<<<< HEAD
        row:29
=======
        row:37
>>>>>>> superMario/main
        column: 3
        size: 2
    }

    Rockbrick{
<<<<<<< HEAD
        row:31
=======
        row:39
>>>>>>> superMario/main
        column: 4
        size: 3
    }

    Rockbrick{
<<<<<<< HEAD
        row:33
=======
        row:41
>>>>>>> superMario/main
        column: 5
        size: 4
    }

    Rockbrick{
<<<<<<< HEAD
        row:35
=======
        row:43
>>>>>>> superMario/main
        column: 5
        size: 4
    }

    Rockbrick{
<<<<<<< HEAD
        row:37
=======
        row:45
>>>>>>> superMario/main
        column: 4
        size: 3
    }

    Rockbrick{
<<<<<<< HEAD
        row:39
=======
        row:47
>>>>>>> superMario/main
        column: 3
        size: 2
    }

    Rockbrick{
<<<<<<< HEAD
        row:41
=======
        row:49
>>>>>>> superMario/main
        column: 2
        size: 1
    }
    //垂直障碍end
    //无地面区域
    Ordinarybrick{
<<<<<<< HEAD
        row:56
=======
        row:64
>>>>>>> superMario/main
        column: 2
        size: 2
    }

    Ordinarybrick{
<<<<<<< HEAD
        row:60
=======
        row:68
>>>>>>> superMario/main
        column: 4
        size: 1
    }
    Ordinarybrick{
<<<<<<< HEAD
        row:65
=======
        row:73
>>>>>>> superMario/main
        column: 3
        size: 1
    }

    Coinbrick{
<<<<<<< HEAD
        row: 71
=======
        row: 79
>>>>>>> superMario/main
        column: 7
        coinsQuantity: 2
    }

    Ordinarybrick{
<<<<<<< HEAD
        row:70
=======
        row:78
>>>>>>> superMario/main
        column: 4
        size: 3
    }

    Ordinarybrick{
<<<<<<< HEAD
        row:79
=======
        row:87
>>>>>>> superMario/main
        column: 5
        size: 1
    }
    //无地面区域end

    //小机关
    Ordinarybrick{
<<<<<<< HEAD
        row:84
=======
        row:92
>>>>>>> superMario/main
        column: 6
        size: 1
    }
    Ordinarybrick{
<<<<<<< HEAD
        row:84
=======
        row:92
>>>>>>> superMario/main
        column: 5
        size: 10
    }
    Ordinarybrick{
<<<<<<< HEAD
        row:88
=======
        row:96
>>>>>>> superMario/main
        column: 8
        size: 2
    }
    Mushroom{
        id:mushroom1
        direction: 0
<<<<<<< HEAD
        row:90
=======
        row:98
>>>>>>> superMario/main
        column: 9
    }
    Mushroombrick{
        thismush: mushroom1
<<<<<<< HEAD
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
=======
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
>>>>>>> superMario/main

}
