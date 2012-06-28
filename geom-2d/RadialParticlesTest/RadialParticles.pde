import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

/**
 * RadialParticles: A class for for particles that move in a radial trajectory
 *
 * @author                 Ezekiel Kigbo <theatlasroom@gmail.com>
 * @version                0.1
 * @since                  2012-06-29
 * 
 */

class RadialParticles {
  //all rendering will be handled by a seperate class / object
  private int dir = -1;  //horizontal and vertical directions
  private final static int UP_LEFT=0, UP_RIGHT =1, DOWN_LEFT=2, DOWN_RIGHT=3;
  private int num_particles = 50;   //default to 50 particles
  private ArrayList world;
  private int[] direction, radii;

  RadialParticles(){this.init(this.num_particles);}  //use the default number of particles
  RadialParticles(int num_particles){this.init(num_particles);}  //user overrides number of particles
 
    
  /**
   * updates the values of each particle in the world
   * @return returns a toxiclibs ArrayList object representing the world
   */
  public ArrayList UpdateWorld(){
    return this.world;
  }
  
  /**
   * generates the next position for the current particle, position is dependent on the direction and radius of the particles path
   * @param curr_pos current position of the object (x, y)
   * @param curr_index index of the current particle (relates to the radii and direction values to be used)
   * @return returns a toxiclibs Vec2D object
   */  
  public Vec2D NextPosition(Vec2D curr_pos, int curr_index){
    Vec2D dir = this.Direction(this.direction[curr_index]);    //get the direction of this index
    int r = this.radii[curr_index];                            //get the radii of this index
    //return new Vec2D(r * sin(
    return new Vec2D();
  }
  
  /**
   * returns the vector for the direction requested
   * @param direction a integer indicating the direction the particle moves in
   * @return returns a toxiclibs Vec2D object
   */  
  public Vec2D Direction(int direction){
    Vec2D v;
    switch(direction){
      case 0: v = new Vec2D(-1, -1); break;  //move up and to the left
      case 1: v = new Vec2D(1, -1); break;   //move up and to the right
      case 2: v = new Vec2D(-1, 1); break;   //move down and to the left
      case 3: v = new Vec2D(1, 1); break;    //move down and to the right      
      default: v = new Vec2D(0, 0); break; //don't move
    }
    return v;
  } 
  
  /**
   * returns the world object
   */
  public ArrayList World(){return this.world;} 
  
  //private / utility methods
  /**
   * method initializes an instance of the class
   * @param num_particles number of particles to use
   */
  private void init(int num_particles){
    this.num_particles = num_particles; 
    this.CreateWorld();
  }

  /**
   * resets the direction and radii of the path the particles travel along
   */  
  private void Reset(){
    this.direction = new int[num_particles];
    this.radii = new int[num_particles];  
    for (int i=num_particles-1;i>0;i--){
      direction[i] = (int)random(0, 3);
      radii[i] = (int)random(0, width/2);      
    }    
  }
  
  /**
   * create the world that the particles will exist in
   */
  private void CreateWorld(){    
    this.world = new ArrayList();
    this.Populate();   
    this.Reset();     
  }
    
  /**
   * create a new particle, add it into the world
   */
  private void NewParticle(){
    Vec2D p = new Vec2D(Vec2D.randomVector());
    this.world.add(p);
  } 
   
  /**
   * populate the world with particles
   */ 
  private void Populate(){
    while (world.size() < num_particles)
      NewParticle();
  }
}
