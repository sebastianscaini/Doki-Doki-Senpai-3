/* Note class
 * Hit circles; enter from right side of screen, corresponding key can be pressed when within range
 */

class Note {
  float xPos; //x position
  float trackPos; //time position in track, in milliseconds
  int noteType; //store key (right = 1, down = 2, left = 3, up = 4)
  boolean active; //hit circle active?
  
  //constructor with parameters: note length in beats, key (right = 1, down = 2, left = 3, up = 4)
  Note(float d, int t) {
    noteType = t;
    trackPos = 3000+sceneManager.rhythmGame.trackBuild*60000/sceneManager.rhythmGame.bpm; //formula: sum of note lengths of hit circles before * 60000 (# of milliseconds in 1 minute) / beats per minute
    sceneManager.rhythmGame.trackBuild += d;
    active = true;
  }

  //update function
  void update() {
    //update x position; target circle is at x = 125, hit circles are offset by 50 pixels to compensate for audio delay
    xPos = 175+(trackPos-sceneManager.rhythmGame.currentTime)/2;
    //draw when onscreen
    if (xPos < 1416) {
      if (noteType == 1) {
        image(sceneManager.rhythmGame.right, xPos-45, 80);
      }
      if (noteType == 2) {
        image(sceneManager.rhythmGame.down, xPos-45, 80);
      }
      if (noteType == 3) {
        image(sceneManager.rhythmGame.left, xPos-45, 80);
      }
      if (noteType == 4) {
        image(sceneManager.rhythmGame.up, xPos-45, 80);
      }
    }
    //miss (moved too far past target circle); reset sceneManager.rhythmGame.multiplier to 1
    if (xPos < 5) {
      sceneManager.rhythmGame.hitAccuracy = 4;
      sceneManager.rhythmGame.noteNum += 1;
      sceneManager.rhythmGame.mult = 1;
      sceneManager.rhythmGame.missed = true;
      active = false; //deactivate hit circle
      sceneManager.runningScene.MCChan.decreaseHealth();
    }
  }
}