 class DialogueBox{
  
  PVector position = new PVector();
  color colour;
  DialogueBox(float tempX, float tempY, color tempColour){
    this.position.x = tempX;
    this.position.y = tempY;
    this.colour = tempColour;
  }
  
  //display dialogue box
  void display(){
    noStroke();
    fill(colour, 200);
    rect(position.x, position.y + 40, width, 200, 50);
  }
}