import processing.opengl.*;

/* UnderCurrents sketch, created for the atlas room, 2012
*  
*  The sketch contains a few components
*  SoundAnalyzer - breaks an incoming sound sample into frequencies returns an array of the amplitudes values at each frequency
*  NBitEncoderDecoder - defines a threshold value, any frequency with an amplitude above will be encoded as a 1 everything else a 0
                         the size of the string is dependent on the number of frequency bands analyzed
*                     - decodes an n bit string returning an array for each string in the file
*  Visualizer - uses the data in decoded n-bit string to generate a visualization
*/

BitEncoderDecoder b;
int ANALYZE_AUDIO = 0, STOP = -1, QUIT = -2, RENDER_ANALYSIS = 1;
int action = -1;
int num_bands = 100;
AudioAnalyzer audio;
float[] audiobuffer; 

float bg = 0, fg = 255, bg_op = 1, str_op = 10;
ArrayList world;

void setup(){
  //create audio analyzer
  audio = new AudioAnalyzer(this, dataPath("waves.mp3"), num_bands);
  //create output stream
  b = new BitEncoderDecoder(0.5, num_bands);
  size(720,720,OPENGL);    
}

void draw(){
  if (frameCount % 1000 == 0)
    println("frame: "+frameCount);
  Analyzer();
}

void AnalyzeAudio(){
  b.Encode(audio.Analyze());
}

void RenderWorld(){
  char[] carr;
  String buff = b.Decode();
  if (buff == null){
    println("finished");
    action = STOP;
    return;
  }
  //println(buff);  
  carr = buff.toCharArray();
  //translate to the centre
  translate(width/2, height/2);  
  CurvePart pt;
  for (int i = 0; i < world.size(); i++){
    if (carr[i] == '1'){  
      //println(i + ": "+carr[i]);       
      pt = (CurvePart)world.get(i);      
      pt.Update(frameCount);
      Render(pt.Point());      
    }   
  }  
}

void Render(PVector pt){
  //Grain();
  ellipse(pt.x, pt.y, 2, 2);   
}

void Analyzer(){
  if (action == RENDER_ANALYSIS){ 
    RenderWorld();
  }   
  if (action == ANALYZE_AUDIO){
    AnalyzeAudio();
  }
  if (action == QUIT){ 
    stop();
  } 
}

void InitWorld(){
  background(bg);
  smooth();
  frameRate(20);
  //initialize vectors
  float w = width, h = height;
  float px, py = 0;
  world = new ArrayList();
  float angle = 0, r = w/10;  
  for (int i=1;i<num_bands;i++){
    //px = (i * (width/num_parts) - width/2);
    px = r * cos(angle);
    py = r * sin(angle);
    world.add(new CurvePart(new PVector(px, py), width, height));
    angle+=TWO_PI/num_bands;
  }  
  //set stroke off
  noStroke();
  //set the foreground color with opacity
  fill(fg, str_op);    
}

void keyPressed(){
  if (key == 'c')
    saveFrame(dataPath("renders/sketch-#####.tif"));  
  if (key == 's'){
    audio.Stop();
    b.CloseStream();
    action = STOP;
  }
  if (key == 'a'){  
    action = ANALYZE_AUDIO;
    b.OpenWriteStream();  //open file for writing    
    audio.Start();    
  }
  if (key == 'q'){
    action = ANALYZE_AUDIO;
  }  
  if (key == 'r'){
    InitWorld();
    b.ReadFile(dataPath("waves-analysis.txt"));
    action = RENDER_ANALYSIS;    
  }   
}

void stop(){
  audio.Stop();
  audio.Cleanup();
  b.CloseStream();  
}
