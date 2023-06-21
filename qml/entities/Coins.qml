
import QtQuick 2.0
import Felgo 3.0
//这是一个金币包，里面有三个金币，可循环跳出,用于实现金币的连续顶出
Item {
    id: coins
    property int quantity

    property int circulate:3

    Coin{
        id:coin1
    }

    Coin{
        id:coin2
    }

    Coin{
        id:coin3
    }

    function coinsAppear(){

        if(circulate == 3){

            coin1.appear()


             }
        if(circulate == 2){

            coin2.appear()

            }
        if(circulate == 1){

            coin3.appear()

            circulate = 3 }
        }
    }










