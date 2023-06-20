import QtQuick 2.0
import Felgo 3.0

AnimatedImage{

    id:coin
    width: 32
    height: 32

    source: "../../assets/img/gold.gif"
    visible: false

    function appear()
    {
        coin.visible=true
        rise.start()
    }


    // 定义金币顶起的动画
    SequentialAnimation{
        id:rise
        NumberAnimation {

          target: coin
          property: "y"
          from: coin.y
          to: coin.y - 60 // 金币向上移动的距离
          duration: 1000 // 动画时长
          easing.type: Easing.OutQuint // 缓动效果
          running: false // 默认不运行动画
     }
        PropertyAction{
          target: coin
          property: "visible"
          value: false
    }
  }
}
