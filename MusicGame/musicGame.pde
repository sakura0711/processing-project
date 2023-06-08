import peasy .*;
PeasyCam cam;
PImage backgroundImage;
Block block,block2;

void setup(){
    size(900,1000,P3D);
    smooth(4);
    
    // # PeasyCam Setting
    cam = new PeasyCam(this, width/2, 200, 0, 300);
    //cam.setPitchRotationMode();
    cam.setActive(false); //false to make this camera stop responding to mouse
    cam.rotateX(-100);
    
    block = new Block(width/2 +  0,height/2 -100,-1500,70,50,30);
    block2 = new Block(width/2 +  0,height/2 -100,-1500,70,50,30);
    
    backgroundImage = loadImage("background.png");  // 替換為您的背景圖片路徑和檔名
}

int score = 0;
int combo = 0;
int health = 1000;
boolean GameState = true;

//int sizeX_MIN = 10,
//    sizeX_MAX = 150,
//    sizeX = sizeX_MIN;

boolean ClickmidlleTRACK = false, 
        ClickleftTRACK   = false, 
        ClickrightTRACK  = false;
int     ClickTrackIndex  = -1; // default = noe

//boolean ClickmidlleTRACK2 = false, 
//        ClickleftTRACK2   = false, 
//        ClickrightTRACK2  = false;       

String judgeString = ""; 
color judgeColor = color(255,255,255);

//int StepMin = -1500;
//int StepCount = StepMin, StepCount2 = StepMin;
//int StepMax = 120;

// left = 0 middle = 1 right = 2
//int trackSelector = 1,trackValue = 0;
//int trackSelector2 = 1;

boolean box2Delay = false;

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
            
            
            // StepCount1 text
            textSize(30);
            fill(163, 255, 82);
            text("StepCount1: " + block._stepCount,  50, 250);
            
            // StepCount2 text
            textSize(30);
            fill(163, 255, 82);
            text("StepCount2: " + block2._stepCount,  50, 300);
            
            // ClickleftTRACK text
            textSize(30);
            fill(163, 255, 82);
            text("ClickleftTRACK: " + ClickleftTRACK,  50, 350);
            
            // ClickmidlleTRACK text
            textSize(30);
            fill(163, 255, 82);
            text("ClickmidlleTRACK: " + ClickmidlleTRACK,  50, 400);
            
             // ClickrightTRACK text
            textSize(30);
            fill(163, 255, 82);
            text("ClickrightTRACK: " + ClickrightTRACK,  50, 450);
                        
            // judgeNUM2 text
            //textSize(30);
            //fill(163, 255, 82);
            //text("judgeNUM2: " + judgeNUM2,  50, 500);
            
             // trackSelector2 text
            //textSize(30);
            //fill(163, 255, 82);
            //text("trackSelector2: " + trackSelector2,  50, 550);
            
            // judge text
            textAlign(CENTER, CENTER);
            textSize(50);
            fill(judgeColor);
            text(judgeString,  width/2, height - 150); 
            
        cam.endHUD();
        /* # End Drawing PeasyCam 2D GUI ================== */

        block.Update(ClickTrackIndex);
        if(block._stepCount == -1200) { box2Delay = true; }
        if(box2Delay) {block2.Update(ClickTrackIndex);}
        
        //delay(250);    
        
        //if(block._StepCount < StepMax)
        //{
        //    block._StepCount += 10;
        //    block.display();
        //    processTrack(ClickleftTRACK, trackSelector,block._StepCount,1);
        //    processTrack(ClickmidlleTRACK, trackSelector,block._StepCount,1);
        //    processTrack(ClickrightTRACK, trackSelector,block._StepCount,1);
        //}
        //else{ block._StepCount = StepMin;}
        
        //if(block._StepCount == -1200) { box2Delay = true; }
        ////box2Delay = true;
        
        //    if(block2._StepCount < StepMax){
        //        block2._StepCount += 10;
        //        block2.display(trackSelector2);
                
        //        processTrack(ClickleftTRACK, trackSelector2,block2._StepCount,2);
        //        processTrack(ClickmidlleTRACK, trackSelector2,block2._StepCount,2);
        //        processTrack(ClickrightTRACK, trackSelector2,block2._StepCount,2);
        //    }
        //    else{ block2._StepCount = StepMin;}  
        //}       
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
    if(key == 'g' || key == 'G'){
        ClickleftTRACK = true;
        ClickTrackIndex = 0;
        //ClickleftTRACK2 = true;
    }
    if(key == 'h' || key == 'H'){
        ClickmidlleTRACK = true;
        
        ClickTrackIndex = 1;
        //ClickmidlleTRACK2 = true;
    }
    if(key == 'j' || key == 'J'){
        ClickrightTRACK = true;
        ClickTrackIndex = 2;
        //ClickrightTRACK2 = true;
    }
    
    if(key == 'r' || key == 'R'){
       if(!GameState)
       {    
           score = 0;
           combo = 0;
           health = 1000;
           GameState = true;
           
           block._stepCount = block._stepMin;
           block2._stepCount = block._stepMin;
           
           box2Delay = false;
       }
    }
}

