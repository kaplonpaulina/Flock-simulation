class Menu {
  int posX, posY, sizeX,sizeY;
  String buttonName;
  boolean sepPlusFlag, sepMinusFlag, aliPlusFlag, aliMinusFlag,  cohPlusFlag, cohMinusFlag,neiPlusFlag, neiMinusFlag;
  color rectHighlight;
  float ms,ma,mc,n; //separation, align, cohesion,neighbourhood
  
  Menu (int x) {    
    posX = x;
    posY = height-40;
    sizeX= 30;
    sizeY= 30;
    sepPlusFlag=sepMinusFlag=aliPlusFlag=aliMinusFlag=cohPlusFlag=cohMinusFlag=neiPlusFlag=neiMinusFlag=false;
    rectHighlight = color(102);
    ms=2.2;
    ma=1;
    mc=1;
    n=60;
  }

  void go() {   
  }
  
  void draw() {
    update(mouseX, mouseY);
    drawText(255,40, "Menu",posX-100, posY+25);
    drawText(255,10, "click 'a' and mouse click to add obstacle",posX+940, posY-5);
    drawText(255,10, "click 'b' and mouse click to add fish",posX+960, posY+5);
    drawText(255,10, "click 'd' and mouse click to delete fish",posX+950, posY+15);
    drawText(255,10, "click 'f' and hold mouse button to change mouse into food",posX+850, posY+25);
    drawText(255,10, "click 'm' to change variables in menu",posX+955, posY+35);
   
    drawController(posX+100, posY, sizeX, sizeY,"Separation", sepPlusFlag, sepMinusFlag, ms);
    drawController(posX+300, posY, sizeX, sizeY,"Align", aliPlusFlag, aliMinusFlag, ma);
    drawController(posX+500, posY, sizeX, sizeY,"Cohesion", cohPlusFlag, cohMinusFlag, mc);
    drawController(posX+700, posY, sizeX, sizeY,"Neighbourhood", neiPlusFlag, neiMinusFlag, n);
  }
  
  void drawRectangle(color cstroke, color cfill, int posX, int posY, int sizeX, int sizeY){
    stroke(cstroke);
    fill(cfill);
    rect(posX, posY, sizeX, sizeY);
  }
  
  void drawText(color cfill, int textsize, String text, int posX, int posY){
    fill(cfill);
    textSize(textsize);
    text(text,posX,posY);
  }
  
  void drawController(int posX, int posY, int sizeX, int sizeY, String text, boolean PlusFlag, boolean MinusFlag, float var){
     drawText(255, 15, text, posX-5, posY-5);  
    if (PlusFlag) {
       drawRectangle(255, rectHighlight, posX, posY, sizeX, sizeY);
     } else {
       drawRectangle(255, 255, posX, posY, sizeX, sizeY);
    }
    drawRectangle(0, 0, posX+4, posY+sizeY/2-4, sizeX-8, 8);
    drawRectangle(0, 0, posX+sizeX/2-4, posY+4, 8, sizeY-8);
    drawRectangle(255, 0, posX+sizeX+5, posY, sizeX, sizeY);
    if(String.valueOf(var).length()>3){
      drawText(255, 10, String.valueOf(var), posX+sizeX+9, posY+18);
    } else {
      drawText(255, 10, String.valueOf(var), posX+sizeX+12, posY+18); 
    }
    if(MinusFlag){
      drawRectangle(255, rectHighlight, posX+2*sizeX+10, posY, sizeX, sizeY);
    } else {
      drawRectangle(255, 255, posX+2*sizeX+10, posY, sizeX, sizeY);
    }
    drawRectangle(0, 0, posX+2*sizeX+10+4, posY+sizeY/2-4, sizeX-8, 8);
  }
  
  void update(int x, int y) {
  if ( overRect(posX, posY, sizeX, sizeY) ) {
    sepPlusFlag = true;
    sepMinusFlag = aliPlusFlag= aliMinusFlag = cohPlusFlag= cohMinusFlag=neiPlusFlag=neiMinusFlag=false;
  } else if (overRect(posX+2*sizeX+10, posY, sizeX, sizeY)) {
    sepMinusFlag=true;
    sepPlusFlag = aliPlusFlag= aliMinusFlag = cohPlusFlag= cohMinusFlag=neiPlusFlag=neiMinusFlag=false;
  } else if (overRect(posX+120, posY, sizeX, sizeY)){
    aliPlusFlag = true;
    sepMinusFlag = sepPlusFlag= aliMinusFlag = cohPlusFlag= cohMinusFlag=neiPlusFlag=neiMinusFlag=false;
  } else if (overRect(posX+120+2*sizeX+10, posY, sizeX, sizeY)) {
    aliMinusFlag=true;
    sepPlusFlag = aliPlusFlag= sepMinusFlag = cohPlusFlag= cohMinusFlag=neiPlusFlag=neiMinusFlag=false;
  } else if (overRect(posX+240, posY, sizeX, sizeY)){
    cohPlusFlag = true;
    sepMinusFlag = sepPlusFlag= aliMinusFlag = aliPlusFlag= cohMinusFlag=neiPlusFlag=neiMinusFlag=false;
  } else if (overRect(posX+240+2*sizeX+10, posY, sizeX, sizeY)) {
    cohMinusFlag=true;
    sepPlusFlag = aliPlusFlag= sepMinusFlag = cohPlusFlag= aliMinusFlag=neiPlusFlag=neiMinusFlag=false;
  } else if (overRect(posX+360, posY, sizeX, sizeY)){
    neiPlusFlag = true;
    sepMinusFlag = sepPlusFlag= aliMinusFlag = aliPlusFlag= cohMinusFlag=cohPlusFlag=neiMinusFlag=false;
  } else if (overRect(posX+360+2*sizeX+10, posY, sizeX, sizeY)) {
    neiMinusFlag=true;
    sepPlusFlag = aliPlusFlag= sepMinusFlag = cohPlusFlag= aliMinusFlag=neiPlusFlag=cohMinusFlag=false;
  } else {
    sepPlusFlag = sepMinusFlag = aliPlusFlag= aliMinusFlag = cohPlusFlag= cohMinusFlag=neiPlusFlag=neiMinusFlag=false;
  }
  }
  
  boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
  }
  
  void mousePressed() {
  if (sepPlusFlag) {
    ms=Math.round((ms+0.1) * 10) / 10.0;
  }
  if (sepMinusFlag && ms>0) {
    ms=Math.round((ms-0.1) * 10) / 10.0;
  }
  
  if (aliPlusFlag) {
    ma=Math.round((ma+0.1) * 10) / 10.0;
  }
  if (aliMinusFlag && ma>0) {
    ma=Math.round((ma-0.1) * 10) / 10.0;
  }
  
  if (cohPlusFlag) {
    mc=Math.round((mc+0.1) * 10) / 10.0;
  }
  if (cohMinusFlag && mc>0) {
    mc=Math.round((mc-0.1) * 10) / 10.0;
  }
  
  if (neiPlusFlag) {
    n=Math.round((n+0.1) * 10) / 10.0;
  }
  if (neiMinusFlag && n>0) {
    n=Math.round((n-0.1) * 10) / 10.0;
  }
  } 
}
