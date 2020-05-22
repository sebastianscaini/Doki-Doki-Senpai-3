import ddf.minim.*;
SceneManager sceneManager;

Minim minim; //Minim object
AudioPlayer music; //AudioPlayer object for music

boolean dancePad = false;

void setup() {
  surface.setIcon(loadImage("images/transparentLogo.png"));
  surface.setTitle("Doki-Doki Senpai <3");
  size(1366, 768);
  frameRate(60);
  sceneManager = new SceneManager();
  minim = new Minim(this);
}

void draw() {
  background(0);
  sceneManager.run();
}

void mousePressed() {
  if (sceneManager.scene == 0 && mouseX >= 250 && mouseX <= 300 && mouseY >= 700 && mouseY <= 750) {
    if (dancePad) {
      dancePad = false;
    } else {
      dancePad = true;
    }
  }
  if (sceneManager.scene == 0 && mouseX >= 0 && mouseX <= 500 && mouseY >= 0 && mouseY <= 100) {
    link("https://docs.google.com/document/d/14q_6xFjq-Cq5XdoL1FHoCzE4b66bzrmpavGHs2P5tVo/edit?usp=sharing");
  }
}

//inputs
void keyPressed() {
  if (sceneManager.scene == 2 || sceneManager.scene == 4 || sceneManager.scene == 6) {
    sceneManager.rhythmGame.checkInput();
  }
  if (sceneManager.scene == 1) {
    if (sceneManager.scene1.textIndex < sceneManager.scene1.cutscene1Text.length - 1) {
      sceneManager.scene1.textIndex++;
      sceneManager.scene1.transition();
    } else {
      sceneManager.scene1.cont();
    }
  }
  if (sceneManager.scene == 3) {
    if (sceneManager.scene2.textIndex < sceneManager.scene2.cutscene2Text.length - 1) {
      sceneManager.scene2.textIndex++;
      sceneManager.scene2.transition();
    } else {
      sceneManager.scene2.cont();
    }
  }
  if (sceneManager.scene == 5) {
    if (sceneManager.scene3.textIndex < sceneManager.scene3.cutscene3Text.length - 1) {
      sceneManager.scene3.textIndex++;
      sceneManager.scene3.transition();
    } else {
      sceneManager.scene3.cont();
    }
  }
  if (sceneManager.scene == 7) {
    if (sceneManager.scene4.textIndex < sceneManager.scene4.cutscene4Text.length - 1) {
      sceneManager.scene4.textIndex++;
      sceneManager.scene4.transition();
    } else {
      sceneManager.scene4.cont();
    }
  }
}
