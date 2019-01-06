
Flock flock;
ArrayList<Avoid> avoids;
Shark shark;
Menu menu;
boolean grabFood;

int onClickAction = 1;

void setup() {
  size(1280, 720);
  flock = new Flock();
  shark = new Shark(width/4,height/4);
  menu = new Menu(122,"number of tuna");
  
  grabFood = false;
  
  for (int i = 0; i < 200; i++) {
    addTuna(width/2,height/2);
    
  }
  
  
  setupWalls();
}

void draw() {
  background(50);
  flock.run();
  shark.run(flock.boids);
  menu.draw();
  for (int i = 0; i <avoids.size(); i++) {
    Avoid current = avoids.get(i);
    current.go();
    current.draw();
  }
  if(grabFood){
    flock.feed();
  }
  
  
  
}

void keyPressed () {
  switch (key) {
    case 'b':
      onClickAction = 1;
      break;
    case 'a':
      onClickAction = 2;
      break;
    case 'f':
      onClickAction = 3;
      break;
  }
}


void mousePressed() {
  switch (onClickAction) {
   case 1:
      addTuna(mouseX,mouseY);
      break;
     case 2:
       avoids.add(new Avoid(mouseX,mouseY));
       break;
     case 3:
       grabFood = true;
       break;
      
  }
}

void mouseReleased() {
  grabFood = false;
}


void setupWalls() {
  avoids = new ArrayList<Avoid>();
  for (int x = 0; x < width+1; x+= 20) {
    avoids.add(new Avoid(x, 10));
    avoids.add(new Avoid(x, height - 70));
  } 
}

void addTuna(int x, int y) {
     if(random(20.0)>1){
       flock.addBoid(new Tuna(x,y,random(2.0,7.0)));
      }
      else{
       flock.addBoid(new IllTuna(x,y,random(2.0,7.0)));
      }
    
  }
