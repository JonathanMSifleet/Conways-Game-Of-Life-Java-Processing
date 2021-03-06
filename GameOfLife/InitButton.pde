class InitButton {

  public color buttonColour;
  private int x = width/4;
  private int y = 10;

  InitButton() {
  }

  public void render(color initButtonColour) {
    stroke(0);
    fill(initButtonColour);
    rect(this.x, 10, width/2, 15);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Click to finish cell selection", width/2, this.y+5);
  }

  public boolean detectMouse() {

    //detect if mouse is inside the button
    if (mouseX >= this.x &&         // right of the left edge AND
      mouseX <= this.x + width/2 &&    // left of the right edge AND
      mouseY >= this.y &&         // below the top AND
      mouseY <= this.y + 15) {    // above the bottom
      return true;
    } else {
      return false;
    }
  }
}
