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
int ANALYZE_AUDIO = 0, STOP = -1, QUIT = -2, RENDER_ANALYSIS = 8;
int action = -1;
int num_bands = 100;
float[] audiobuffer; 

float bg_op = 1, str_op = 2;
color bg = 0, fg = color(245, 245, 232);
ArrayList world;
String file_loc;
float esize = 0;

void setup() {
  //create output stream
  frameRate(10);
  b = new BitEncoderDecoder(0.5, num_bands);
  size(3000, 3000, OPENGL);
  esize = width/100;
  file_loc = "render-7/";
}

void draw() {
  //Analyzer();
  fill(bg, 2);
  rect(0, 0, width, height);
  Analyzer();
  if (frameCount % 1000 == 0)
    Output();
}

void Output() {  
  saveFrame(file_loc+"frame-"+frameCount+".tif");
}


void RenderWorld() {
  //set the foreground color with opacity
  stroke(fg, str_op);  
  char[] carr;
  String buff = b.Decode();
  if (buff == null) {
    println("finished");
    action = STOP;
    return;
  }
  //println(buff);  
  carr = buff.toCharArray();
  //translate to the centre
  translate(width/2, height/2);  
  CurvePart pt;
  for (int i = 0; i < world.size(); i++) {
    if (carr[i] == '1') {  
      //println(i + ": "+carr[i]);       
      pt = (CurvePart)world.get(i);      
      pt.Update(frameCount);
      Render(pt.Point());
    }
  }
}

void Render(PVector pt) {
  //Grain();
  fill(fg, str_op);  
  point(pt.x, pt.y);
  //set fill off
  noFill();
  ellipse(pt.x, pt.y, esize, esize);
}

void Analyzer() {
  if (action == RENDER_ANALYSIS) { 
    RenderWorld();
  }
}

void InitWorld() {
  background(bg);
  smooth();
  //initialize vectors
  float w = width, h = height;
  float px, py = 0;
  world = new ArrayList();
  float angle = 0, r = w/10;  
  for (int i=1;i<num_bands;i++) {
    //px = (i * (width/num_parts) - width/2);
    px = r * cos(angle);
    py = r * sin(angle);
    world.add(new CurvePart(new PVector(px, py), width, height));
    angle+=TWO_PI/num_bands;
  }      
  RenderWorld();
}

void keyPressed() {
  if (key == 'c')
    Output();  
  if (key == 'r') {    
    InitWorld();
    b.ReadFile(dataPath("waves-analysis.txt"));
    action = RENDER_ANALYSIS;
    frameCount = 0;
  }
  if (key == 's') {    
    exit();
  }
}

