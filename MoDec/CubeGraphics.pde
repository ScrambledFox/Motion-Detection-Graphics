class CubeGraphics {

  int index = 0;
  
  int maxActiveFrames = 30 * 5;
  int activeFrames = maxActiveFrames;
  
  Animation currentAnimation;
  
  DetectionArea area;
  
  public CubeGraphics ( DetectionArea area, int index ) {
    this.area = area;
    this.index = index;
  }
  
  public void Tick() {
    if(currentAnimation == null) SetDefaultAnimation();
    if(area.active && currentAnimation.type == "idle") SetActiveAnimation();
    
    if(currentAnimation.type == "active") activeFrames--;
    if(activeFrames <= 0) {SetDefaultAnimation(); activeFrames = maxActiveFrames;}
    
    currentAnimation.Draw();
  }
  
  public void SetDefaultAnimation(){
    currentAnimation = new Animation(index, "idle");
  }
  
  public void SetActiveAnimation(){
    currentAnimation = new Animation(index, "active");
  }
  
}
