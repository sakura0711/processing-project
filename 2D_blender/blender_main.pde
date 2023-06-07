// Cubes data
ArrayList<Cube> cubes = new ArrayList<Cube>();

// Button object
Button createButton, deleteButton;
Circle circle;

//recode cude index
int nowCubeIndex = 0;

// 
boolean isScaleEditor = false;
float OLDmouseX , OLDmouseY, 
      scaleValue, S_standardDistance, 
      tempCubeSize;

void setup() {
    //fullScreen();
    size(1000, 1000);

    // Create Button
    createButton = new Button(width/2, height-50, 100, 40, "Create Cube");
    deleteButton = new Button(width/3, height-50, 100, 40, "Delete Cube");
  
    // Create origin
    circle = new Circle(width/2, height/2, 20);
  
    // Draw methods
    rectMode(RADIUS);
}

void draw() {
    background(100);
  
    // origin display
    circle.display();

    // cubes display 
    for(int i = 0; i < cubes.size(); i++){ // ArrayList use .get(i) / dont use [i]
        // setColor (notSelected)
        color otherColor = color(255); // #white
        cubes.get(i).setFillcolor(otherColor);
        
        // setColor (Selected)
        if (i == nowCubeIndex) {
            color activeColor = color(255, 204, 0); // #yellow
            cubes.get(i).setFillcolor(activeColor);  
        }
        // display All cubes
        cubes.get(i).display();
    }

    if(isScaleEditor){
        strokeWeight(5);
        stroke(0,255,0);
        line(mouseX,mouseY,cubes.get(nowCubeIndex).x,cubes.get(nowCubeIndex).y);
        if(cubes.get(nowCubeIndex).size >= 10){
            
            // !! Scale Bug
            scaleValue = dist(OLDmouseX,OLDmouseY,mouseX,mouseY) / 4; //<>//
    
            // # Debug area  ==============================================
            print("<  ");
            //print("scaleValue: " + scaleValue);
            //print("  cubesSize: " + cubes.get(nowCubeIndex).size);
            //print(mouseX,mouseY);
            //print(cubes.get(nowCubeIndex).x);print(cubes.get(nowCubeIndex).y);
            print("  >");
            // # ==========================================================
            
            if(S_standardDistance <= dist(cubes.get(nowCubeIndex).x,cubes.get(nowCubeIndex).y,mouseX,mouseY)){
                cubes.get(nowCubeIndex).size = tempCubeSize + (scaleValue);  //<>//
            }
            else if(S_standardDistance > dist(cubes.get(nowCubeIndex).x,cubes.get(nowCubeIndex).y,mouseX,mouseY)){
                cubes.get(nowCubeIndex).size = max(10, tempCubeSize - (scaleValue));
            }
            
        }
        strokeWeight(0);
    }
    
    // Button display
    createButton.display();
    deleteButton.display();
}

// mouse down
void mousePressed() {

   // Select cude (mouse on cubes)
   for(int i = 0; i < cubes.size(); i++){
      // ArrayList use .get(i) / dont use [i]
      if (cubes.get(i).isMouseOver()) {
          cubes.get(i).lock();
          nowCubeIndex = i; // get Selected cude index
          //print("\nnowCubeIndex : " + nowCubeIndex);
      }
   }
  
    // Select origin (mouse on circle)
    if (circle.isMouseOver()) {
        circle.lock();
        nowCubeIndex = -1; // reset cube index
    }
  
    // Select createCube_btn
    if (createButton.isMouseOver()) {
        float cubeX = circle.x;
        float cubeY = circle.y - circle.radius - 40; // Cube spawn on origin
        createCube(50, color(255/*random(255), random(255), random(255)*/), cubeX, cubeY);
        nowCubeIndex = -1; // reset cube index
    }
  
    // Select deleteCube_btn 
    if(cubes.size() != 0 && nowCubeIndex != -1){
        if (deleteButton.isMouseOver()) {
            cubes.remove(nowCubeIndex); 
            nowCubeIndex = -1; // reset cube index
        }
    }
}

// mouse down & moving
void mouseDragged() {
    // Select (isLocked = true cube), and move to mouse position
    for (Cube cube : cubes) {
        if (cube.isLocked()) {
            cube.drag(mouseX, mouseY);
        }
    }
  
    // Select (isLocked = true circle), and move to mouse position
    if (circle.isLocked()) {
        circle.drag(mouseX, mouseY);
    }
}

// mouse up
void mouseReleased() {
    // Switch to Can't move (isLocked = false)
    for (Cube cube : cubes) {
        cube.unlock();
    }
    
    // Switch to Can't move (isLocked = false)
    circle.unlock();
}

// Create cubes
void createCube(float size, color fillColor, float posX, float posY) {
    Cube cube = new Cube(size, fillColor, posX, posY);
    cubes.add(cube);
}

void keyPressed() {
    if(cubes.size() != 0 && nowCubeIndex != -1){
        // control cube size
        if (key == '+' || key == '=') {
            cubes.get(nowCubeIndex).size += 10; 
        } else if (key == '-' || key == '_') {
            cubes.get(nowCubeIndex).size = max(10, cubes.get(nowCubeIndex).size - 10);
        }
        // control cube size(hotkey)
        if(key == 's' || key == 'S'){
            OLDmouseX = mouseX;
            OLDmouseY = mouseY;
            tempCubeSize = cubes.get(nowCubeIndex).size;
            S_standardDistance = dist(cubes.get(nowCubeIndex).x,cubes.get(nowCubeIndex).y,OLDmouseX,OLDmouseY);
            isScaleEditor = true;
        }
        
        // application all transfrom
        if(key == ENTER){
            isScaleEditor = false;
        }
        
        // Cancel all transfrom
        if(key == 'c'){
            isScaleEditor = false;
            cubes.get(nowCubeIndex).size = tempCubeSize;
        }
    }
}
