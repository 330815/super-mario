import QtQuick 2.0
import Felgo 3.0

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

}
