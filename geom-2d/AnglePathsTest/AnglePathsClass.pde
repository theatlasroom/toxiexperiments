/**
 * AnglePathsClass:  interface to interact with angle particles in the world
 *
 * @author                 Ezekiel Kigbo <theatlasroom@gmail.com>
 * @version                0.1
 * @since                  2012-07-01
 */

import toxi.physics2d.*;
import toxi.geom.*;
import toxi.math.*;

class AnglePaths {
  private ArrayList world;
  private int particles = 1;
  private float angle = 0;
  private int count = 0;
  
  AnglePaths(){this.init();}
  AnglePaths(int particles){this.particles=particles;this.init();}  
  
  /**
   * returns the world object
   */
  public ArrayList World(){return this.world;}
  
  public void UpdateWorld(){
    this.UpdateAngle();
    for (Object part : this.world){
      AngleParticles p = (AngleParticles)part;
      p.UpdatePosition(this.angle-180);
    }
  }
  
  public void UpdateAngle(){
    angle = (angle < 360) ? angle+1 : 0;
    if (count % 20 == 0)
      angle = random(360);
    count++;
  }
  
  //private member functions
  void init(){
    this.world = new ArrayList();
    this.angle = 0;
    //initialize the world
    for (int i = this.particles;i>0;i--)
      this.world.add(new AngleParticles());    
  } 
}
