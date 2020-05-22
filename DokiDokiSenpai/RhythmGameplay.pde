class RhythmGameplay {

  boolean rhythmStart; //rhythm in progress?
  boolean musicStart;
  boolean missed; //missed a hit circle?
  int startTime; //time rhythm started in milliseconds
  int currentTime; //current program time
  int endTime; //time rhythm ends in milliseconds
  int input; //used to store key input
  int score; //total score, with multipliers
  int mult; //multiplier
  int hitAccuracy; //hit accuracy for accuracy display; 1=perfect, 2=good, 3=bad, 4=miss
  int noteNum; //position of hit circle within order
  float bpm; //beats per minute for track
  float trackBuild; //stores sum of note lengths of hit circles created during track building, to determine position of next hit circle
  ArrayList<Note> notes = new ArrayList<Note>(); //ArrayList of hit circle objects
  boolean begun;

  PImage right, down, left, up, target;

  RhythmGameplay() {
    //initializing variables
    rhythmStart = false;
    musicStart = false;
    startTime = 0;
    input = 0;
    score = 0;
    mult = 0;
    hitAccuracy = 0;
    trackBuild = 0;
    noteNum = 0;
    missed = false;
    begun = false;

    right = loadImage("images/Arrows/arrow1.png");
    down = loadImage("images/Arrows/arrow2.png");
    left = loadImage("images/Arrows/arrow3.png");
    up = loadImage("images/Arrows/arrow4.png");
    target = loadImage("images/Arrows/arrowtarget.png");
  }

  void update() {
    noStroke();
    fill(#F691FF, 200);
    rect(0, 25, 1366, 200);
    //target circle
    image(target, 80, 80);
    
    //during rhythm
    if (rhythmStart) {
      currentTime = (millis()-startTime);
      //countdown to track start
      if (!musicStart && currentTime >= 3000) {
        music.play();
        musicStart = true;
      }
      //update and draw active hit circles
      for (Note i : notes) {
        if (i.active) {
          i.update();
        }
      }
      //track end
      if (currentTime >= endTime) {
        end();
      }
    }
    
    //multiplier display
    textAlign(CENTER);
    fill(0);
    textSize(30);
    text("x"+mult, 125, 60);
    //score display
    textAlign(LEFT);
    text(score, 200, 60);
    //accuracy display
    textAlign(CENTER);
    textSize(20);
    if (hitAccuracy == 1) {
      fill(#00FFFF, 255);
      text("PERFECT", 125, 200);
    }
    if (hitAccuracy == 2) {
      fill(#00FF21, 255);
      text("GOOD", 125, 200);
    }
    if (hitAccuracy == 3) {
      fill(#4800FF, 255);
      text("BAD", 125, 200);
    }
    if (hitAccuracy == 4) {
      fill(#FF0000, 255);
      text("MISS", 125, 200);
    }
  }

  void checkInput() {
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == RIGHT) { //right arrow
          input = 1;
        } else if (keyCode == DOWN) { //down arrow
          input = 2;
        } else if (keyCode == LEFT) { //left arrow
          input = 3;
        } else if (keyCode == UP) { //up arrow
          input = 4;
        } else {
          input = 0;
        }
      }
    }

    if (input > 0 && rhythmStart) {
      //if the current foremost hit circle is within hit range, register hit/miss; deactivate hit circle
      for (Note i : notes) {
        if (i.active) {
          if (abs(i.xPos - 125) < 30 && input == i.noteType) { //perfect hit; 300 base points, +1 multiplier
            score += 300*mult;
            hitAccuracy = 1;
            noteNum += 1;
            mult += 1;
            i.active = false; //deactivate hit circle
            sceneManager.runningScene.MCChan.increaseHealth();
          } else if (abs(i.xPos - 125) < 60 && input == i.noteType) { //good hit; 100 base points, +1 multiplier
            score += 100*mult;
            hitAccuracy = 2;
            noteNum += 1;
            mult += 1;
            i.active = false; //deactivate hit circle
            sceneManager.runningScene.MCChan.increaseHealth();
          } else if (abs(i.xPos - 125) < 90 && input == i.noteType) { //bad hit; 50 base points
            score += 50*mult;
            hitAccuracy = 3;
            noteNum += 1;
            i.active = false; //deactivate hit circle
          } else if (abs(i.xPos - 125) < 120) { //miss (too early, wrong key); reset multiplier to 1
            hitAccuracy = 4;
            noteNum += 1;
            mult = 1;
            missed = true;
            i.active = false; //deactivate hit circle
            sceneManager.runningScene.MCChan.decreaseHealth();
          }
          break;
        }
      }
    }
  }


void begin() {
  //begin rhythm upon key press
  if (!rhythmStart) {
    startTime = millis();
    //reset variables
    input = 0;
      mult = 1;
      hitAccuracy = 0;
      trackBuild = 0;
      noteNum = 0;
      missed = false;
    if (sceneManager.scene == 2) {
      track1(); //create track
    }
    if (sceneManager.scene == 4) {
      track2(); //create track
    }
    if (sceneManager.scene == 6) {
      track3();
    }
    rhythmStart = true;
    musicStart = false;
    begun = false;
  }
}

void end() {
  sceneManager.finalScore += score;
  rhythmStart = false;
  begun = true;
  sceneManager.runningScene.reset = false;
  sceneManager.reset();
  //notes.clear(); //delete all hit circle objects
  sceneManager.scene++;
}

//create track function; 1st track
void track1() {
  music.pause();
  music = minim.loadFile("sound/rhythm1.mp3"); //load audio file
  bpm = 150;

  //add hit circle objects with parameters: note length in beats, key (right = 1, down = 2, left = 3, up = 4)
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1.5, 2));

  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1.5, 2));

  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1.5, 2));

  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(6.5, 2));

  notes.add(new Note(0.5, 2));
  notes.add(new Note(3.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(3.5, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(2, 3));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(3, 3));

  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(3, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(1.5, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(2, 1));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(2.5, 4));

  notes.add(new Note(0.5, 2));
  notes.add(new Note(3, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(3.5, 2));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(3, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1.5, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(2, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 2));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1.5, 1));

  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(2, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(2, 3));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 1));

  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(2, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1.5, 1));

  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(2, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(2, 3));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 1));

  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(2, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1.5, 1));

  endTime = int(4000+trackBuild*60000/bpm);
}

