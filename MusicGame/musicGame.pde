import peasy .*;
PeasyCam cam;
PImage backgroundImage;

void setup(){
    size(900,1000,P3D);
    smooth(4);
    
    // # PeasyCam Setting
    cam = new PeasyCam(this, width/2, 200, 0, 300);
    //cam.setPitchRotationMode();
    cam.setActive(false); //false to make this camera stop responding to mouse
    cam.rotateX(-100);
 
    backgroundImage = loadImage("background.png");  // 替換為您的背景圖片路徑和檔名
}

int score = 0;
int combo = 0;
int health = 1000;
boolean GameState = true;


int sizeX_MIN = 10,
    sizeX_MAX = 150,
    sizeX = sizeX_MIN;

boolean ClickmidlleTRACK = false;
String judgeString = ""; 
color judgeColor = color(255,255,255);

int StepMin = -1500;
int StepCount = StepMin;
int StepMax = 120;

// left = 0 middle = 1 right = 2
int trackSelector = 1,trackValue = 0;

void draw(){
    background(backgroundImage);

    strokeWeight(5);
    stroke(255,0,0);
    line(0,0,0,200,0,0); // x
    stroke(0,255,0);
    line(0,0,0,0,1000,0); // y
    stroke(0,0,255);
    line(0,0,0,0,0,-200); // z
    
    if(health > 0 && GameState)
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

        if(StepCount < StepMax)
        {
            StepCount += 10;
            pushMatrix(); 
            if(trackSelector == 0){translate(width/2 - 70,height/2 -100,StepCount);}
            if(trackSelector == 1){translate(width/2 +  0,height/2 -100,StepCount);}
            if(trackSelector == 2){translate(width/2 + 70,height/2 -100,StepCount);}
            fill(222, 255, 209);
            stroke(0);
            strokeWeight(2);
            box(70,5,30);
            popMatrix(); 
        }
        else{ StepCount = StepMin;}

        
        // <#> judge the timing =========================================
        /* 20 Step
         * miss -> bad -> good -> perfect -> good -> bad -> miss
         *   1      3       3        6         3      3       1   (*10) 
         */ int judgeNUM = 0;
         
        if(((StepMax-200) <= StepCount && StepCount <= StepMax) && ClickmidlleTRACK == true){
            judgeNUM =  StepMax - StepCount;
            if(judgeNUM <= 20){
                // miss no score magnification(0)
                score += 2 * 0;
                combo = 0;
                health -= 100;
                
                judgeColor = color(186, 186, 186);
                judgeString = "miss";
            }
            else if(judgeNUM <= 40){
                // bad score magnification(1)
                score += 2 * 1;
                combo = 0;
                health -= 50;
                
                judgeColor = color(109, 113, 207);
                judgeString = "bad";
            }
            else if(judgeNUM <= 70){
                // good score magnification(2)
                score += 2 * 2;
                combo += 1;
                judgeColor = color(255, 171, 82);
                judgeString = "good";
            }
            else if(judgeNUM <= 130){
                // per score magnification(4)
                score += 8 * 4;
                combo += 1;
                judgeColor = color(255, 145, 231);
                judgeString = "perfect";
            }
            else if(judgeNUM <= 150){
                // good score magnification(2)
                score += 2 * 2;
                combo += 1;
                judgeColor = color(255, 171, 82);
                judgeString = "good";
            }
            else if(judgeNUM <= 170){
                // bad score magnification(1)
                score += 2 * 1;
                combo = 0;
                health -= 50;
                
                judgeColor = color(109, 113, 207);
                judgeString = "bad";
            }
            else if(judgeNUM <= 200){
                // miss no score magnification(0)
                score += 2 * 0;
                combo = 0;
                 health -= 100;
                
                judgeColor = color(186, 186, 186);
                judgeString = "miss";
            }
            ClickmidlleTRACK = false;
            StepCount = StepMin;
            trackSelector = int(random(3)); //0 ~ 2
        }
        else if(StepCount + 2 > StepMax){
            combo = 0;
            health -= 100;
            
            ClickmidlleTRACK = false;
            StepCount = StepMin;
            judgeColor = color(186, 186, 186);
            judgeString = "miss";
            trackSelector = int(random(3)); //0 ~ 2
        }
        else{
            ClickmidlleTRACK = false;
            //trackSelector = int(random(3)); // 0~2
        }
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

void keyPressed(){
    if(key == 'h' || key == 'H'){
        ClickmidlleTRACK = true;
    }
    if(key == 'r' || key == 'R'){
       if(!GameState)
       {    
           score = 0;
           combo = 0;
           health = 1000;
           GameState = true;
       }
    }
}
