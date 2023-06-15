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

    function handleMusic() {
        audioManager.startMusic(bgMusic)
    }

    function startMusic(music) {
      // if music is already playing, we don't have to do anything
      if(music.playing)
        return

      // otherwise stop all music tracks
      bgMusic.stop()

      // play the music
      music.play()
    }

}
