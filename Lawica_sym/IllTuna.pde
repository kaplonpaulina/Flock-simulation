class IllTuna extends Boid{
  ArrayList<Boid> boids; 
  
  IllTuna(float x, float y, float random_size){
     super(x,
          y,   
          0, //kolor  
          random_size, //size        
          200,  //neighbours    
          0.8, //max speed     
          0.04,//max force          
          1,//separation     
          1,//align         
          0.8, //cohesion
          25.0f //desired separation 
          );
  }
    
  void render() {

    float theta = velocity.heading2D() + radians(90);
    
    fill( 0, 0);
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
  
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids); 
    PVector ali = align(boids);      
    PVector coh = cohesion(boids);
    PVector noise = new PVector((random(2) - 1)/80, (random(2) -1)/80);
    PVector avoid = avoid(); 
    PVector escape = escape();
    
    
    sep.mult(separationmult);
    ali.mult(alignmult);
    coh.mult(cohesionmult);
    avoid.mult(3);
    
    escape().mult(5);
    
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(noise);
    applyForce(avoid);
    applyForce(escape);
    
  }
  
  




}
