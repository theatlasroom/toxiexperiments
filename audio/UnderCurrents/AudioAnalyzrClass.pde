import processing.core.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

class AudioAnalyzer {  
  private Minim minim;
  private AudioPlayer song;
  private FFT fft;
  private String song_file = "";
  private int freq;
  private float[] buffer;
 
  AudioAnalyzer(PApplet parent, String song_file, int freq){
    this.song_file = song_file;
    this.freq = freq;
    // always start Minim first!
    this.minim = new Minim(parent);
    // specify 512 for the length of the sample buffers
    // the default buffer size is 1024
    this.song = minim.loadFile(this.song_file, 512);
    // an FFT needs to know how long the audio buffers it will be analyzing are
    // and also needs to know the sample rate of the audio it is analyzing
    this.fft = new FFT(this.song.bufferSize(), this.song.sampleRate());
    //sfft.window(FFT.HAMMING);    
    fft.linAverages(this.freq);
    this.buffer = new float[this.freq];  
  } 
  
  float[] Analyze(){
    //perform forward analysis
    this.fft.forward(this.song.mix);
    int avg_size = fft.avgSize();  
    for (int i=0;i<avg_size;i++)
      this.buffer[i] = this.fft.getAvg(i) * 5;
    //println(Arrays.toString(buffer));    
    return this.buffer;
  }
  void Start(){song.play();}
  void Stop(){song.pause();}  
 
  void Cleanup(){
    //clean up objects created;
    this.fft = null;
    this.song.close();
    this.minim.stop();    
  } 
}
