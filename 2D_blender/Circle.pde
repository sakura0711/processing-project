class Circle {
  float x;
  float y;
  float radius;
  boolean overCircle;
  boolean locked;
  float xOffset;
  float yOffset;
  
  Circle(float x, float y, float radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
  }
  
  void display() {
    // Checks if the mouse is on a circle
    if (isMouseOver()) {
      overCircle = true;
      if (!locked) {
        fill(79, 255, 232);
      }
    } else {
      overCircle = false;
      fill(79, 255, 232);
    }
    
    // Drawing circle
    ellipse(x, y, radius * 2, radius * 2);
    //triangle(100, 100, 70,  130,130,  130);
    fill(255,0,0);
  }
  
  boolean isMouseOver() {
    //calculate two position lenght 
    return dist(mouseX, mouseY, x, y) < radius;
  }
  
  void lock() {
    locked = true;
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
    x = mouseX - xOffset;
    y = mouseY - yOffset;
  }
}
