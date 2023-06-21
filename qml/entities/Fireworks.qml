import QtQuick 2.0
import Felgo 3.0

AnimatedImage {

    id: fireworks
    source: "../../assets/img/img/explode.png"
    visible: false


    NumberAnimation {
        id:widthAnimation
        target: fireworks
        property: "width"
        duration: 1500
        easing.type: Easing.InOutQuad
        from: 0
        to: 30
    }

    SequentialAnimation{
        id: heightAnimation
        NumberAnimation {

           target: fireworks
           property: "height"
           duration: 1500
           easing.type: Easing.InOutQuad
           from: 0
           to: 30
        }
        PropertyAction{
            target: fireworks
            property: "visible"
            value: false

        }
    }
    function fireworksBang() {
            visible = true
            widthAnimation.start()
            heightAnimation.start()
        }


}
