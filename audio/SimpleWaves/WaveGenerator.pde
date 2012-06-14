import toxi.math.waves.*;

class WaveGenerator {
  AbstractWave[] osc;
  int num_osc = 4;  //4 oscillators will be used
  int SAMPLE_FREQ = 44100;  //set the default sampling frequency to 44100 
  //this class will generate the waves
  //it will contain functions to process the waves into audio and video
  public WaveGenerator(){
    this.init(this.SAMPLE_FREQ, this.num_osc);  //use the default values
  }
  
  public WaveGenerator(int sample_freq, int num_osc){
    this.init(sample_freq, num_osc);
  }
  
    
  public float[] Sample(){   
    //this function populates a sample array and returns it
    //uses a default of 1 second as the sample length (1* the sample frequency)
    return this.Sample(1);
  }
  
  public float[] Sample(float sample_length){   
    //this function populates a sample array and returns it
    //the sample length determines how long the sound will play for (in seconds)
    int len = (int)(this.SAMPLE_FREQ * sample_length);
    //println("len is: " + len);
    float sample[] = new float[len];
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
    float phase = 0, amplitude = 1, offset = 0;
    return new SineWave(phase, freq, amplitude, offset); 
  }
  
  public void initOsc(){
    int freq = 0, freq_inc = (int)random(20), min_freq=10, max_freq=1000;  
    osc = new AbstractWave[this.num_osc*2];  //initialize the osc array
                                             //create double the amount to account for L/R
    println("Creating " + this.num_osc + " oscillators");
    for (int i=0;i<this.num_osc;i++){
      freq = (int)random(min_freq, max_freq);  //generate a random frequency
      osc[i] = this.Sine(freq);  //new sine wave with freq 1
      osc[i+1] = this.Sine(freq+1);//new sine wave with freq 2
      min_freq+=freq_inc;
      println("new freq " + freq);
    }
  }

  //private members / utils
  private void init(int sample_freq, int num_osc){
    this.SAMPLE_FREQ = sample_freq;
    this.num_osc = num_osc;
    this.initOsc();  //initialize the oscillators
  }
}
