import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.0

Item {

    id: audioManager

    Component.onCompleted: handleMusic()     // 实例化后播放音乐

    //背景音乐
    BackgroundMusic {
        id: bgMusic

        autoPlay: true

        source: "../../assets/Themes/Overworld.mp3"

    }
    //跳跃音效
    SoundEffect {
        id: marioJump
        source: "../../assets/Sounds/Jump Small.wav"
    }

    function handleMusic() {
        console.log(222222)
        if(activeScene === gameScene) {
            startMusic(bgMusic)
            console.log(bgMusic.source)
        }
    }

    function startMusic(music) {
        // if music is already playing, we don't have to do anything

        if(music.playing)
            return

        // otherwise stop all music tracks
        bgMusic.stop()

        // play the music
        music.play()
        console.log(1111111111111)
    }

    function playSound(sound) {
        if(sound === "marioJump"){
            marioJump.play()
        }
    }
}
