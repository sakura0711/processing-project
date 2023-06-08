class Block{
    float _posX , _posY , _posZ;
    int   _sizeX, _sizeY, _sizeZ;
    int   _StepCount = -1500;
    
    Block(float posX, float posY, float posZ, int sizeX, int sizeY, int sizeZ){
        this._posX = posX; this._posY = posY; this._posZ = posZ;
        this._sizeX = sizeX; this._sizeY = sizeY; this._sizeZ = sizeZ;
    }
    
    void display(int trackNUM){
        pushMatrix(); 
        if(trackNUM == 0){translate(width/2 - 70,height/2 -100,_StepCount);}
        if(trackNUM == 1){translate(width/2 +  0,height/2 -100,_StepCount);}
        if(trackNUM == 2){translate(width/2 + 70,height/2 -100,_StepCount);}
        fill(222, 255, 209);
        stroke(0);
        strokeWeight(2);
        box(70,5,30);
        popMatrix();
    }
}
