class Block{
    float _posX , _posY , _posZ;
    int   _sizeX, _sizeY, _sizeZ;
    int   _stepMin = -1500, _stepMax = 120;
    int   _stepCount = _stepMin;
    //int   _stepMagnification = 10;
    int   _trackSelector = 1; // left = 0 middle = 1 right = 2 (default : 1)
    boolean   _boxDelay = false;
    
    Block(float posX, float posY, float posZ, int sizeX, int sizeY, int sizeZ){
        this._posX = posX; this._posY = posY; this._posZ = posZ;
        this._sizeX = sizeX; this._sizeY = sizeY; this._sizeZ = sizeZ;
    }
    
    void display(){
        pushMatrix(); 
        if(_trackSelector == 3){translate(width/2 - 140,height/2 -100,_stepCount);}
        if(_trackSelector == 0){translate(width/2 -  70,height/2 -100,_stepCount);}
        if(_trackSelector == 1){translate(width/2 +   0,height/2 -100,_stepCount);}
        if(_trackSelector == 2){translate(width/2 +  70,height/2 -100,_stepCount);}
        if(_trackSelector == 4){translate(width/2 + 140,height/2 -100,_stepCount);}
        fill(222, 255, 209);
        stroke(0);
        strokeWeight(2);
        box(70,5,30);
        popMatrix();
    }
    
    void Update(int ClickTrackIndex){
        if(_stepCount < _stepMax)
        {
            _stepCount += 1 * stepMagnification;
            display();
        }else{ _stepCount = _stepMin;}
        
        if (((_stepMax - 200) <= _stepCount && _stepCount <= _stepMax) && (_trackSelector == ClickTrackIndex)){
            judge();
        }
        else if (_stepCount + 2 > _stepMax) {
                combo = 0;
                health -= 100;
    
                if(_trackSelector == 3){ClickleftTRACK = false;}
                if(_trackSelector == 0){ClickleftTRACK = false;}
                if(_trackSelector == 1){ClickmidlleTRACK = false;}
                if(_trackSelector == 2){ClickrightTRACK = false;}
                if(_trackSelector == 4){ClickleftTRACK = false;}
                _stepCount = _stepMin; 
                _trackSelector = int(random(difficulty)); // 0 ~ 4
    
                judgeColor = color(186, 186, 186);
                judgeString = "miss";
                ClickTrackIndex = -1;
            }
            else {
                //clickTrack = false;
                if(Clickleft2TRACK || ClickleftTRACK || ClickmidlleTRACK || ClickrightTRACK || Clickright2TRACK){
                    Clickleft2TRACK  = false;
                    ClickleftTRACK   = false;
                    ClickmidlleTRACK = false;
                    ClickrightTRACK  = false;
                    Clickright2TRACK = false;
                }
                ClickTrackIndex = -1;
            } 
    }
    
    void judge(){
        int judgeNUM = _stepMax - _stepCount;
            if (judgeNUM <= 2 * stepMagnification) {
                score += 2 * 0;
                combo = 0;
                health -= 100;
                judgeColor = color(186, 186, 186);
                judgeString = "miss";
            }
            else if (judgeNUM <= 4 * stepMagnification) {
                score += 2 * 1;
                combo = 0;
                health -= 50;
                judgeColor = color(109, 113, 207);
                judgeString = "bad";
            }
            else if (judgeNUM <= 7 * stepMagnification) {
                score += 2 * 2;
                combo += 1;
                judgeColor = color(255, 171, 82);
                judgeString = "good";
            }
            else if (judgeNUM <= 13 * stepMagnification) {
                score += 8 * 4;
                combo += 1;
                judgeColor = color(255, 145, 231);
                judgeString = "perfect";
            }
            else if (judgeNUM <= 15 *stepMagnification) {
                score += 2 * 2;
                combo += 1;
                judgeColor = color(255, 171, 82);
                judgeString = "good";
            }
            else if (judgeNUM <= 17 * stepMagnification) {
                score += 2 * 1;
                combo = 0;
                health -= 50;
                judgeColor = color(109, 113, 207);
                judgeString = "bad";
            }
            else if (judgeNUM <= 20 * stepMagnification) {
                score += 2 * 0;
                combo = 0;
                health -= 100;
                judgeColor = color(186, 186, 186);
                judgeString = "miss";
            }
            
            //clickTrack = false;
            if(_trackSelector == 3){ClickleftTRACK = false;}
            if(_trackSelector == 0){ClickleftTRACK = false;}
            if(_trackSelector == 1){ClickmidlleTRACK = false;}
            if(_trackSelector == 2){ClickrightTRACK = false;}
            if(_trackSelector == 4){ClickleftTRACK = false;}
            
            _stepCount = _stepMin; 
            _trackSelector = int(random(difficulty)); // 0 ~ 4
            ClickTrackIndex = -1;

            
    }
}
