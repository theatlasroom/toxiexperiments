import java.lang.Math.*;

class CurvePart {
  PVector p;
  float r, angle, inc, w, h;
  int regen_rate, dir;

  CurvePart(PVector p, float w, float h){
    this.w = w;
    this.h = h;
    this.p = new PVector(p.x, p.y);
    this.init();
  }  
  
  CurvePart(float w, float h){
    this.w = w;
    this.h = h;
    this.p = new PVector(random(-w/2,w/2), random(-h/2,h/2));
    this.init();    
  }
  
  void Update(int frame){
    //if (frame % this.regen_rate == 0)
    //  this.Regen();
    this.Calculate();  //calculate the new point    
  }
  
  void Calculate(){
    //float curr_x = p.x, curr_y = p.y;
    this.p.x += cos(r * noise(this.angle));
    this.p.y += sin(r * noise(this.angle));
    this.angle += inc;  
    this.angle = (this.dir == 1) ? this.angle + this.inc : this.angle - this.inc;    
  }
  
  PVector Point(){return this.p;}
  
  void Regen(){
    int divi = (int)random(360) + 1;
    this.r = random(this.w/2);  
    this.inc = random(-PI/360, PI/360);
    this.dir = (int)random(0,2);
    regen_rate = (int)random(360)+1;    
  }
  
  void init(){
    this.r = random(w/2);
    this.angle = random(-360, 360); 
    this.inc = random(-PI/360, PI/360);
    this.regen_rate = (int)random(100) + 1;
    this.dir = (int)random(0,2);
    //println(this.dir);    
  } 
}
