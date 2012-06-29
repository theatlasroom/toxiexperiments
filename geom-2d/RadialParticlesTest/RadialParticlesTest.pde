import processing.opengl.*;

float x = 0, y = 0, new_x, new_y;
float r = 0;
float theta = 180;
float inc = 10;
float jittery = 0, jitterx = 0;
int lower_lim = 0, upper_lim = 360;
int col_val;
float r_val, g_val, b_val;
float bg_col = 0, stroke_col = 255, opacity = 20;

void setup(){
  frameRate(25);
  size(720, 480);
  r = 180;
  background(bg_col);
  fill(bg_col, opacity);  
  stroke(stroke_col);
  strokeWeight(0.5);
  smooth();  
  println("size: " + (width*height));
}

void draw(){
  if (theta > upper_lim || theta < lower_lim)
    ResetLimits();
 // println(theta);
  CalcNewValues();  
  Render();  
  UpdateVals();
}

void ResetLimits(){
  theta = 180;
  upper_lim = (int)random(270, 315);
  lower_lim = (int)random(45, 90);        
  inc = (int)random(-10, 10);
  inc = (inc == 0) ? 1 : inc;
  r=width/4+inc;
}

void CalcNewValues(){
  new_x = r * cos(theta);
  new_y = r * sin(theta);
  jitterx = random(-5, 5);
  jittery = random(-5, 5);
}

void UpdateVals(){
  theta+=inc;  
  x = new_x;
  y = new_y;   
}

void Render(){
  SetColours();  
  DrawGeometry();
  AnalogNoise();
 // ProcessPx();  
}

void SetColours(){
  fill(bg_col, opacity);  
  stroke(stroke_col);  
}

void AnalogNoise(){
  int parts = (int)random(5, 20);
  fill(stroke_col);
  float size_shape = 0;
  for (int i=parts-1;i>0;i--){
    point(random(width), random(height));
    size_shape = random(0, 50);
    if (i%10==0){
      //need to make jitterable objects that fade out over a few frames
      //basically objects with a lifetime, and a position, jitter the position each frame
      //update the internal frame counter in the object, then kill it off when necessary
      /*noFill(); 
      ellipse(random(width), random(height), size_shape, size_shape);
      fill(stroke_col);*/      
    } 
  }
}

void ProcessPx(){
  loadPixels();
  Flip();
  updatePixels();
}

void Flip(){
  for (int x = 0;x<width/2;x++){
    for (int y = 0;y<height;y++){    
      int curr = y*width+x; 
      int flipped = y*width+(width-1-x);      
      col_val = pixels[curr];      
      r_val = ((col_val >> 16) & 0xFF);  //shift the color integer values over 16 places to get the red channel
      g_val = ((col_val >> 8) & 0xFF);  //shift the color integer values over 8 places to get the green channel
      b_val = (col_val & 0xFF);  //do not shift for the blue, just and with the mask (compare binary values)
      int c = color(r_val, g_val, b_val);
      pixels[curr] = c;          //set the current pixel
      pixels[flipped] = c;       //set the mirrored pixel to the same value;
    }
  }    
}

void DrawGeometry(){  
  rect(0,0,width,height);
  pushMatrix();
  translate(width/2+jitterx, height/2+jittery);  
  //point(x+jittery/4, y+j);  
  line(x+jittery/4,y,new_x,new_y+jitterx/4);
  popMatrix();  
}
