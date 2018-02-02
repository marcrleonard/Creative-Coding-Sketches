//<>// //<>//
import peasy.PeasyCam;

float yoff = 0;

float inc = .02;
PVector v;
PVector a;

float[] cp;

PeasyCam cam;

ArrayList<PVector> Locations = new ArrayList<PVector>();


PImage photo;



void setup() {
  size(1200, 800, P3D);
  //smooth(8);
  //randomSeed(20);
  noiseSeed(2);

  pixelDensity(2);

  cam = new PeasyCam(this, 200);
  cam.setWheelScale(.2);
  
  photo = loadImage("tree.png");
}


void draw() {
  
  
  
  background(255);
  stroke(0);

  translate(-width/2, -20, -1000);
  rotateX(radians(65));

  int sq = 200;
  int xscl = width/sq;
  int yscl = height/sq;

  

  //yoff += .08;
float zoff = 2;
  for (int y =0; y<sq; y++) {
    float xoff = 2;
    for (int x = 0; x<sq; x++) {
      float nv = noise(xoff, yoff, zoff);
      float cv = map(nv, 0, 1, 0, 255);

      float zval = map(nv, 0, 1, 0, 300);
      
      int show_tree = int(random(1,100));
      
      float no = 0;
      pushMatrix();
      translate(x*xscl + no, y*yscl + no, zval);
      
      if (show_tree == 2) {
        pushMatrix();
        scale(.05);
        rotateX(radians(-90));
        image(photo, 0, 0);
        popMatrix();
      }
      
      //noStroke();
      fill(255, 255, 255);
      //fill(cv, cv, cv);
      //box(xscl/3, yscl/3, 10);
      point(0, 0, 0);
      popMatrix();

      xoff -= inc;
    }

    zoff += inc;
  }
  yoff += .006;
  println(frameRate);
}

//void keyPressed() {
//  if (key == 'q') {
//    println("yo!");
//    //cam.setState(CameraState state, long animationTimeInMillis);
//  }
//}