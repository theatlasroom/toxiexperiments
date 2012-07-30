class BitEncoderDecoder {
  private float threshold=0;
  private int string_length = 0;
  private String output_file = "analysis.txt";
  private PrintWriter output;
  private String[] read_data;
  private int counter = 0, total_lines;  
  
  BitEncoderDecoder(float threshold, int string_length){
    this.threshold = threshold;
    this.string_length = string_length;
  }
  
  void OpenWriteStream(){
    try {      
      FileOutputStream file = new FileOutputStream(dataPath(this.output_file), false);
      output = createWriter(dataPath(this.output_file));    
    }
    catch (FileNotFoundException e){
      e.toString();
      println("bummmmmer dude");
      exit();
    }    
  }
  
  
  void ReadFile(String file){
    read_data = loadStrings(dataPath(file));
    this.total_lines = read_data.length;
    println(this.total_lines + " lines read");    
  }  
  
  void ReadFile(){
    read_data = loadStrings(dataPath(this.output_file));
    this.total_lines = read_data.length;
    println(this.total_lines + " lines read");    
  }
  
  void CloseStream(){
    output.flush();
    output.close();    
  } 
  
  void Encode(float[] data){
    String stream = "";
    for (int i=0;i<this.string_length;i++){
      if (data[i] > this.threshold)
        stream += "1";
      else
        stream += "0";
    } 
    output.println(stream);    
  }
  
  String Decode(){
    if (this.counter < this.total_lines){
      counter++;
      return this.read_data[counter-1];      
    }
    return null;
  }
}
