ArrayList<Cube> cubes = new ArrayList<Cube>();
Button createButton;

void setup() {
  //size(640, 360);
  fullScreen();
  
  // 創建按鈕
  createButton = new Button(width/2, height-50, 100, 40, "Create Cube");
  rectMode(RADIUS);
}

void draw() {
  background(0);
  
  // 繪製所有方塊
  for (Cube cube : cubes) {
    cube.display();
  }
  
  // 繪製按鈕
  createButton.display();
}

void mousePressed() {
  rectMode(RADIUS);
  // 檢查滑鼠點擊是否在方塊上
  for (Cube cube : cubes) {
    if (cube.isMouseOver()) {
      cube.lock();
    }
  }
  
  // 檢查滑鼠點擊是否在按鈕上
  if (createButton.isMouseOver()) {
    createCube(50, color(random(255), random(255), random(255)), 50, 50);
    
  }
}

void mouseDragged() {
  // 拖動被鎖定的方塊
  for (Cube cube : cubes) {
    if (cube.isLocked()) {
      cube.drag(mouseX, mouseY);
    }
  }
}

void mouseReleased() {
  // 
  for (Cube cube : cubes) {
    cube.unlock();
  }
}

// create Cube
void createCube(float size, color fillColor, float posX, float posY) {
  Cube cube = new Cube(size, fillColor, posX, posY);
  rectMode(RADIUS);
  cubes.add(cube);
}
