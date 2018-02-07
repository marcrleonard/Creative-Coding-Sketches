import peasy.PeasyCam; //<>//

float yoff = 0;

float inc = .01;
PVector v;
PVector a;

int a_l = 20;

float[] cp;

PeasyCam cam;

//ArrayList<PVector> Locations = new ArrayList<PVector>();
ArrayList<Item> Locations = new ArrayList<Item>();


PImage photo;

int sq = 100;
int xscl = int(width/sq);
int yscl = int(height/sq);

void setup() {
  size(1200, 800, P3D);
  //smooth(8);
  //randomSeed(20);
  noiseSeed(2);

  pixelDensity(2);

  cam = new PeasyCam(this, 200);
  //cam.setWheelScale(.2);

  photo = loadImage("tree.png");
  
  //float fov = PI/3.0;
  //float cameraZ = (height/2.0) / tan(fov/2.0);
  //perspective(fov, width/height, cameraZ/100.0, cameraZ*10.0);

  float zoff = 2;
  for (int y =0; y<sq; y++) {
    float xoff = 2;
    for (int x = 0; x<sq; x++) {
      Item i = new Item();

      float nv = noise(xoff, yoff, zoff);

      float z_height = 300;

      float z = map(nv, 0, 1, 0, z_height);
      if (z > z_height * .5) {
        int show_tree = int(random(1, 20));
        if (show_tree == 2) {
          i.i = true;
        }
      }

      i.x = x;
      i.y = y;
      i.z = z;

      Locations.add(i);

      xoff -= inc;
    }

    yoff += inc;
  }
}


void draw() {

  background(255);

  pushStyle();
  strokeWeight(1);
  stroke(255, 0, 0);
  line(-a_l, 0, 0, a_l, 0, 0);
  stroke(0, 255, 0);
  line(0, -a_l, 0, 0, a_l, 0);
  stroke(0, 0, 255);
  line(0, 0, -a_l, 0, 0, a_l);
  popStyle();


  translate(0,150, -sq);
  rotateX(radians(90));
  //rotateY(frameCount);
  beginShape(POINTS);
  for (Item i : Locations) {
    vertex(i.x, i.y, i.z);
    
  }
  endShape();
  
  for (Item i : Locations) {
    if (i.i) {
      float image_scale = .006;
      pushMatrix();
      translate(i.x * xscl, i.y * yscl, i.z + photo.height*image_scale);
      scale(image_scale);
      rotateX(radians(270));
      image(photo, 0, 0);
      popMatrix();
    }
  }

}

class Item {
  float x;
  float y;
  float z;

  boolean i = false;
}