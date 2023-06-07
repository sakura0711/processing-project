// Cubes data
ArrayList<Cube> cubes = new ArrayList<Cube>();

// Button object
Button createButton, deleteButton;

// Origin object 
Circle circle;

// Record cudeIndex
int nowCubeIndex = 0;

void setup() {
    //fullScreen();
    size(1000, 800);

    // 創建按鈕和圓形
    createButton = new Button(width/2, height-50, 100, 40, "Create Cube");
    deleteButton = new Button(width/3, height-50, 100, 40, "Delete Cube");
  
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
  deleteButton.display();
  
   
  
}


void mouseClicked(){
  
  //for (int i = cubes.size() - 1; i >= 0; i--) {
  //    Cube cube = cubes.get(i);
  //    if (cube.isMouseOver()) {
    //      cubes.remove(i); // 從列表中刪除方塊
  //    }
  //  }
}

void mousePressed() {
  // 檢查滑鼠點擊是否在方塊上
  if(!createButton.isMouseOver()) {
  for (Cube cube : cubes) {
    if (cube.isMouseOver()) {
        cube.lock();
      }
    }
  }
  
 for(int i = 0; i < cubes.size(); i++){
   // ArrayList use .get(i) / dont use [i]
    if (cubes.get(i).isMouseOver()) {
        cubes.get(i).lock();
        nowCubeIndex = i;
        print(nowCubeIndex);
    }
}
  
  // 檢查滑鼠點擊是否在圓形上
  if (circle.isMouseOver()) {
    circle.lock();
    nowCubeIndex = -1;
  }
  
  // 檢查滑鼠點擊是否在按鈕上
  if (createButton.isMouseOver()) {
    float cubeX = circle.x;
    float cubeY = circle.y - circle.radius - 40; // 在圓形上方生成方塊
    createCube(50, color(255/*random(255), random(255), random(255)*/), cubeX, cubeY);
    nowCubeIndex = -1;
  }
  
   if(cubes.size() != 0 && nowCubeIndex != -1){
     if (deleteButton.isMouseOver()) {
       cubes.remove(nowCubeIndex); // 從列表中刪除方塊
       nowCubeIndex = -1;
     }
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
