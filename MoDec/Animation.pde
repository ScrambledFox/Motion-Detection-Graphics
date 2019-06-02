class Animation {

  String type = "null";
  
  int cubeIndex;
  
  color idleColour;
  color activeColour;
  
  public Animation (int cubeIndex, String type) {
    this.cubeIndex = cubeIndex;
    this.type = type;
    
    Setup();
  }
  
  public void Setup(){
    int rand = (int)random(3);
    switch(rand){
      case 0:
        idleColour = #F505E9; 
        break;
      case 1:
        idleColour = #3205FF;
        break;
      case 2:
        idleColour = #05CBFF;
        break;
    }
    
    rand = (int)random(3);
    switch(rand){
      case 0:
        activeColour = color(255, 0, 0); 
        break;
      case 1:
        activeColour = color(0, 255, 0);
        break;
      case 2:
        activeColour = #FF9305;
        break;
    }
  }
  
  
  int intensity = 0;
  public void Draw(){
    pushStyle();
    
    switch(type){
      case "null":
        break;
      case "idle":
        noStroke();
        intensity = (int)(((sin(frameCount / 50f) + 1) / 2) * 255);
        fill(idleColour, intensity);
        rect(cubeIndex * width/4, 0, width/4, height);
        break;
      case "active":
        noStroke();
        intensity = (int)(((sin(frameCount / 2.5f) + 1) / 2) * 255);
        fill(activeColour, intensity);
        rect(cubeIndex * width/4, 0, width/4, height);
        break;
    }
    
    popStyle();
  }

}
