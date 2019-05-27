import processing.video.*;

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
  int gridSize = 25;
  for(int x = gridSize/2; x < width; x += gridSize){
    for(int y = gridSize/2; y < height; y += gridSize){
      areasList.add(new DetectionArea(x, y, gridSize));
    }
  }
  
  DetectionArea[] areas = areasList.toArray(new DetectionArea[0]);
  
  motionDetection = new MotionDetection(new Capture(this, cameras[13]), areas);
  graphics = new CubeGraphics[1];
  graphics[0] = new CubeGraphics(areas[0]);
}

void draw(){
  background(0);
  
  motionDetection.Visualise();
  motionDetection.Detect();
  
  graphics[0].Tick();
}
