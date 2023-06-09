// PeasyCam (PeasyCam library)
import peasy .*;
PeasyCam cam;

// play SoundFile (sound library)
import processing.sound.*;
SoundFile tickSound, BGM;

PImage backgroundImage;

ArrayList<Block> blocks = new ArrayList<Block>();

void setup(){
    size(900,1000,P3D);
    smooth(4);

    // # PeasyCam Setting
    cam = new PeasyCam(this, width/2, 200, 0, 300);
    //cam.setPitchRotationMode();
    cam.setActive(false); //false to make this camera stop responding to mouse
    cam.rotateX(-100);
    
    
    // # createBlock List
    for(int i = 0; i < 6 ; i++){
        createBlock(width/2 +  0,height/2 -100,-1500,70,100,30);
    } 
    
    // # import assets
    backgroundImage = loadImage("background.png");
    tickSound = new SoundFile(this, "tickSound2.mp3");
    BGM = new SoundFile(this, "BGM.mp3");
    BGM.play();
}

int score = 0,
    MAXscore = 4000;
int combo = 0;
int health = 1500;
int stepMagnification = 10; // init speed
int difficulty = 3;

boolean GameState = false;
boolean GameInit = true;
boolean isRotateR = true,
        isRotateM = true,
        isRotateL = true;

boolean Clickleft2TRACK  = false,
        ClickleftTRACK   = false, 
        ClickmidlleTRACK = false, 
        ClickrightTRACK  = false,
        Clickright2TRACK = false;
int     ClickTrackIndex  = -1; // default = noen
 

String judgeString = ""; 
color judgeColor = color(255,255,255);

//boolean box2Delay = false,
//        box3Delay = false,
//        box4Delay = false,
//        box5Delay = false,
//        box6Delay = false;

int     DelayCount = 0;
 
void draw(){
    background(backgroundImage);

    strokeWeight(5);
    stroke(255,0,0);
    line(0,0,0,200,0,0); // x
    stroke(0,255,0);
    line(0,0,0,0,1000,0); // y
    stroke(0,0,255);
    line(0,0,0,0,0,-200); // z
    
    // fast fast ~!!
    if(score > 1000 && score < 2000){stepMagnification = 20; }
    if(score > 2000){stepMagnification = 30; }
    

    int countRotate = 0;
    for (int i = 0;i < MAXscore; i++){
        
    }
    
    if((score < 200 && score > 100) && isRotateR){cam.rotateZ(-100); isRotateR = false;}
    if((score < 300 && score > 200) && isRotateM){cam.rotateZ(+100); isRotateM = false;}
    if((score < 400 && score > 500) && isRotateL){cam.rotateZ(+100); isRotateL = false;}
    
    //if(score > 400 && !isRotateR){isRotateR = true;}
    //if(score > 500 && !isRotateM){isRotateM = true;}
    //if(score > 600 && !isRotateL){isRotateL = true;}
    
    //else if(score > 400){cam.rotateZ(0);}
    //if(score % 301 == 0){cam.rotateZ(+100);}
   
    if(health > 0 && GameState && score < MAXscore)
    {
        strokeWeight(10);
        stroke(138, 242, 187);
        line(-100,440,0,1000,440,0); // jugde Line
        
        /* # Start Drawing Support line ================== */
            // left to right
            strokeWeight(3);
            line(width/2 - 190,440,0, width/2 - 190,440,-1700);
            line(width/2 - 115,440,0, width/2 - 115,440,-1700);
            line(width/2 -  40,440,0, width/2 -  40,440,-1700);
            line(width/2 +  40,440,0, width/2 +  40,440,-1700);
            line(width/2 + 115,440,0, width/2 + 115,440,-1700);
            line(width/2 + 190,440,0, width/2 + 190,440,-1700);
            
            line(width/2 - 190,440, -1700, width/2 + 190,440,-1700);
            
            textAlign(CENTER, CENTER);
            textSize(70);
            fill(0,200,190);
            text("F",  width/2 - 300, height - 150, -500); 
            text("G",  width/2 - 150, height - 150, -500); 
            text("H",  width/2 +  0, height - 150, -500); 
            text("J",  width/2 + 150, height - 150, -500); 
            text("K",  width/2 + 300, height - 150, -500);
            
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
        
        DelayCount++;
        //for(Block block:blocks){
        //    if()
        //}
        if(DelayCount ==   30) { blocks.get(1)._boxDelay = true; }
        if(DelayCount ==   50) { blocks.get(2)._boxDelay = true; }
        if(DelayCount ==   70) { blocks.get(3)._boxDelay = true; }
        if(DelayCount ==  100) { blocks.get(4)._boxDelay = true; }
        if(DelayCount ==  120) { blocks.get(5)._boxDelay = true; }
        
        for(Block block:blocks){
            if(block._boxDelay){block.Update(ClickTrackIndex);}
        }
        //if(box2Delay) {blocks.get(1).Update(ClickTrackIndex);}
        //if(box3Delay) {blocks.get(2).Update(ClickTrackIndex);}
        //if(box4Delay) {blocks.get(3).Update(ClickTrackIndex);}
        //if(box5Delay) {blocks.get(4).Update(ClickTrackIndex);} 
        //if(box6Delay) {blocks.get(5).Update(ClickTrackIndex);}
    }
    else if(score > MAXscore){
        GameState = false;
        textAlign(CENTER, CENTER);
        textSize(60);
        fill(0,255,20);
        text("Your a Good!",  width/2, height/2 - 200, -800); 
        text("press \"R\" to Reset",  width/2, height/2, -700); 
        text("score: " + score,  width/2, height/2 + 200, -800);
    }
    else if(GameInit) {
        textAlign(CENTER, CENTER);
        textSize(60);
        fill(0,255,20);
        text("Start Game",  width/2, height/2 - 200, -800); 
        text("press \"S\" to Start",  width/2, height/2, -700); 
        text("score: " + score,  width/2, height/2 + 200, -800);
    }
    else
    {
        GameState = false;
        textAlign(CENTER, CENTER);
        textSize(60);
        fill(255,0,0);
        text("Your a fucking failure!",  width/2, height/2 - 200, -800); 
        text("press \"R\" to Reset your garbage life",  width/2, height/2, -700); 
        text("score: " + score,  width/2, height/2 + 200, -800);
    }
    
}

