  //import processing.opengl.*; 
//import the math libraries required
import toxi.math.*;
import toxi.math.waves.*;
import toxi.math.noise.*;
//import the audio libraries required
import toxi.audio.*;

/*
* Sketch: lpadwaves
* this is a sketch to test the waves tool in toxilibs
* the sketch will use the launchpad to create waves of different frequencies
* audio and visual representations of the waves will be created
*/

SimpleLPadControl spad;
WaveGenerator waves;
//set the sampling frequency
int SAMPLE_FREQ = 44100, step = 0, max_steps = 64;
float[] samples;
//create the buffer, source and joalutil objects
JOALUtil audio;
AudioBuffer buffer;
AudioSource source;

void setup(){
  smooth();
  //create the canvas
  size(768, 480);
  background(0);
  //create a new launchpad object and pass to te simplelpadcontrol object
  Launchpad pad = new Launchpad(this);
  spad = new SimpleLPadControl(pad);
  pad = null;
  waves = new WaveGenerator();
  samples = new float[SAMPLE_FREQ];
  // init the audio library
  audio=JOALUtil.getInstance();
  audio.init();
  //set the framerate to 10
  frameRate(10);  
}

void draw(){  
  //send the state information to the wave processors
  samples = waves.Process(spad.SceneState(step));
  //samples = waves.Sample();
  // convert raw signal into JOAL 16bit stereo buffer
  buffer=SynthUtil.floatArrayTo16bitStereoBuffer(audio,samples,SAMPLE_FREQ);
  // create a sound source, enable looping & play it
  source=audio.generateSource();
  source.setBuffer(buffer);
  //source.setLooping(true);
  source.play();   
  //if the current step is less than the max, then increment, otherwise reset 
  step = (step < max_steps-1) ? step+1 : 0;
  Render(samples);
}

void Render(float[] samples){
  noStroke();
  background(0);
  fill(100);
  float val = 0, e_size;
  for (int i=samples.length-1;i>0;i-=100)
    val += samples[i];
  e_size = val * 100;
  ellipse(width/2+random(0, 10), height/2+random(0, 10), e_size, e_size);
}

void launchpadButtonPressed(int buttonCode){
}  

void launchpadSceneButtonPressed(int buttonCode){
  spad.ChangeScene(buttonCode);  //call the change scene function
}  

void launchpadGridPressed(int x, int y){  
  spad.ToggleGrid(x, y);  //call the change grid function  
} 

void exit(){
  //this intercepts the exit method to ensure our memory is cleaned up
  println("Clean up the memory");
  spad.CleanUp();
  spad = null; 
  waves = null; 
  super.exit();
}
