class CubeGraphics {

  int index = 0;
  
  int intensity = 0;
  float fadeSpeed = 10f;
  
  DetectionArea area;
  
  public CubeGraphics ( DetectionArea area, int index ) {
    this.area = area;
    this.index = index;
  }
  
  public void Tick() {
    if(area.active) intensity = 255;
    if(intensity > 0) {
      intensity -= fadeSpeed;
      Draw();
    }
  }
  
  public void Draw () {
    pushStyle();
    //strokeWeight(10);
    //stroke(255, 0, 0, intensity);
    
    /*
    float y = (sin((frameCount / 50f) + index) / 2f + 1) * height - height / 2f;
    line(index * width / 5, y, width / 5 * (index + 1), y);
    */
    
    fill(255, intensity);
    rect(index * width / 5, 0 , width/5, height);
    
    popStyle();
  }
  
}
