/**
 * AngleParticlesClass: particles for the angle paths class, each particle has a direction (angular) attribute as well as radius, based on the toxiclibs Vec2D class
 *
 * @author                 Ezekiel Kigbo <theatlasroom@gmail.com>
 * @version                0.1
 * @since                  2012-07-01
 */

import toxi.geom.*;
import toxi.math.*;

class AngleParticles {
  //private memb private Vec2D pos;
  private float radius, angle, min_radius = 1, max_radius = 10;
  private int direction;
  
  //default constructor, initializes with random values
  AngleParticles(){this.init(new Vec2D.randomVector(), random(-180, 180), random(min_radius, max_radius), (int)random(1));}    
  //parametized constructor     
  AngleParticles(Vec2D pos, float angle, float radius, int direction){this.init(pos, angle, radius, direction);}     
  
  //returns a 2d vector containing the position of this current particle
  Vec2D Position(){return this.pos;}
  
  //updates the cartesian position of the particle based on the new angle value
  void UpdatePosition(float angle){
    this.angle = angle
    //take a ne update the position of the particle accordingly
    float theta = radians(angle);
    float nx = r * cos(theta);
    float ny = r * sin(theta);
    this.pos = new Vec2D(nx, ny);      
  }
  
  //Regenerates all the parameters for this particle
  void Regenerate(){
    this.NewDirection();
    this.NewAngle();
    this.NewRadius();    
  }
  
  //generate a new direction   
  void NewDirection(){this.NewDirection((int)random(1)));
  void NewDirection(int direction){this.direction = direction;}   

  //generate a new angle   
  void NewAngle(){this.NewAngle(random(-180,180)));
  void NewAngle(float angle){this.angle = angle;}
  
  //generate a new radius   
  void NewRadius(){this.NewRadius(random(min_radius, max_radius)));
  void NewRadius(float radius){this.radius = radius;}  
     
  //private member functions
  
  /**
   * Initializes the values for the particle based on the values passed in from the relevant constructor
   *  
   */  
  private init(Vec2D pos, float angle, float radius, int direction){
    this.angle = angle;
    this.radius = radius;
    this.pos = pos;
    this.direction = direction;    
  } 
}


