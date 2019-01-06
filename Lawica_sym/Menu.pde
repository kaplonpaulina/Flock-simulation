class Menu {
  int posX, posY, sizeX,sizeY;
  String buttonName;
  boolean sepPlusFlag, sepMinusFlag, aliPlusFlag, aliMinusFlag,  cohPlusFlag, cohMinusFlag;
  color rectHighlight;
  float ms,ma,mc; //separation, align, cohesion
   
  Menu (int x) {    
    posX = x;
    posY = height-40;
    sizeX= 30;
    sizeY= 30;
    sepPlusFlag=sepMinusFlag=aliPlusFlag=aliMinusFlag=cohPlusFlag=cohMinusFlag=false;
    rectHighlight = color(102);
    ms=2.2;
    ma=1;
    mc=1;
  }

  void go() {   
  }
  
  void draw() {
    update(mouseX, mouseY);
    drawText(255,40, "Menu",posX-120, posY+25);
    drawText(255,10, "click 'm' to change variables in menu",posX+900, posY);
    drawText(255,10, "click 'b' to add fish",posX+900, posY+10);
    drawText(255,10, "click 'a' to add obstacle",posX+900, posY+20);
    drawText(255,10, "click 'f' to change tuna into food",posX+900, posY+30);
    //SEPARATION
     drawController(posX, posY, sizeX, sizeY,"Separation", sepPlusFlag, sepMinusFlag, ms);
    //ALIGN
    drawController(posX+120, posY, sizeX, sizeY,"Align", aliPlusFlag, aliMinusFlag, ma);
    //COHERSION
    drawController(posX+240, posY, sizeX, sizeY,"Cohesion", cohPlusFlag, cohMinusFlag, mc);
    
  }
  
  void drawRectangle(color cstroke, color cfill, int posX, int posY, int sizeX, int sizeY){
    stroke(cstroke);
    fill(cfill);
    rect(posX, posY, sizeX, sizeY);
  }
  
  void drawElipse(color cstroke, color cfill, int posX, int posY, int sizeX, int sizeY){
    stroke(cstroke);
    fill(cfill);
    ellipse(posX, posY, sizeX, sizeY);
  }
  
  void drawText(color cfill, int textsize, String text, int posX, int posY){
    fill(cfill);
    textSize(textsize);
    text(text,posX,posY);
  }
  
  void drawController(int posX, int posY, int sizeX, int sizeY, String text, boolean PlusFlag, boolean MinusFlag, float var){
     drawText(255, 15, text, posX-5, posY-5);  
    //biały kwadrat
    if (PlusFlag) {
       drawRectangle(255, rectHighlight, posX, posY, sizeX, sizeY);
     } else {
       drawRectangle(255, 255, posX, posY, sizeX, sizeY);
    }
    //czarna kreska poziona od plusa
    drawRectangle(0, 0, posX+4, posY+sizeY/2-4, sizeX-8, 8);
    //czarna kreska pionowa od plusa
    drawRectangle(0, 0, posX+sizeX/2-4, posY+4, 8, sizeY-8);
    //czarny kwadrat z liczbą
    drawRectangle(255, 0, posX+sizeX+5, posY, sizeX, sizeY);
    drawText(255, 10, String.valueOf(var), posX+sizeX+12, posY+17);
    
    //bialy kwadrat
    if(MinusFlag){
     drawRectangle(255, rectHighlight, posX+2*sizeX+10, posY, sizeX, sizeY);
    } else {
     drawRectangle(255, 255, posX+2*sizeX+10, posY, sizeX, sizeY);
    }
    //czarna kreska pozioma od minusa
    drawRectangle(0, 0, posX+2*sizeX+10+4, posY+sizeY/2-4, sizeX-8, 8);
  }
  
  void update(int x, int y) {
  if ( overRect(posX, posY, sizeX, sizeY) ) {
    sepPlusFlag = true;
    sepMinusFlag = aliPlusFlag= aliMinusFlag = cohPlusFlag= cohMinusFlag=false;
  } else if (overRect(posX+2*sizeX+10, posY, sizeX, sizeY)) {
    sepMinusFlag=true;
    sepPlusFlag = aliPlusFlag= aliMinusFlag = cohPlusFlag= cohMinusFlag=false;
  } else if (overRect(posX+120, posY, sizeX, sizeY)){
    aliPlusFlag = true;
    sepMinusFlag = sepPlusFlag= aliMinusFlag = cohPlusFlag= cohMinusFlag=false;
  } else if (overRect(posX+120+2*sizeX+10, posY, sizeX, sizeY)) {
    aliMinusFlag=true;
    sepPlusFlag = aliPlusFlag= sepMinusFlag = cohPlusFlag= cohMinusFlag=false;
  } else if (overRect(posX+240, posY, sizeX, sizeY)){
    cohPlusFlag = true;
    sepMinusFlag = sepPlusFlag= aliMinusFlag = aliPlusFlag= cohMinusFlag=false;
  } else if (overRect(posX+240+2*sizeX+10, posY, sizeX, sizeY)) {
    cohMinusFlag=true;
    sepPlusFlag = aliPlusFlag= sepMinusFlag = cohPlusFlag= aliMinusFlag=false;
  } else {
    sepPlusFlag = sepMinusFlag = aliPlusFlag= aliMinusFlag = cohPlusFlag= cohMinusFlag=false;
  }
  }
  
  boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
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
  } 
}
