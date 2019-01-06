class Menu {
  int posX, posY, sizeX,sizeY;
  String buttonName;
  
  Menu (int x, String s) {
    
    posX = x;
    posY = height-40;
    sizeX= 30;
    sizeY= 30;
    buttonName = s;
  }
  
  void go() {
    
  }
  
  void draw() {
    fill(255);
    textSize(15);
    text(buttonName,posX-5,posY-5);
    
    stroke(255);
    fill(255);
    rect(posX, posY, sizeX, sizeY);
    
    stroke(0);
    fill(0);
    rect(posX+4, posY+sizeY/2-4, sizeX-8, 8);
    
    stroke(0);
    fill(0);
    rect(posX+sizeX/2-4, posY+4, 8, sizeY-8);
    
    
    stroke(255);
    fill(0);
    rect(posX+sizeX+5, posY, sizeX, sizeY);
    
    stroke(255);
    fill(255);
    rect(posX+2*sizeX+10, posY, sizeX, sizeY);
    
    stroke(0);
    fill(0);
    rect(posX+2*sizeX+10+4, posY+sizeY/2-4, sizeX-8, 8);
    
  }
  
  
}