// Create blocks and add to ArrayList
void createBlock(float posX, float posY, float posZ, int sizeX, int sizeY, int sizeZ) {
    Block block = new Block( posX, posY, posZ, sizeX, sizeY, sizeZ);
    blocks.add(block); 
}

void keyPressed(){
    if(key == 'f' || key == 'F'){
        Clickleft2TRACK = true;
        tickSound.play();
        ClickTrackIndex = 3;
    }
    if(key == 'g' || key == 'G'){
        ClickleftTRACK = true;
        tickSound.play();
        ClickTrackIndex = 0;
    }
    if(key == 'h' || key == 'H'){
        ClickmidlleTRACK = true;
        tickSound.play();
        ClickTrackIndex = 1;
    }
    if(key == 'j' || key == 'J'){
        ClickrightTRACK = true;
        tickSound.play();
        ClickTrackIndex = 2;
    }
    if(key == 'k' || key == 'K'){
        Clickleft2TRACK = true;
        tickSound.play();
        ClickTrackIndex = 4;
    }
    
    // Start Game 
    if(key == 's' || key == 'S'){
        if(GameInit){
            GameState = true;
            GameInit = false;
            DelayCount = 0;
        }
    }
    
    // Reset Game
    if(key == 'r' || key == 'R'){
       if(!GameState)
       {    
           score = 0;
           combo = 0;
           health = 1500;
           GameState = true;
           
           for (Block block : blocks) {
                block._stepCount = block._stepMin;
                block._boxDelay = false;
           }
           
           Clickleft2TRACK = false;
           ClickleftTRACK = false;
           ClickmidlleTRACK = false;
           ClickrightTRACK = false;
           Clickright2TRACK = false;
           
           DelayCount = 0;
           stepMagnification = 10;
       }
    }
    
    if(key == '1'){ difficulty = 3;}
    if(key == '2'){ difficulty = 5;}
    
    // invincible Star
    if(key == 'a' || key == 'A'){ health = 9000;}
    
    // end game
    if(key == 'x' || key == 'X'){ health =  200;}
}
