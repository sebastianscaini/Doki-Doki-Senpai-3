class scrollingBackground{
  
  float originalX;
  PVector position = new PVector(), velocity = new  PVector();
  PImage background;
  
  scrollingBackground(float tempPosX, float tempPosY, float tempVelX, float tempVelY, PImage tempBackground){
    this.position.x = tempPosX;
    this.position.y = tempPosY;
    this.velocity.x = tempVelX;
    this.velocity.y = tempVelY;
    this.background = tempBackground;
    this.originalX = 1360;
  }
  
  void update(){
    //move
    position.add(velocity);
    
    //reset position when offscreen
    if(position.x <= -1366){
      position.x = originalX;
    }
  }
  
  //display image
  void display(){
    image(background, position.x, position.y);
  }
}