int judgeNUM = 0, judgeNUM2= 0;
//void processTrack(boolean clickTrack, int trackIndex, int stepcount, int boxIndex) {
//    // <#> judge the timing =========================================
//        /* 20 Step
//         * miss -> bad -> good -> perfect -> good -> bad -> miss
//         *   1      3       3        6         3      3       1   (*10) 
//         */ //int judgeNUM = 0;
//    //print(stepcount + "\t");
//    if (((StepMax - 200) <= stepcount && stepcount <= StepMax) && (clickTrack && (trackSelector == trackIndex)) && boxIndex == 1) {
//        judgeNUM = StepMax - stepcount;
//        if (judgeNUM <= 20) {
//            score += 2 * 0;
//            combo = 0;
//            health -= 100;
//            judgeColor = color(186, 186, 186);
//            judgeString = "miss";
//        }
//        else if (judgeNUM <= 40) {
//            score += 2 * 1;
//            combo = 0;
//            health -= 50;
//            judgeColor = color(109, 113, 207);
//            judgeString = "bad";
//        }
//        else if (judgeNUM <= 70) {
//            score += 2 * 2;
//            combo += 1;
//            judgeColor = color(255, 171, 82);
//            judgeString = "good";
//        }
//        else if (judgeNUM <= 130) {
//            score += 8 * 4;
//            combo += 1;
//            judgeColor = color(255, 145, 231);
//            judgeString = "perfect";
//        }
//        else if (judgeNUM <= 150) {
//            score += 2 * 2;
//            combo += 1;
//            judgeColor = color(255, 171, 82);
//            judgeString = "good";
//        }
//        else if (judgeNUM <= 170) {
//            score += 2 * 1;
//            combo = 0;
//            health -= 50;
//            judgeColor = color(109, 113, 207);
//            judgeString = "bad";
//        }
//        else if (judgeNUM <= 200) {
//            score += 2 * 0;
//            combo = 0;
//            health -= 100;
//            judgeColor = color(186, 186, 186);
//            judgeString = "miss";
//        }
        
//        //clickTrack = false;
//        if(boxIndex == 1){
//            if(trackIndex == 0){ClickleftTRACK = false;}
//            if(trackIndex == 1){ClickmidlleTRACK = false;}
//            if(trackIndex == 2){ClickrightTRACK = false;}
//            block._StepCount = StepMin; 
//            trackSelector = int(random(3)); // 0 ~ 2
//        } 
        
//    }   
//    else if (((StepMax - 200) <= stepcount && stepcount <= StepMax) && boxIndex == 2 && (clickTrack)) { 
//        judgeNUM2 = StepMax - stepcount;
//        if (judgeNUM2 <= 20) {
//            score += 2 * 0;
//            combo = 0;
//            health -= 100;
//            judgeColor = color(186, 186, 186);
//            judgeString = "miss";
//        }
//        else if (judgeNUM2 <= 40) {
//            score += 2 * 1;
//            combo = 0;
//            health -= 50;
//            judgeColor = color(109, 113, 207);
//            judgeString = "bad";
//        }
//        else if (judgeNUM2 <= 70) {
//            score += 2 * 2;
//            combo += 1;
//            judgeColor = color(255, 171, 82);
//            judgeString = "good";
//        }
//        else if (judgeNUM2 <= 130) {
//            score += 8 * 4;
//            combo += 1;
//            judgeColor = color(255, 145, 231);
//            judgeString = "perfect";
//        }
//        else if (judgeNUM2 <= 150) {
//            score += 2 * 2;
//            combo += 1;
//            judgeColor = color(255, 171, 82);
//            judgeString = "good";
//        }
//        else if (judgeNUM2 <= 170) {
//            score += 2 * 1;
//            combo = 0;
//            health -= 50;
//            judgeColor = color(109, 113, 207);
//            judgeString = "bad";
//        }
//        else if (judgeNUM2 <= 200) {
//            score += 2 * 0;
//            combo = 0;
//            health -= 100;
//            judgeColor = color(186, 186, 186);
//            judgeString = "miss";
//        }
        
//        if(boxIndex == 2){
//            if(trackIndex == 0){ClickleftTRACK = false;}
//            if(trackIndex == 1){ClickmidlleTRACK = false;}
//            if(trackIndex == 2){ClickrightTRACK = false;}
//            block2._StepCount = StepMin; 
//            trackSelector2 = int(random(3)); // 0 ~ 2
//        }     
//    }
    
    
//    if (stepcount + 2 > StepMax && (boxIndex == 1)) {
//        combo = 0;
//        health -= 100;
//        //clickTrack = false;

//        if(boxIndex == 1){
//            if(trackIndex == 0){ClickleftTRACK = false;}
//            if(trackIndex == 1){ClickmidlleTRACK = false;}
//            if(trackIndex == 2){ClickrightTRACK = false;}
//            block._StepCount = StepMin; 
//            trackSelector = int(random(3)); // 0 ~ 2
//        } 
        
//        judgeColor = color(186, 186, 186);
//        judgeString = "miss";
        
//    }
//    else if (stepcount + 2 > StepMax && (boxIndex == 2)) {
//        combo = 0;
//        health -= 100;
        
//        if(boxIndex == 2){
//            if(trackIndex == 0){ClickleftTRACK = false;}
//            if(trackIndex == 1){ClickmidlleTRACK = false;}
//            if(trackIndex == 2){ClickrightTRACK = false;}
//            block2._StepCount = StepMin; 
//            trackSelector2 = int(random(3)); // 0 ~ 2
//        }    
        
//        judgeColor = color(186, 186, 186);
//        judgeString = "miss";
        
//    }
//    else {
//        //clickTrack = false;
//        if(clickTrack == true){
//            ClickleftTRACK = false;
//            ClickmidlleTRACK = false;
//            ClickrightTRACK = false;
//        }
//    }
//}
