
Flock flock;
ArrayList<Avoid> avoids;
Shark shark;
Menu menu;
boolean grabFood;
boolean menuOn;
PImage bg;

PrintWriter velocityMean, neighboursMean;

int onClickAction = 1;

void setup() {
  size(1280, 720);
  bg = loadImage("bg1.png");
  
  menu = new Menu(122);
  flock = new Flock();
  shark = new Shark(width/4,height/4);

  grabFood = false;
  menuOn = false;
    
  for (int i = 0; i < 300; i++) {
    addTuna(width/2,height/2);  
  }
  setupWalls();
  
  velocityMean = createWriter("velocityp.txt"); 
  neighboursMean = createWriter("neighbours.txt");
}

void draw() {
  background(bg);
  flock.run();
  shark.run(flock.boids);
  menu.draw();
  for (int i = 0; i <avoids.size(); i++) {
    Avoid current = avoids.get(i);
    current.go();
    current.draw();
  }
 
  flock.feed(grabFood); 
  flock.eat();
  
  flock.changeSeparation(menu.ms,flock.getSeparationmult() != menu.ms);
  flock.changeAlign(menu.ma,flock.getAlignmult() != menu.ma);
  flock.changeCohesion(menu.mc,flock.getCohesionmult() != menu.mc);
  flock.changeNeighbour(menu.n,flock.getNeighbour() != menu.n);
  
  
}

void keyPressed () {
  switch (key) {
    case 'b':
    case 'B':
      onClickAction = 1;
      menuOn = false;
      break;
    case 'o':
    case 'O':
      onClickAction = 2;
      menuOn = false;
      break;
    case 'f':
    case 'F':
      onClickAction = 3;
      menuOn = false;
      break;
    case 'm':
    case 'M':
      onClickAction = 4;
      menuOn = true;
      break;
    case 'd':
    case 'D':
      onClickAction = 5;
      menuOn = false;
      break;
    case 's':
    case 'S':
      onClickAction = 6;
      menuOn = false;
      break;
    case 'p':
    case 'P':
      flock.szybkosc(velocityMean,onClickAction);
    case 'n':
    case 'N':
      flock.gestosc(neighboursMean,onClickAction);
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
     case 4: 
       menu.mousePressed();
       break;
     case 5: 
       flock.delBoid();
       break;
     case 6:
       if(avoids.size()>0)
         avoids.remove(avoids.size()-1);
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
       flock.addBoid(new Tuna(x,y,random(2.0,7.0),menu.ms,menu.ma,menu.mc, menu.n));
      }
      else{
      flock.addBoid(new IllTuna(x,y,random(2.0,7.0)));
      }
    
  }
  
