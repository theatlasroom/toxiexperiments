//Simple class for controlling the LaunchPad
//provides basic functionality

import com.rngtng.launchpad.*;

class SimpleLPadControl {
  private int curr_scene, scenes = 8, grids = 64;
  private byte[][] grid_state;  
  private final byte GRID_OFF=0, GRID_ON=1;
  private final int BUTTON_OFF = LColor.OFF, BUTTON_ON = LColor.GREEN_HIGH, SCENE_ON = LColor.YELLOW_HIGH, SEQ_SCENE = 0;
  private Launchpad pad;  
  
  SimpleLPadControl(Launchpad pad){
    this.pad = pad;   
    this.init();
  }

  public boolean[] SceneState(int x, int y){
    int index = this.GridIndex(x,y);
    return this.SceneState(index);
  }
  
  public boolean[] SceneState(int index){
    //returns the state of each scene at the given index
    //basically returns true or false to say if there is a light at the specified grid cell for each scene
    boolean[] res = new boolean[this.scenes];
    for (int i=this.scenes-1;i>0;i--)
      res[i] = (this.grid_state[this.curr_scene][index] == 0) ? false : true;
    return res;
  }
  
  public void ToggleGrid(int x, int y){    
    //toggle the state of the grid cell
    int index = this.GridIndex(x, y);
    byte new_state = (this.grid_state[this.curr_scene][index] == 0) ? GRID_ON : GRID_OFF;
    int new_col = (new_state == GRID_ON) ? BUTTON_ON : BUTTON_OFF;  //get the new colour for the grid
    this.grid_state[this.curr_scene][index] = new_state;  //set the new state of the cell
    this.pad.changeGrid(x, y, new_col);  //change the colour of the grid
  }  
  
  public void ChangeGrid(int x, int y, int curr_state){
    int new_grid_col = (curr_state == 1) ? LColor.GREEN_HIGH : LColor.OFF;  //set the color to off if the state is 0        
    this.pad.changeGrid(x, y, new_grid_col);        //change the color;    
  }
  
  public void ChangeScene(int button){
    //set the new scene of the 
    this.pad.changeSceneButton(this.curr_scene+1, this.BUTTON_OFF);//set the current scene colour to off
    this.curr_scene = this.SceneNum(button);  
    this.RefreshGrid(); //refresh the grid based on the states of grid in the new scene    
    this.pad.changeSceneButton(this.curr_scene+1, this.SCENE_ON);//set the colour of the new scene button
  }
  
  //simple setters
  
  //simple getters
  public int GridIndex(int x, int y){return 8*y+x;}  //calculate the single grid index for the xy coords passed in
  public int CurrentScene() {return this.curr_scene;} //returns the current scene
  public boolean isGridActive(int x, int y){return (this.GridState(x,y) == 0) ? false : true;}  //reutns a true or false indicator if to indicate if this grid cell is active
  private int GridState(int x, int y){return this.grid_state[this.curr_scene][this.GridIndex(x, y)];} 
  
  //public utils
  public void ResetGrid(){
    this.curr_scene = 0;   //default to the sequencer scene    
    this.pad.testLeds();  //test all the leds  
    this.pad.reset();     //reset all the leds 
  }
  
  public void RefreshGrid(){
    int index = 0;
    //refreshes the grid based on the states of the new scene
    for (int i=0;i<8;i++){
      for (int j=0;j<8;j++){
        index = this.GridIndex(i, j);
        this.ChangeGrid(i, j, this.grid_state[this.curr_scene][index]);
      }      
    }    
  }
  
  //private memeber functions / utils
  private void init(){
    this.ResetGrid(); //Reset the grid 
    //initialize the data within the class
    grid_state = new byte[this.scenes][this.grids];
    //initialize the grid spaces to OFF
    for (int i=0;i<this.scenes;i++){
      for (int j=0;j<this.grids;j++){
        grid_state[i][j] = GRID_OFF;
      }
    }
    this.ChangeScene(LButton.SCENE1);  //set the current scene to the initial scene    
  }
  
  private int SceneNum(int scene) {
    int new_scene = -1;
    //query for a particular scene, the scene number is passed and the related index is returned
    switch(scene){   
      case LButton.SCENE1:
        new_scene = 0;
        break;   
      case LButton.SCENE2:
        new_scene = 1;
        break;   
      case LButton.SCENE3:
        new_scene = 2;
        break;   
      case LButton.SCENE4:
        new_scene = 3;
        break;   
      case LButton.SCENE5:
        new_scene = 4;
        break;  
      case LButton.SCENE6:
        new_scene = 5;
        break;   
      case LButton.SCENE7:
        new_scene = 6;
        break;  
      case LButton.SCENE8:
        new_scene = 7;
        break;            
      default:
        new_scene = SEQ_SCENE;
        break;
    }
    return new_scene;
  }  
  
   //Utility functions / testers
  private int StepX(int step){
    //takes a single value index of the current step, returns the x-grid position
    return step%8;
  }
  
  private int StepY(int step){
    //takes a single value index of the current step, returns the y-grid position
    return (int)step/8;
  } 
  
  private void CleanUp(){
    //forcibly cleans up all the objects that are created within this objects
    this.pad.reset();
    this.pad = null;    
  }
}
