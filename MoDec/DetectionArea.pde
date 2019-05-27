class DetectionArea{

  int x, y;
  float size;
  
  int detections = 0;
  float threshold = 1;
  
  boolean active;
  
  public DetectionArea ( int x, int y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  public void Tick(){
    if (detections > threshold) active = true;
    else                        active = false;
    
    detections = 0;
  }

}
