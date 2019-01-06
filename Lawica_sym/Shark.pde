class Shark extends Boid{
  ArrayList<Boid> boids; 
  float avoiddistance;
  
  Shark(float x, float y){
    super(x,
          y,   
          30, //kolor  
          17.0, //size        
          160,  //neighbours    
          1.6, //max speed     
          0.03,//max force          
          2,//separation     
          1,//align         
          2, //cohesion
          0.32 //desired separation 
          );
    avoiddistance = 80;
}
  
    
  void render() {

    float theta = velocity.heading2D() + radians(90);
    
    fill(0);
    stroke(0);
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
    PVector noise = new PVector((random(2) - 1)/100, (random(2) -1)/100);
    PVector avoid = avoid(); 
    
    
    sep.mult(separationmult);
    ali.mult(alignmult);
    coh.mult(cohesionmult);
    avoid.mult(6);
    
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(noise);
    applyForce(avoid);
    
  }




}
