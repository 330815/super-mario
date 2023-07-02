import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.0

Item {

    id: audioManager

    //Component.onCompleted: {handleMusic() }    // 实例化后播放音乐


    //背景音乐
    BackgroundMusic {
        id: menuMusic

        autoPlay: false

        source: "../../assets/Themes/startscene.mp3"

    }
    BackgroundMusic {
        id: level1Music

        autoPlay: false

        source: "../../assets/Themes/overworld.mp3"

    }

    BackgroundMusic {
        id: level2Music

        autoPlay: false

        source: "../../assets/Themes/underworld.mp3"

    }
    //跳跃音效
    SoundEffect {
        id: marioJump
        source: "../../assets/Sounds/Jump Small.wav"
    }
    //吃金币
    SoundEffect {
        id: getCoin
        source: "../../assets/Sounds/Coin.wav"
    }
    //马里奥死亡
    SoundEffect {
        id: marioDies
        source: "../../assets/Sounds/Mario Dies.wav"
    }

    function handleMusic() {
        if(gameWindow.state ==="start"){
            startMusic(menuMusic)

        }else if(gameWindow.state ==="game"){
            if(gameScene.activeLevelString==="Level1"){
                startMusic(level1Music)

            }else if(gameScene.activeLevelString==="Level2"){
                startMusic(level2Music)
            }
        }
    }

    function startMusic(music) {

        // if music is already playing, we don't have to do anything
        if(music.playing)
          return

        // otherwise stop all music tracks
        menuMusic.stop()
        level1Music.stop()
        level2Music.stop()

        // play the music
        music.play()

    }

    function playSound(sound) {
        if(sound === "marioJump"){
            marioJump.play()
        }else if(sound === "getCoin"){
            getCoin.play()
        }else if(sound === "marioDies"){
            marioDies.play()
        }
    }
}
