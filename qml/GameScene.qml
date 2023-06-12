import QtQuick 2.0
import Felgo 3.0

// EMPTY SCENE

Scene {
    id:gameScene
    height: 480

    ParallaxScrollingBackground {
      sourceImage: "../assets/img/gk1.jpg"
      movementVelocity: Qt.point(-10,0)
      //height: parent.height
      anchors.left: gameScene.gameWindowAnchorItem.left
      //anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
      // the speed then gets multiplied by this ratio to create the parallax effect
      ratio: Qt.point(0.3,0)
    }
}
