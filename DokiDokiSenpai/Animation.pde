//based off of https://processing.org/examples/animatedsprite.html

class Animation{
  PImage[] images;
  int imageCount, frame;
  PVector position = new PVector();
  
  Animation(String image, int tempImageCount, float tempPosX, float tempPosY){
    this.imageCount = tempImageCount;
    images = new PImage[imageCount];
    
    this.position.x = tempPosX;
    this.position.y = tempPosY;
    
    //load images into an array
    for(int i = 0; i < imageCount; i++){
      String filename = image + nf(i, 8) + ".png";
      images[i] = loadImage(filename);
    }
  }
  
  //play animation
  void display(){
    frame = (frame + 1) % imageCount;
    image(images[frame], position.x, position.y);
  }
}