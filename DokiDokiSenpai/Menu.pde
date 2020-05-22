class Menu {
  PImage logo;
  boolean played = false;
  Menu() {
    this.logo = loadImage("images/logo.png");
  }

  void display() {
    playMusic();
    drawLogo();
    dancePadBox();
    drawText();
  }

  void playMusic() {
    //play music
    if (!played) {
      music = minim.loadFile("sound/title.mp3"); //load audio file
      music.loop();
      played = true;
    }
  }

  void drawLogo() {
    //load logo
    image(logo, 0, 0);
  }

  void drawText() {
    //draw text
    fill(0);
    textSize(32);
    text("Press any Key to Start", width/2, height/2 + 100);
    if (keyPressed) {
      //change scene here to load into different scenes
      sceneManager.scene = 1;
    }
  }

//show checkbox for dance pad
  void dancePadBox() {
    String danceToggle;
    int red = 255, green = 0;
    if (dancePad) {
      red = 0;
      green = 255;
      danceToggle = "Disable Dance Pad";
    } else {
      red = 255;
      green = 0;
      danceToggle = "Enable Dance Pad";
    }
    noStroke();
    fill(red, green, 0);
    rect(250, 700, 50, 50); 

    fill(0);
    textSize(24);
    text(danceToggle, 125, 735);
    
  fill(0);
  textSize(24);
  text("Click here for Dance Pad setup.", 200, 50);
  } 
}