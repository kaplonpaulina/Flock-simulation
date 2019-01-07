
class Flock {
  ArrayList<Boid> boids; 

  Flock() {
    boids = new ArrayList<Boid>();
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);  
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
    
    
  }
  
  void delBoid() {
    if(boids.size()>1){
      boids.remove(boids.size()-1);
    }
  }
  
  
  void feed(){
    for (Boid b : boids){
      PVector mouse = new PVector(mouseX,mouseY);
      float d = PVector.dist(b.position,mouse);
      
      if(d < b.neighbord*2){
      PVector feed = b.seek(mouse);
      feed.mult(1.9);
      b.applyForce(feed);
    }
    else if(d == 0) {
      b.applyForce(b.seek(new PVector(width-mouseX,height-mouseY)));
    }
    }
  }
  
  void changeSeparation(float ms){
    for (Boid b : boids)
    {
      b.separationmult=ms;
    }
  }
  
  void changeAlign(float ma){
    for (Boid b : boids)
    {
      b.alignmult=ma;
    }
  }
  
  void changeCohesion(float mc){
    for (Boid b : boids)
    {
      b.cohesionmult=mc;
    }
  }
  
  void changeNeighbor(float n){
    for (Boid b : boids)
    {
      b.neighbord=n;
    }
  }

}
