class CubeGraphics {

  DetectionArea area;
  
  public CubeGraphics ( DetectionArea area ) {
    this.area = area;
  }
  
  public void Tick() {
    if(area.active) Draw();
  }
  
  public void Draw () {
    pushStyle();
    
    noStroke();
    fill(255);
    rect(0, 0, 200, 200);
    
    popStyle();
  }
  
}
