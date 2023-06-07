import peasy .*;
PeasyCam cam;

void setup(){
    size(900,1000,P3D);
    smooth(4);
    
    // # PeasyCam Setting
    cam = new PeasyCam(this, width/2, 200, 0, 1000);
    cam.rotateX(-150);
    //cam.setPitchRotationMode();
    //false to make this camera stop responding to mouse
    cam.setActive(false);
  
    // Processing Camera Setting
    //camera(width/2, -100, 200, 
    //       width/2, 300,      -200,
    //       0.0    , 1.0     ,       0.0);
}

int score = 0;
int combo = 0;

boolean pushbtn = false;
String judgeString = ""; 
color judgeColor = color(255,255,255);

int StepMin = -1500;
int StepCount = StepMin;
int StepMax = 120;

void draw(){
    //float[] rotations = cam.getRotations();
    //print(rotations);
    background(150);

    strokeWeight(5);
    //stroke(255,0,0);
    //line(0,0,0,200,0,0); // x
    //stroke(0,255,0);
    //line(0,0,0,0,1000,0); // y
    //stroke(0,0,255);
    //line(0,0,0,0,0,-200); // z
    
    stroke(138, 242, 187);
    line(-100,460,0,1000,460,0); // jugde Line


    /* jugde Line Drawing ================ */
    //cam.beginHUD();
    //    stroke(128, 219, 255);
    //    strokeWeight(5);
    //    line(0, height/2 + 150, 0, width, height/2 + 150, 0);
    //    stroke(255);
    //    strokeWeight(2);
    //cam.endHUD();
    /* =================================== */
    
    
    if(StepCount < StepMax){
        StepCount += 10;
        pushMatrix();
        translate(width/2,height/2 -100,StepCount);
        fill(222, 255, 209);
        stroke(0);
        strokeWeight(2);
        box(150,10,100);
        popMatrix();
        //print(StepCount + "\n");
    }
    else{
        StepCount = StepMin;
    }
    
    /* # Start Drawing PeasyCam 2D GUI ================== */
    cam.beginHUD();
        textAlign(LEFT, CENTER);
        // Score text
        fill(0, 408, 612);
        textSize(50);
        text("score: " + score,  100, 200);
        // text(score,  width - 50, height/2);
        
        // combe text
        textSize(50);
        fill(163, 255, 82);
        text("combo: " + combo,  100, 100);
        //text(combe,  150, height/2);
        
        // judge text
        textAlign(CENTER, CENTER);
        textSize(50);
        fill(judgeColor);
        text(judgeString,  width/2, height - 150); 
    cam.endHUD();
    /* # End Drawing PeasyCam 2D GUI ================== */
    
    
    
    // <#> judge the timing =========================================
    /* 20 Step
     * miss -> bad -> good -> perfect -> good -> bad -> miss
     *   1      3       3        6         3      3       1   (*10) 
     */
    
    int judgeNUM = 0;
    if(((StepMax-200) <= StepCount && StepCount <= StepMax) && pushbtn == true){
        judgeNUM =  StepMax - StepCount;
        if(judgeNUM <= 20){
            // miss no score magnification(0)
            score += 2 * 0;
            combo = 0;
            judgeColor = color(186, 186, 186);
            judgeString = "miss";
        }
        else if(judgeNUM <= 40){
            // bad score magnification(1)
            score += 2 * 1;
            combo = 0;
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
            judgeColor = color(109, 113, 207);
            judgeString = "bad";
        }
        else if(judgeNUM <= 200){
            // miss no score magnification(0)
            score += 2 * 0;
            combo = 0;
            judgeColor = color(186, 186, 186);
            judgeString = "miss";
        }
        pushbtn = false;
        StepCount = StepMin;
    }
    else if(StepCount + 2 > StepMax){
        combo = 0;
        pushbtn = false;
        StepCount = StepMin;
        judgeColor = color(186, 186, 186);
        judgeString = "miss";
    }
    else{
        pushbtn = false;
    }
    
}

void keyPressed(){
    if(key == 'f' || key == 'F'){
        pushbtn = true;
    }
}
