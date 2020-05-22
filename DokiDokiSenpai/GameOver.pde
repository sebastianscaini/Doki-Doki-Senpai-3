class GameOver {

  Animation cry = new Animation("images/sprites/gameover/frame", 6, width/2 - 50, 384);
  String musicFilename;
  boolean played = false;
  GameOver(String tempMusicFilename) {
    this.musicFilename = tempMusicFilename;
  }

  void run() {
    playMusic();
    display();
    if (!music.isPlaying()) {
      exit();
    }
  }

  //play music
  void playMusic() {
    if (!played) {
      music.pause();
      music = minim.loadFile("sound/gameover.mp3"); //load audio file
      music.play();
      played = true;
    }
  }

  //show game over screen
  void display() {
    cry.display();
    fill(255);
    textSize(48);
    text("Game Over!", width/2, 300);
  }
}