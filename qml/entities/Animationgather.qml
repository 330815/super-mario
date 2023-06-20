import QtQuick 2.0

Item {
    id:ani
    // 定义mushroom顶起的动画
    SequentialAnimation{
        id:rise
        NumberAnimation {

           target: mushRoom1
           property: "y"
           from: mushRoom1.y+20
           to: mushRoom1.y-15 // 向上移动的距离
           duration: 350 // 动画时长
           easing.type: Easing.OutQuint // 缓动效果


     }
}
   //定义mushroom被撞后下落的动画
    SequentialAnimation{
        id:drop2
        NumberAnimation{
            target: mushRoom1
            property: "y"
            from:mushRoom1.y
            to:mushRoom1.y-20
            duration: 100


        }
        NumberAnimation{
            target: mushRoom1
            property: "y"
            from:mushRoom1.y-20
            to:mushRoom1.y+100
            duration: 400


        }
    }

}
