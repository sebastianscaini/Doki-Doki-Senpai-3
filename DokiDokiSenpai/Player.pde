class Player {

  PVector position = new PVector();
  float health;
  int previous;
  String filename;
  boolean dead;
  Animation sprite;

  Player(float tempX, float tempY, float tempHP, String tempFilename) {
    this.position.x = tempX;
    this.position.y = tempY;
    this.health = tempHP;
    this.filename = tempFilename;
    this.dead = false;
    sprite = new Animation(filename, 16, position.x, position.y);
  }

  void display() {
    move();
    checkDead();
    sprite.display();
  }

  //check if the player is dead
  void checkDead() {
    if (sprite.position.x <= -100) {
      previous = sceneManager.scene;
      sceneManager.scene = 999;
    }
    //limit the position of the player
    if (health >= 900) {
      health = 900;
    }
  }

  //increase player health
  void increaseHealth() {
    if (dancePad) {
      health += 25;
    } else {
      health += 10;
    }
  }

  //decrease player health
  void decreaseHealth() {
    if (dancePad) {
      health -= 10;
    } else {
      health -= 50;
    }
  }

  //move player when health increases or decreases
  void move() {
    position.x = health;
    if (sprite.position.x <= position.x) {
      sprite.position.x += 2;
    }
    if (sprite.position.x >= position.x) {
      sprite.position.x -= 5;
    }
  }
}