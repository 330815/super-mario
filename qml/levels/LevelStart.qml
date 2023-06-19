import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
  id: levelStart
  width: 21.5 * gameScene.gridSize

  // you could draw your level on a graph paper and then add the tiles here only by defining their row, column and size
  //---------------地面-------------
  GroundItem{
      row:0
      column: 0
      size: 23
  }
  GroundItem{
      row:0
      column: 1
      size: 23
  }

}
