//import the math libraries required
import toxi.math.*;
import toxi.math.waves.*;
import toxi.math.noise.*;
//import the audio libraries required
import toxi.audio.*;

WaveGenerator waves;
//set the sampling frequency
int SAMPLE_FREQ = 44100;
float[] samples;
//create the buffer, source and joalutil objects
JOALUtil audio;
AudioBuffer buffer;
AudioSource source;

void setup(){
  //create the canvas
  size(768, 480);
  background(0);
  waves = new WaveGenerator();
  samples = new float[SAMPLE_FREQ];
  // init the audio library
  audio=JOALUtil.getInstance();
  audio.init();
  //set the framerate to 10
  frameRate(10);  
}

void draw(){  
  samples = waves.Sample();
  // convert raw signal into JOAL 16bit stereo buffer
  buffer=SynthUtil.floatArrayTo16bitStereoBuffer(audio,samples,SAMPLE_FREQ);
  // create a sound source, enable looping & play it
  source=audio.generateSource();
  source.setBuffer(buffer);
  //source.setLooping(true);
  source.play();   
}

void exit(){
  //this intercepts the exit method to ensure our memory is cleaned up
  println("Clean up the memory");
  waves = null; 
  super.exit();
}
