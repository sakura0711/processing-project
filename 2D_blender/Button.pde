class Button {
  float x;
  float y;
  float width;
  float height;
  String label;
  
  Button(float x, float y, float width, float height, String label) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
  }
  
  void display() {
    // 檢查滑鼠是否在按鈕上
    if (isMouseOver()) {
      fill(200);
    } else {
      fill(255);
    }
    
    // 繪製按鈕外框
    rectMode(CENTER);
    rect(x, y, width, height);
      rectMode(RADIUS);
    
    // 繪製按鈕文字
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(16);
    text(label, x, y);
  }
  
  boolean isMouseOver() {
    return (mouseX > x - width/2 && mouseX < x + width/2 &&
            mouseY > y - height/2 && mouseY < y + height/2);
  }
}
