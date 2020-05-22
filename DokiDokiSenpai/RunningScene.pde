class RunningScene {
  PImage bg;
  int runningSceneNumber;
  float bgLocation = 0, bgInterval = 1366;
  boolean reset = false, reseterinod = true;
  scrollingBackground[] SBG;
  Player MCChan;
  Animation senpai = new Animation("images/sprites/senpai/Frame", 16, 1050, 350), villain = new Animation("images/sprites/villain/Frame", 12, 1000, 350);

  RunningScene(PImage tempBG) {
    this.bg = tempBG;
    MCChan = new Player(width/2, 450, 400, "images/sprites/MCChan/Frame");
    //make a scrolling background
    SBG = new scrollingBackground[2];
    for (int i = 0; i < SBG.length; i++) {
      SBG[i] = new scrollingBackground(bgLocation, 0, -7, 0, bg);
      bgLocation += bgInterval;
    }
  }

  void run() {
    if (!reset) {
      reset();
    }
    //move background
    for (int i = 0; i < SBG.length; i++) {
      SBG[i].update();
      SBG[i].display();
    }
    //display senpai
    if (sceneManager.scene == 2 || sceneManager.scene == 4) {
      senpai.display();
    }
    if (sceneManager.scene == 6) {
      villain.display();
    }
    //display player
    MCChan.display();
  }

  //reset player position
  void reset() {
    MCChan.health = width/2;
    reset = true;
  }
}