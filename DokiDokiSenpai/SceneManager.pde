class SceneManager {
  //load scenes and other variables
  PImage transparentLogo = loadImage("images/transparentLogo.png");
  int scene = 0, reload, finalScore = 0;
  float creditY = 1500;
  boolean creditPlayed = false;
  Menu menu = new Menu();
  Cutscene scene1 = new Cutscene(loadImage("/images/backgrounds/house.png"), "sound/dialogue1.mp3");
  Cutscene scene2 = new Cutscene(loadImage("/images/backgrounds/classroom.png"), "sound/dialogue2.mp3");
  Cutscene scene3 = new Cutscene(loadImage("images/backgrounds/hallway.png"), "sound/dialogue2.mp3");
  Cutscene scene4 = new Cutscene(loadImage("images/backgrounds/hallway.png"), "sound/dialogue4.mp3");
  RunningScene runningScene = new RunningScene(loadImage("images/backgrounds/scrollingStreet.png"));
  RhythmGameplay rhythmGame = new RhythmGameplay();
  GameOver gameOver = new GameOver("sound/gameover.mp3");

  void run() {
    //switch scenes
    switch(scene) {
      //menu
    case 0:
      textAlign(CENTER);
      menu.display();
      break;

      //Cutscene 1
      case(1): 
      textAlign(LEFT);
      scene1.display();
      break;

      //Rhythm scene 1
      case(2):    
      reload = 2;
      runningScene.run();
      if (!runningScene.reset) {
        runningScene.reset();
      }
      rhythmGame.update();
      if (rhythmGame.begun) {
        rhythmGame.begin();
      }
      break;

      //cutscene 2
      case(3):
      textAlign(LEFT);
      scene2.display();
      break;

      //rhythm scene 2
      case(4):
      reload = 4;
      runningScene.run();
      if (!runningScene.reset) {
        runningScene.reset();
      }
      rhythmGame.update();
      if (rhythmGame.begun) {
        rhythmGame.begin();
      }
      break;

      //cutscene 3
      case(5):
      textAlign(LEFT);
      scene3.display();
      break;

      //rhythm scene 3
      case(6):
      reload = 6;
      runningScene.run();
      if (!runningScene.reset) {
        runningScene.reset();
      }
      rhythmGame.update();
      if (rhythmGame.begun) {
        rhythmGame.begin();
      }
      break;

      //cutscene 4
      case(7):
      textAlign(LEFT);
      scene4.display();
      break;

      //win scene
      case(8):
      updateCredits();
      drawCredits();
      break;

      //game over scene
      case(999):
      textAlign(CENTER);
      gameOver.run();
      break;
    }
  }

  //reset all scenes
  void reset() {
    scene1.textIndex = 0;
    scene2.textIndex = 0;
    scene3.textIndex = 0;
    scene4.textIndex = 0;
    menu.played = false;
    scene1.loaded = false;
    scene2.loaded = false;
    if (scene == 2) {
      runningScene = new RunningScene(loadImage("images/backgrounds/scrollingHallway.png"));
    }
    if (scene == 4) {
      runningScene = new RunningScene(loadImage("images/backgrounds/scrollingHallway.png"));
    }
    if (scene == 6) {
      runningScene = new RunningScene(loadImage("images/backgrounds/scrollingHallway.png"));
    }
    rhythmGame = new RhythmGameplay();
  }

  //move credits and play music
  void updateCredits() {
    if (!creditPlayed) {
      music.pause();
      music = minim.loadFile("sound/title.mp3"); //load audio file
      music.loop();
      creditPlayed = true;
    }
    creditY -= 2;
  }

  //credits that scroll
  void drawCredits() {
    textSize(48);
    fill(#F691FF);
    image(transparentLogo, 100, height/2 - 200);
    text("Final Score: " + finalScore, width/2, creditY - 550);
    text("Credits:", width/2, creditY);
    text("Programmed by:", width/2, creditY + 150);
    text("Sebastian Scaini", width/2, creditY + 200);
    text("Tianyao Liu", width/2, creditY + 250);
    text("Deja Smith", width/2, creditY + 300);
    text("Emily Bendevis", width/2, creditY + 350);
    text("Written by:", width/2, creditY + 450);
    text("Emily Bendevis", width/2, creditY + 500);
    text("Art and Animation by:", width/2, creditY + 600);
    text("Deja Smith", width/2, creditY + 650);
    text("Emily Bendevis", width/2, creditY + 700);
    text("Tianyao Liu", width/2, creditY + 750);
    text("Thank You for Playing!", width/2, creditY + 1050);

    if (creditY + 1050 <= - 210) {
      exit();
    }
  }
}