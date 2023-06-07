ArrayList<Cube> cubes = new ArrayList<Cube>();
Button createButton;
Circle circle;

void setup() {
  //size(640, 360);
  fullScreen();
  
  // 創建按鈕和圓形
  createButton = new Button(width/2, height-50, 100, 40, "Create Cube");
  circle = new Circle(width/2, height/2, 20);
  
  rectMode(RADIUS);
}

void draw() {
  background(100);
  
  // 繪製圓形
  circle.display();
  
  // 繪製所有方塊
  for (Cube cube : cubes) {
    cube.display();
  }
  
  // 繪製按鈕
  createButton.display();
}
void mouseClicked(){

for (int i = cubes.size() - 1; i >= 0; i--) {
    Cube cube = cubes.get(i);
    if (cube.isMouseOver()) {
      cubes.remove(i); // 從列表中刪除方塊
    }
  }
}

void mousePressed() {
  // 檢查滑鼠點擊是否在方塊上
  for (Cube cube : cubes) {
    if (cube.isMouseOver()) {
      cube.lock();
    }
  }
  
  // 檢查滑鼠點擊是否在圓形上
  if (circle.isMouseOver()) {
    circle.lock();
  }
  
  // 檢查滑鼠點擊是否在按鈕上
  if (createButton.isMouseOver()) {
    float cubeX = circle.x;
    float cubeY = circle.y - circle.radius - 40; // 在圓形上方生成方塊
    createCube(50, color(255/*random(255), random(255), random(255)*/), cubeX, cubeY);
  }
}

void mouseDragged() {
  // 拖動被鎖定的方塊
  for (Cube cube : cubes) {
    if (cube.isLocked()) {
      cube.drag(mouseX, mouseY);
    }
  }
  
   // 拖動被鎖定的圓形
  if (circle.isLocked()) {
    circle.drag(mouseX, mouseY);
  }
}

void mouseReleased() {
  // 解鎖所有方塊
  for (Cube cube : cubes) {
    cube.unlock();
  }
  
   // 解鎖圓形
  circle.unlock();
}

// 創建方塊的函數
void createCube(float size, color fillColor, float posX, float posY) {
  Cube cube = new Cube(size, fillColor, posX, posY);
  cubes.add(cube);
}