//create track function; 2nd track
void track2() {
  music.pause();
  music = minim.loadFile("sound/rhythm2.mp3"); //load audio file
  bpm = 160;

  //add hit circle objects with parameters: note length in beats, key (right = 1, down = 2, left = 3, up = 4)
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(3, 2));

  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(4.5, 2));

  notes.add(new Note(1, 3));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.75, 3));
  notes.add(new Note(0.75, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.75, 4));
  notes.add(new Note(0.75, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.75, 1));
  notes.add(new Note(0.75, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.75, 2));
  notes.add(new Note(0.75, 2));
  notes.add(new Note(0.5, 2));

  notes.add(new Note(1, 1));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.75, 1));
  notes.add(new Note(0.75, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.75, 2));
  notes.add(new Note(0.75, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.75, 3));
  notes.add(new Note(0.75, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.75, 4));
  notes.add(new Note(0.75, 4));
  notes.add(new Note(0.5, 4));

  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(3, 2));

  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(2.5, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(2, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(2, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(2.5, 3));

  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(2, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(3, 4));

  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(3, 2));

  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(4.5, 2));

  notes.add(new Note(1, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1.5, 1));
  notes.add(new Note(1.5, 2));
  notes.add(new Note(2.5, 4));

  notes.add(new Note(1, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1.5, 3));
  notes.add(new Note(1.5, 2));
  notes.add(new Note(2.5, 4));

  notes.add(new Note(1, 1));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.75, 1));
  notes.add(new Note(0.75, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.75, 2));
  notes.add(new Note(0.75, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.75, 3));
  notes.add(new Note(0.75, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.75, 4));
  notes.add(new Note(0.75, 4));
  notes.add(new Note(0.5, 4));

  notes.add(new Note(1, 3));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.75, 3));
  notes.add(new Note(0.75, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.75, 4));
  notes.add(new Note(0.75, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.75, 1));
  notes.add(new Note(0.75, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.75, 2));
  notes.add(new Note(0.75, 2));
  notes.add(new Note(0.5, 2));

  notes.add(new Note(0.5, 4));

  endTime = int(4000+trackBuild*60000/bpm);
}

//create track function; 3rd track
void track3() {
  music.pause();
  music = minim.loadFile("sound/rhythm3.mp3"); //load audio file
  bpm = 168;

  //add hit circle objects with parameters: note length in beats, key (right = 1, down = 2, left = 3, up = 4)
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1.5, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(2.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(2.5, 3));
  notes.add(new Note(1.5, 1));
  notes.add(new Note(1.5, 4));

  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(3, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(3, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1.5, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1.5, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(3, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(3.5, 1));
  notes.add(new Note(1, 4));

  notes.add(new Note(1.5, 2));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 4));

  notes.add(new Note(1.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(2.5, 2));

  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 2));
  notes.add(new Note(1.5, 3));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(1.5, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(1.5, 3));

  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(1.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(2, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1.5, 2));

  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 4));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 3));
  notes.add(new Note(2, 1));

  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(2, 2));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1.5, 3));

  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 1));
  notes.add(new Note(2.5, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(3.5, 4));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(0.5, 4));

  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1.5, 3));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1.5, 4));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1.5, 3));

  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 2));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(2.5, 2));
  notes.add(new Note(3, 4));

  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1.5, 3));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(1.5, 2));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1.5, 3));

  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 2));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(0.5, 1));
  notes.add(new Note(0.5, 3));
  notes.add(new Note(1, 3));
  notes.add(new Note(0.5, 4));
  notes.add(new Note(2.5, 4));
  notes.add(new Note(4.5, 2));
  notes.add(new Note(0.5, 4));

  endTime = int(4000+trackBuild*60000/bpm);
}
}