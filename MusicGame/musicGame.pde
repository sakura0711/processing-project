import peasy .*;
PeasyCam cam;

void setup(){
    size(900,1000,P3D);

    // # PeasyCam Setting
    cam = new PeasyCam(this, width/2, height/2 - 200, 0, 200);
    //false to make this camera stop responding to mouse
    cam.setActive(false);
    
    // Processing Camera Setting
    camera(width/2, height/2 - 150, 200, 
           width/2, height/2,      -200,
           0.0    , 1.0     ,       0.0);
}

int score = 0;
int combe = 0;

boolean pushbtn = false;
String judgeString = ""; 
color judgeColor = color(255,255,255);

int StepCount = -200;
int StepMax = 120;

void draw(){
    background(150);

    /* jugde Line Drawing ================ */
    cam.beginHUD();
        stroke(128, 219, 255);
        strokeWeight(5);
        line(0, height/2 + 150, 0, width, height/2 + 150, 0);
        stroke(255);
        strokeWeight(2);
    cam.endHUD();
    /* =================================== */
    
    
    if(StepCount < 125){
        StepCount += 2;
        pushMatrix();
        translate(width/2,height/2 -100,StepCount);
        fill(222, 255, 209);
        stroke(0);
        strokeWeight(2);
        box(10,3,10);
        popMatrix();
        print(StepCount + "\n");
    }
    else{
        StepCount = -200;
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
        text("combe: " + combe,  100, 100);
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
     *   1      3       3        6         3      3       1    
     */
    
    int judgeNUM = 0;
    if((100 <= StepCount && StepCount <= 120) && pushbtn == true){
        judgeNUM =  StepMax - StepCount;
        if(judgeNUM <= 2){
            // miss no score magnification(0)
            score += 2 * 0;
            combe = 0;
            judgeColor = color(186, 186, 186);
            judgeString = "miss";
        }
        else if(judgeNUM <= 4){
            // bad score magnification(1)
            score += 2 * 1;
            combe = 0;
            judgeColor = color(109, 113, 207);
            judgeString = "bad";
        }
        else if(judgeNUM <= 7){
            // good score magnification(2)
            score += 2 * 2;
            combe += 1;
            judgeColor = color(255, 171, 82);
            judgeString = "good";
        }
        else if(judgeNUM <= 13){
            // per score magnification(4)
            score += 8 * 4;
            combe += 1;
            judgeColor = color(255, 145, 231);
            judgeString = "perfect";
        }
        else if(judgeNUM <= 15){
            // good score magnification(2)
            score += 2 * 2;
            combe += 1;
            judgeColor = color(255, 171, 82);
            judgeString = "good";
        }
        else if(judgeNUM <= 17){
            // bad score magnification(1)
            score += 2 * 1;
            combe = 0;
            judgeColor = color(109, 113, 207);
            judgeString = "bad";
        }
        else if(judgeNUM <= 20){
            // miss no score magnification(0)
            score += 2 * 0;
            combe = 0;
            judgeColor = color(186, 186, 186);
            judgeString = "miss";
        }
        pushbtn = false;
        StepCount = -200;
    }
    else if(StepCount > 120){
        combe = 0;
        pushbtn = false;
        StepCount = -200;
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
