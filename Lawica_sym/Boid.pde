class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    
  float maxspeed;    
  float neighbour;
  float boid_color;
  
  float separationmult;
  float alignmult;
  float cohesionmult;
  float separation;
  
  boolean seekFood = false;
  
    Boid(float x, float y, float c, float size, float nb, float ms, float mf, float sm, float am, float cm, float s) {
    
    boid_color = c;
    
    acceleration = new PVector(0, 0);
    neighbour = nb;
    
    velocity = PVector.random2D();

    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    position = new PVector(x, y);
    r = size;
    maxspeed = ms;
    maxforce = mf;
    
    separationmult = sm;
    alignmult = am;
    cohesionmult = cm;
    separation = s;
    
    
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
    
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }
  


  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids); 
    PVector ali = align(boids);      
    PVector coh = cohesion(boids);
    PVector noise = new PVector((random(2) - 1)/30, (random(2) -1)/30);
    PVector avoid = avoid(); 
    
    
    sep.mult(separationmult);
    ali.mult(alignmult);
    coh.mult(cohesionmult);
    avoid.mult(3);
    
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(noise);
    applyForce(avoid);
    
  }

  
  void update() {
    
    velocity.add(acceleration);
    
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }


  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  

    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  
    return steer;
  }

  void render() {

    float theta = velocity.heading2D() + radians(90);
    
    fill(boid_color, 90, 200);
    stroke(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }


  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = separation;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;

    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      
      if ((d > 0) && (d < desiredseparation)) {
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        
        steer.add(diff);
        count++;            
      }
    }

    if (count > 0) {
      steer.div((float)count);
    }

    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  PVector align (ArrayList<Boid> boids) {
    
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbour)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {

      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

   PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = neighbour;
    PVector sum = new PVector(0, 0);  
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); 
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  
    } 
    else {
      return new PVector(0, 0);
    }
  }
  
   PVector avoid() {
    PVector sum = new PVector(0, 0);

    for (Avoid other : avoids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < other.avoiddistance)) {
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
      }
    }
    return sum;
  }
  
  PVector escape() {
    PVector sum = new PVector(0, 0);

      float d = PVector.dist(position, shark.position);
      if ((d > 0) && (d < shark.avoiddistance)) {
        PVector diff = PVector.sub(position, shark.position);
        diff.normalize();
        diff.div(d);    
        sum.add(diff);
      }
    return sum;
  }
  
  void keyPressed() {
    switch(key){
     case 'f':
       seekFood = true;
       break;
     default:
       seekFood = true;
       break;
    }
  }

  
    
  
  
}
