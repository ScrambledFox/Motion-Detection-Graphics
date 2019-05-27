import spout.*;
import processing.video.*;

Spout spout;

MotionDetection motionDetection;
CubeGraphics[] graphics;

void setup(){
  size(960, 540);
  background(0);
  frameRate(60);
  
  String[] cameras = Capture.list();
  
  for(int i = 0; i < cameras.length; i++){
    println("[" + i + "] " + cameras[i]);
  }
  
  ArrayList<DetectionArea> areasList = new ArrayList<DetectionArea>();
  for(int x = width/10; x < width; x += width/5f){
    areasList.add(new DetectionArea(x, height/2, width/5f));
  }
  
  DetectionArea[] areas = areasList.toArray(new DetectionArea[0]);
  
  motionDetection = new MotionDetection(new Capture(this, cameras[13]), areas);
  graphics = new CubeGraphics[5];
  graphics[0] = new CubeGraphics(areas[0], 0);
  graphics[1] = new CubeGraphics(areas[1], 1);
  graphics[2] = new CubeGraphics(areas[2], 2);
  graphics[3] = new CubeGraphics(areas[3], 3);
  graphics[4] = new CubeGraphics(areas[4], 4);
  
  //spout = new Spout(this);
  //spout.createSender("Provada_Cubes");
}

void draw(){
  background(0);
  
  motionDetection.Visualise();
  motionDetection.Detect();
  
  graphics[0].Tick();
  graphics[1].Tick();
  graphics[2].Tick();
  graphics[3].Tick();
  graphics[4].Tick();
  
  //spout.sendTexture();
}
