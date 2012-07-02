/**
 * AnglePaths: test sketch running particles on paths of different angles
 *
 * @author                 Ezekiel Kigbo <theatlasroom@gmail.com>
 * @version                0.1
 * @since                  2012-06-29
 */
import processing.opengl.*;
import toxi.physics2d.*;
import toxi.geom.*;
import toxi.math.*;

int bg = 255;
int col = 0;
float opacity = 30;
Vec2D particle = new Vec2D();
float radius = 2;
float angle = 0;
int POS = 0, NEG = 1;
int dir = POS;
 
void setup(){
  frameRate(25);
  size(720, 480, OPENGL);
  background(bg);
  InitCanvas();  
}

void draw(){
  ResetCanvas();
  Update();
  Render();
}

void Update(){  
  UpdateWorld();
  particle = particle.add(NewPosition(particle, angle, radius));
}

void UpdateWorld(){
  UpdateDirection(); 
  UpdateAngle();
  UpdateRadius();
  println("dir " + dir);
  println("angle " + angle);
  println("radius " + radius);
}

void UpdateRadius(){
  float rad_update = random(-1, 1);
  println(rad_update);
  radius+=rad_update;
}
void UpdateAngle(){angle = (dir == POS) ? angle+1 : angle-1;}
void UpdateDirection(){
  if (angle >= 180){dir = NEG;}
  else if (angle <= -180){dir = POS;}
}

void ResetCanvas(){
  fill(bg, opacity);
  stroke(col);
  rect(0,0,width,height);  
}

void Render(){
  //render the particle, maybe an ellipse at the point of the particle
  translate(width/2, height/2-height/4);
  scale(0.25);
  fill(col);
  ellipse(particle.x, particle.y, 1, 1);
}

//initialize objects
void InitCanvas(){particle = new Vec2D(0, 0);}

