import peasy .*;
PeasyCam cam;
PImage backgroundImage;
Block block,block2, block3;

ArrayList<Block> blocks = new ArrayList<Block>();

void setup(){
    size(900,1000,P3D);
    smooth(4);
    
    // # PeasyCam Setting
    cam = new PeasyCam(this, width/2, 200, 0, 300);
    //cam.setPitchRotationMode();
    cam.setActive(false); //false to make this camera stop responding to mouse
    cam.rotateX(-100);
    
    for(int i = 0; i < 5 ; i++){
        createBlock(width/2 +  0,height/2 -100,-1500,70,50,30);
    } 
    
    backgroundImage = loadImage("background.png");
}

int score = 0,
    MAXscore = 1000;
int combo = 0;
int health = 1000;
boolean GameState = false;
boolean GameInit = true;

boolean ClickmidlleTRACK = false, 
        ClickleftTRACK   = false, 
        ClickrightTRACK  = false;
int     ClickTrackIndex  = -1; // default = noen
 

String judgeString = ""; 
color judgeColor = color(255,255,255);

boolean box2Delay = false,
        box3Delay = false,
        box4Delay = false,
        box5Delay = false;

void draw(){
    background(backgroundImage);

    strokeWeight(5);
    stroke(255,0,0);
    line(0,0,0,200,0,0); // x
    stroke(0,255,0);
    line(0,0,0,0,1000,0); // y
    stroke(0,0,255);
    line(0,0,0,0,0,-200); // z
    
    if(health > 0 && GameState && score < MAXscore)
    {
        strokeWeight(10);
        stroke(138, 242, 187);
        line(-100,440,0,1000,440,0); // jugde Line
        
        /* # Start Drawing Support line ================== */
            // left to right
            strokeWeight(3);
            line(width/2 - 115,440,0, width/2 - 115,440,-1700);
            line(width/2 -  40,440,0, width/2 -  40,440,-1700);
            line(width/2 +  40,440,0, width/2 +  40,440,-1700);
            line(width/2 + 115,440,0, width/2 + 115,440,-1700);
            
            line(width/2 - 115,440, -1700, width/2 + 115,440,-1700);
            
            textAlign(CENTER, CENTER);
            textSize(60);
            fill(0,200,190);
            text("G",  width/2 - 150, height - 150, -500); 
            text("H",  width/2 +  0, height - 150, -500); 
            text("J",  width/2 + 150, height - 150, -500); 
            
        /* ============================================== */
     
        
        /* # Start Drawing PeasyCam 2D GUI ================== */
        cam.beginHUD();
            textAlign(LEFT, CENTER);
            
            // Score text
            fill(0, 408, 612);
            textSize(30);
            text("score: " + score,  50, 100);
            
            // combe text
            textSize(30);
            fill(163, 255, 82);
            text("combo: " + combo,  50, 150);
            
            // health text
            textSize(30);
            fill(163, 255, 82);
            text("health: " + health,  50, 200);
           
            // judge text
            textAlign(CENTER, CENTER);
            textSize(50);
            fill(judgeColor);
            text(judgeString,  width/2, height - 150); 
            
        cam.endHUD();
        /* # End Drawing PeasyCam 2D GUI ================== */

        blocks.get(0).Update(ClickTrackIndex);
        
        if(blocks.get(0)._stepCount == -1200) { box2Delay = true; }
        if(blocks.get(0)._stepCount == -1000) { box3Delay = true; }
        if(blocks.get(0)._stepCount ==  -800) { box4Delay = true; }
        if(blocks.get(0)._stepCount ==  -500) { box5Delay = true; }
        
        if(box2Delay) {blocks.get(1).Update(ClickTrackIndex);}
        if(box3Delay) {blocks.get(2).Update(ClickTrackIndex);}
        if(box4Delay) {blocks.get(3).Update(ClickTrackIndex);}
        if(box5Delay) {blocks.get(4).Update(ClickTrackIndex);} 
    }
    else if(score > MAXscore){
        GameState = false;
        textAlign(CENTER, CENTER);
        textSize(60);
        fill(0,255,20);
        text("Your a Good!",  width/2, height/2 - 200, -800); 
        text("press \"R\" to Reset",  width/2, height/2, -700); 
    }
    else if(GameInit) {
        textAlign(CENTER, CENTER);
        textSize(60);
        fill(0,255,20);
        text("Start Game",  width/2, height/2 - 200, -800); 
        text("press \"S\" to Start",  width/2, height/2, -700); 
    }
    else
    {
        GameState = false;
        textAlign(CENTER, CENTER);
        textSize(60);
        fill(255,0,0);
        text("Your a fucking failure!",  width/2, height/2 - 200, -800); 
        text("press \"R\" to Reset your garbage life",  width/2, height/2, -700); 
    }
    
}

// Create blocks and add to ArrayList
void createBlock(float posX, float posY, float posZ, int sizeX, int sizeY, int sizeZ) {
    Block block = new Block( posX, posY, posZ, sizeX, sizeY, sizeZ);
    blocks.add(block); 
}

void keyPressed(){
    if(key == 'g' || key == 'G'){
        ClickleftTRACK = true;
        ClickTrackIndex = 0;
    }
    if(key == 'h' || key == 'H'){
        ClickmidlleTRACK = true;
        ClickTrackIndex = 1;
    }
    if(key == 'j' || key == 'J'){
        ClickrightTRACK = true;
        ClickTrackIndex = 2;
    }
    
    // Start Game 
    if(key == 's' || key == 'S'){
        if(GameInit){
            GameState = true;
            GameInit = false;
        }
    }
    
    // Reset Game
    if(key == 'r' || key == 'R'){
       if(!GameState)
       {    
           score = 0;
           combo = 0;
           health = 1000;
           GameState = true;
           
           for (Block block : blocks) {
                block._stepCount = block._stepMin;
           }
           
           box2Delay = false;
           box3Delay = false;
           box4Delay = false;
       }
    }
}
