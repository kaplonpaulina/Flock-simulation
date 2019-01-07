class Tuna extends Boid{
  ArrayList<Boid> boids; 
  boolean grabFood;
  
  Tuna(float x, float y, float random_size, float sm, float am, float cm, float n){
     super(x,
          y,   
          random(255), //kolor  
          random_size, //size        
          n,  //neighbours    
          1.7-(random_size/40), //max speed     
          0.04-(random_size/600),//max force          
          sm,//separation     
          am,//align         
          cm, //cohesion
          25.0f //desired separation 
          );
          grabFood = false;
  }
  
  
  
    
  void render() {

    float theta = velocity.heading2D() + radians(90);
    
    fill(204, boid_color, 0);
    stroke(204,boid_color);
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
    PVector noise = new PVector((random(2) - 1)/30, (random(2) -1)/30);
    PVector avoid = avoid(); 
    PVector escape = escape();
    
    sep.mult(separationmult);
    ali.mult(alignmult);
    coh.mult(cohesionmult);
    avoid.mult(3);
    escape.mult(5);
    
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(noise);
    applyForce(avoid);
    applyForce(escape);   
    
  }


}
