class MotionDetection {

  Capture cam;
  PImage prev;
  
  DetectionArea[] detectionAreas;
  
  boolean doVisualisation = false;
  
  PImage difference;
  
  //int pixelsDetected;
  
  public MotionDetection ( Capture cam, DetectionArea[] detectionAreas ) {
    this.cam = cam;
    this.detectionAreas = detectionAreas;
    
    //this.cam.start();
    prev = createImage(width, height, RGB);
    difference = createImage(width, height, RGB);
  }
  
  public void Detect () {
    if(this.cam.available()){
      prev.copy(cam, 0, 0, this.cam.width, this.cam.height, 0, 0, prev.width, prev.height);
      prev.updatePixels();
    
      this.cam.read();
    }
    
    difference.loadPixels();
    this.cam.loadPixels();
    prev.loadPixels();
    
    float threshold = 4000;
    
    for(int x = 0; x < this.cam.width; x++){
      for(int y = 0; y < this.cam.height; y++){
        int i = x + y * this.cam.width;
        
        color currentColour = this.cam.pixels[i];
        float r1 = red(currentColour);
        float g1 = green(currentColour);
        float b1 = blue(currentColour);
        color prevColour = prev.pixels[i];
        float r2 = red(prevColour);
        float g2 = green(prevColour);
        float b2 = blue(prevColour);
        
        float d = DistSq3D(r1, g1, b1, r2, g2, b2);
        if (d < threshold) {
          if (doVisualisation) difference.pixels[i] = color(0);
        }
        else {
          if (doVisualisation) difference.pixels[i] = color(255);
          
          DetectionArea area = GetDetectionArea(x, y);
          if (area != null) area.detections++;
        }
      }
    }
    
    difference.updatePixels();
    this.cam.updatePixels();
    prev.updatePixels();
    
    if(doVisualisation) image(difference, 0, 0);
    
    for(int k = 0; k < detectionAreas.length; k++){
      detectionAreas[k].Tick();
      
      if(doVisualisation){
        RenderDetectionFrame(detectionAreas[k]);
      }
    }
    
    doVisualisation = false;
  }
  
  public void Visualise () {
    doVisualisation = true;
  }
  
  public float DistSq3D (float x1, float y1, float z1, float x2, float y2, float z2) {
    return (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1); 
  }
  
  public float DistSq2D (float x1, float y1, float x2, float y2) {
    return (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1); 
  }
  
  public boolean LiesWithinArea(int px, int py, int ax, int ay, float size){
    return (px >= ax - size/2f && px <= ax + size/2f) &&
           (py >= ay - size/2f && py <= ay + size/2f);
  }
  
  public DetectionArea GetDetectionArea (int x, int y) {
    for(int i = 0; i < detectionAreas.length; i++){
      //if (DistSq2D(detectionAreas[i].x, detectionAreas[i].y, x, y) < detectionAreas[i].size * detectionAreas[i].size){
      if (LiesWithinArea(x, y, detectionAreas[i].x, detectionAreas[i].y, detectionAreas[i].size)) {
        return detectionAreas[i];
      }
    }
    
    return null;
  }
  
  public void RenderDetectionFrame( DetectionArea area ){
    pushStyle();
    ellipseMode(CENTER);
    rectMode(CENTER);
    noFill();
    strokeWeight(1);
    
    if(area.active) stroke(0, 255, 0);
    else            stroke(255, 0, 0);
    
    //ellipse(area.x, area.y, area.size, area.size);
    rect(area.x, area.y, area.size - 1, area.size - 1);
    
    popStyle();
  }
}
