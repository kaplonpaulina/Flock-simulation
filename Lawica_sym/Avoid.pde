class Avoid {
  PVector position;
  float avoiddistance;
   
  
  Avoid (float x, float y) {
    
    position = new PVector(x,y);
    avoiddistance = 40;
   
  }
  
  void go() {
    
  }
  
  void draw() {
    
    fill(40);
    ellipse(position.x, position.y, 15, 15);
    
  }
  
  
}
