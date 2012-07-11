import processing.core.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

class LiveAudio {
  private Minim minim;
  private FFT fft;
  private AudioInput in;
  private int freq;
  private float[] buffer;  
  
  LiveAudio(PApplet parent, int freq){
    this.freq = freq;
    // always start Minim first!
    minim = new Minim(parent);
    minim.debugOn();  
    // specify 512 for the length of the sample buffers
    // the default buffer size is 1024
    in = minim.getLineIn(Minim.STEREO, 512);
    // an FFT needs to know how long the audio buffers it will be analyzing are
    // and also needs to know the sample rate of the audio it is analyzing
    fft = new FFT(in.bufferSize(), in.sampleRate());
    fft.linAverages(this.freq);
    buffer = new float[this.freq];     
  }
  
  float[] Analyze(){
    //perform forward analysis
    this.fft.forward(in.mix);  
    for (int i=0;i<this.freq;i++)
      this.buffer[i] = this.fft.getAvg(i);
    println("New array: " + Arrays.toString(buffer));
    return this.buffer;    
  }
  
  void stop(){
    //always close Minim audio classes when you are done with them
    in.close();
    minim.stop();      
  }
}
