import toxi.math.waves.*;

class WaveGenerator {
  AbstractWave[] osc;
  int num_osc = 8;  //4 oscillators will be used
  int min_sample_len = 2;   //default the sample buffer to 2 x the numb
  int SAMPLE_FREQ = 44100;  //set the default sampling frequency to 44100 
  //this class will generate the waves
  //it will contain functions to process the waves into audio and video
  public WaveGenerator(){
    this.init(this.SAMPLE_FREQ, this.num_osc);  //use the default values
  }
  
  public WaveGenerator(int sample_freq, int num_osc){
    this.init(sample_freq, num_osc);
  }
  
  public float[] Process(boolean[] osc_state){
    //take the index and update only oscillators that are active
    //this function populates a sample array and returns it
    //the sample length determines how long the sound will play for (in seconds)
    int len = (int)(this.SAMPLE_FREQ * this.min_sample_len);
    float sample[] = new float[len];
    //println("sample len " + len);
    for (int i=0;i<len;i+=this.num_osc){
      for(int j=0;j<this.num_osc;j++){
        //if the oscillator state is true, then update, otherwise set it to 0
        sample[i+j] = (osc_state[j]) ? osc[j].update() : 0;          
      }
    } 
    return sample;    
  }
  
    
  public float[] Sample(){   
    //this function populates a sample array and returns it
    //uses a default of 1 second as the sample length (1* the sample frequency)
    return this.Sample(this.min_sample_len);
  }
  
  public float[] Sample(float sample_length){   
    //this function populates a sample array and returns it
    //the sample length determines how long the sound will play for (in seconds)
    int len = (int)(this.SAMPLE_FREQ * sample_length);
    float sample[] = new float[len];
    //println("sample len " + len);
    for (int i=0;i<len;i+=this.num_osc){
      for(int j=0;j<this.num_osc;j++){
        sample[i+j] = osc[j].update();
      }
    } 
    return sample;
  }
  
  public AbstractWave Sine(float freq){
    //take the frequency as a value in radians
    //this function creates and returns a new sine wave 
    freq = AbstractWave.hertzToRadians(freq, this.SAMPLE_FREQ);  
    float phase = 0, amplitude = 0.5, offset = 0;
    return new SineWave(phase, freq, amplitude, offset); 
  }
  
  public void initOsc(){
    int freq = 0, max_freq = 1000, min_freq = 10;  
    osc = new AbstractWave[this.num_osc*2];  //initialize the osc array
    println("Creating " + this.num_osc + " oscillators");
    for (int i=0;i<this.num_osc;i++){
      freq = (int)random(min_freq, max_freq);  //generate a random frequency
      osc[i] = this.Sine(freq);  //new sine wave with freq 1
      osc[i+1] = this.Sine(freq/2);//new sine wave with freq 2
    }
  }

  //private members / utils
  private void init(int sample_freq, int num_osc){
    this.SAMPLE_FREQ = sample_freq;   
    this.num_osc = num_osc;
    this.min_sample_len = (int)this.num_osc/2;    
    this.initOsc();  //initialize the oscillators
  }
}
