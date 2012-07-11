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
AnglePaths paths;
 
void setup(){
  frameRate(25);
  size(720, 480, OPENGL);
  background(bg);
  paths = new AnglePaths(50);
}

void draw(){
  ResetCanvas();
  Update();
  //Render();
}

void Update(){  
  paths.UpdateWorld();
  Render(paths.World());
}

void ResetCanvas(){
  fill(bg, opacity);
  stroke(col);
  rect(0,0,width,height);  
}

void Render(ArrayList world){
  //render the particle, maybe an ellipse at the point of the particle
  translate(width/2, height/2);
  //scale(0.5);
  //scale(1);
  fill(col);
  for (Object p : world){
    AngleParticles part = (AngleParticles)p;
    Vec2D vp = part.Position();
    ellipse(vp.x, vp.y, 1, 1);
  }
}


