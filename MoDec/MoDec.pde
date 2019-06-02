import spout.*;
import processing.video.*;

Spout spout;

Capture cam;

ArrayList<DetectionArea> areasList = new ArrayList<DetectionArea>();
MotionDetection motionDetection;
CubeGraphics[] graphics;

boolean active;

void setup(){
  size(800, 600);
  background(0);
  frameRate(30);
  
  String[] cameras = Capture.list();
  
  for(int i = 0; i < cameras.length; i++){
    println("[" + i + "] " + cameras[i]);
  }
  
  cam = new Capture(this, cameras[21]);
  cam.start();
  
  /*
  ArrayList<DetectionArea> areasList = new ArrayList<DetectionArea>();
  for(int x = width/10; x < width; x += width/5f){
    areasList.add(new DetectionArea(x, height/2, width/5f));
  }
  
  DetectionArea[] areas = areasList.toArray(new DetectionArea[0]);
  
  motionDetection = new MotionDetection(new Capture(this, cameras[21]), areas);
  
  graphics = new CubeGraphics[5];
  graphics[0] = new CubeGraphics(areas[0], 0);
  graphics[1] = new CubeGraphics(areas[1], 1);
  graphics[2] = new CubeGraphics(areas[2], 2);
  graphics[3] = new CubeGraphics(areas[3], 3);
  graphics[4] = new CubeGraphics(areas[4], 4);
  
  */
  
  //spout = new Spout(this);
  //spout.createSender("Provada_Cubes");
}

boolean Mouse = false;
void draw(){
  background(0);

  if(active){
    motionDetection.Visualise();
    motionDetection.Detect();
  
    graphics[0].Tick();
    graphics[1].Tick();
    graphics[2].Tick();
    graphics[3].Tick();
  } else {
    
    if(cam.available()){
      cam.read();
    }
    
    cam.loadPixels();
    image(cam, 0, 0);
    cam.updatePixels();
    
    if(areasList.size() >= 4){
      motionDetection = new MotionDetection(cam, areasList.toArray(new DetectionArea[0]));
      
      graphics = new CubeGraphics[4];
      for(int i = 0; i < graphics.length; i++){
        graphics[i] = new CubeGraphics(areasList.get(i), i);
      }
      
      active = true;
    }
    
    for(int i = 0; i < areasList.size(); i++){
      pushStyle();
      
      fill(255, 0, 0);
      noStroke();
      ellipse(areasList.get(i).x, areasList.get(i).y, areasList.get(i).size, areasList.get(i).size);
      
      popStyle();
    }
  }
  
  //spout.sendTexture();
}

void mouseClicked(){
  if(!active){
    areasList.add(new DetectionArea(mouseX, mouseY, 50));
  }
}
