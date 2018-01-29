 //<>// //<>//
import peasy.PeasyCam;

float inc = .01;
PVector v;
PVector a;

float[] cp;

PeasyCam cam;

ArrayList<PVector> Locations = new ArrayList<PVector>();


void setup() {
  size(700, 700, P3D);
  //smooth(8);
  //randomSeed(20);

  pixelDensity(2);

  cam = new PeasyCam(this, 200);
  cam.setWheelScale(.1);
}


void draw() {

  background(255);
  stroke(0);
  
  translate(0,200,0);
  rotateX(radians(50));
  
  int sq = 100;
  int xscl = width/sq;
  int yscl = height/sq;

  float zoff = 2;
  float yoff = 2;

  for (int y =0; y<sq; y++) {
    float xoff = 2;
    for (int x = 0; x<sq; x++) {
      float nv = noise(xoff, yoff, zoff);
      float cv = map(nv, 0, 1, 0, 255);

      float zval = map(nv, 0, 1, 0, 300);


      //      a = new PVector();
      //      a.x = float(x);
      //      a.y = float(y);
      //      a.z = zval;


      pushMatrix();
      translate(x*xscl, y*yscl, zval);
      //noStroke();
      fill(cv, cv, cv);
      box(xscl/3, yscl/3, 10);
      popMatrix();

      xoff += inc;
    }
    yoff += inc;
    zoff += inc;
  }
  
}

void keyPressed() {
  if (key == 'q') {
    println("yo!");
    //cam.setState(CameraState state, long animationTimeInMillis);
  }
}