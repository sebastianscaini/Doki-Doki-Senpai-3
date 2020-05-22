class Cutscene {
  String filename;
  DialogueBox dialogueBox;
  int textIndex = 0;
  boolean loaded = false;
  PImage background;

  PImage MCChanPortrait = loadImage("images/portraits/MCPortrait.png"), senpaiPortrait = loadImage("images/portraits/senpaiPortrait.png"), villainPortrait = loadImage("images/portraits/villainPortrait.png");

  String[] cutscene1Text = {"Senpai: MC-chan, I love you…", "MC-chan: Barney-senpai...I…", "Senpai: Ssshhh...say no more...beep beep beep beep", "MC-chan: ...Senpai, I don’t understand…", "MC-chan: AHH, SHOOT! I’m late again! I’m going to get detention for sure this time!", "MC-chan jumps out of bed and rushes to the door.", "MC-chan: No time to eat! Ugh I'm starving.", "MC-chan: Starving for Barney-senpai.", "MC-chan: Ohhh, MC-chan you little minx.", "MC-chan exits her house.", "MC-chan: Why is there a big crowd of girls standing over there?", "MC-chan sees Barney-senpai.", "MC-chan: Is...that...is that the love of my life?", "MC-chan: IT IS.", "MC-chan: BARNEY-SENPAI, COME HERE!", "MC-chan: Maybe he didn’t hear me! I will go get him."};
  String[] cutscene2Text = {"MC-Chan is standing inside her classroom.", "MC-chan: I was so close to catching Senpai this morning. Why didn’t he wait for me?", "MC-chan: At least I made it to class on time. Only because he was there to motivate me! <3", "MC-chan: Man, am I hungry though.", "MC-chan: I can't wait to eat my melon bread!", "MC-chan sits at her desk and eats.", "MC-chan finishes eating then goes out into the hallway.", "She sees Barney-senpai and they make eye contact.", "Senpai: Please. No. Save me."};
  String[] cutscene3Text = {"MC-chan is in a locker room, preparing to go home.", "MC-chan: Aaahh I’m so pissed I didn’t get to see him at all today!", "MC-chan: I didn’t get to eat much today either! I’m starving for you, Barney-senpai!", "MC-chan: I wonder when we'll start planning our wedding date. I’m so excited!", "Villain-san: Hey you. You need to leave Barney-kun alone. Nothing personal, kid.", "MC-chan: Wait...What are you doing with Senpai! He’s mine, leave him alone!", "Villain-san: Actually, he already agreed to date me! Someone his own age.", "Villain-san: He doesn’t need a brat like you!", "MC-chan: Oh no you didn't!", "Villain-san: Tell you what, kid. If you can catch me in a reasonable time, I’ll let you have Senpai.", "Villain-san: But I’ll have you know I’m the number one track-star in senior year.", "MC-chan: You're on!", "Senpai: What happened to free will…"};
  String[] cutscene4Text = {"MC-chan: Take that!", "Villain-san: AAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHH", "Villain-san is defeated!", "MC-chan hold Barney-senpai.", "MC-chan: It’s okay now, Barney-senpai. I caught you now!", "Senpai: Why...", "MC-chan: I love you! You are my soul-mate.", "Senpai: Why...", "MC-chan: When are we getting married?", "Barney-senpai is unconcious."};

  Cutscene(PImage tempBackground, String tempFilename) {
    this.dialogueBox = new DialogueBox(0, 568, #F691FF);
    this.background = tempBackground;
    this.filename = tempFilename;
  }

  void display() {
    loadMusic();
    displayBackground();
    displayPortraits();
    dialogueBox.display();
    displayText();
  }

//load music
  void loadMusic() {
    if (!loaded) {
      music.pause();
      music = minim.loadFile(filename);
      music.loop();
      loaded = true;
    }
  }

//show text on correct scene
  void displayText() {
    if (sceneManager.scene == 1) {
      fill(0);
      textSize(24);
      text(cutscene1Text[textIndex], 200, 668);
    } else if (sceneManager.scene == 3) {
      fill(0);
      textSize(24);
      text(cutscene2Text[textIndex], 200, 668);
    } else if (sceneManager.scene == 5) {
      fill(0);
      textSize(24);
      text(cutscene3Text[textIndex], 200, 668);
    } else if (sceneManager.scene == 7) {
      fill(0);
      textSize(24);
      text(cutscene4Text[textIndex], 200, 668);
    }
  }

//change background and music mid-scene
  void transition() {
    if (sceneManager.scene == 3) {
      if (textIndex == 6) {
        background = loadImage("images/backgrounds/hallway.png");
      }
    }
    if (sceneManager.scene == 5) {
      if (textIndex == 4) {
        filename = "sound/dialogue3.mp3";
        loaded = false;
        background = loadImage("images/backgrounds/hallway.png");
      }
    }
  }

//on to the next scene!
  void cont() {
    sceneManager.scene++;
    sceneManager.rhythmGame.begun = true;
  }

//draw background
  void displayBackground() {
    image(background, 0, 0);
  }

//draw portraits on correct scenes at correct text
  void displayPortraits() {
    if (sceneManager.scene == 1) {
      image(MCChanPortrait, 20, 175);
      if (textIndex < 4 || textIndex > 10) {
        image(senpaiPortrait, 1000, 150);
      }
    }
    if (sceneManager.scene == 3) {
      image(MCChanPortrait, 20, 175);
      if (textIndex > 6) {
        image(senpaiPortrait, 1000, 150);
      }
    }
    if (sceneManager.scene == 5) {
      image(MCChanPortrait, 20, 175);
      if (textIndex > 3) {
        image(villainPortrait, 1000, 130);
      }
    }
    if (sceneManager.scene == 7) {
      image(MCChanPortrait, 20, 175);
      if (textIndex < 3) {
        image(villainPortrait, 1000, 130);
      }
      if (textIndex > 3) {
        image(senpaiPortrait, 1000, 150);
      }
    }
  }
}