class Cube {
  float x;
  float y;
  float size;
  color fillColor;
  boolean overBox;
  boolean locked;
  float xOffset;
  float yOffset;
  
  
  Cube(float size, color fillColor, float posX, float posY) {
    this.size = size;
    this.fillColor = fillColor;
    x = posX;
    y = posY;
  }
  
  void display() {
    // Checks if the mouse is on a block
    if (isMouseOver()) {
      overBox = true;
      if (!locked) {
        stroke(255);
        fill(255,0,0);
      }
    } else {
      stroke(153);
      fill(fillColor);
      overBox = false;
    }
    
    // Drawing cube
    rect(x, y, size, size);
  }
  
  boolean isMouseOver() {
    return (mouseX > x - size && mouseX < x + size &&
            mouseY > y - size && mouseY < y + size);
  }
  
  void lock() {
    locked = true;
    fill(255,0,0);
    xOffset = mouseX - x;
    yOffset = mouseY - y;
  }
  
  void unlock() {
    locked = false;
  }
  
  boolean isLocked() {
    return locked;
  }
  
  void drag(float mouseX, float mouseY) {
    fill(0);
    x = mouseX - xOffset;
    y = mouseY - yOffset;
  }
  
  void setFillcolor(color _fillcolor){
    this.fillColor = _fillcolor;
  }
  
  
}
