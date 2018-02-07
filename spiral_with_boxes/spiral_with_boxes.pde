import peasy.*;
import controlP5.*;
PeasyCam cam;
ControlP5 cp5;

int sliderValue = 100;
int sliderTicks1 = 100;
int sliderTicks2 = 30;
Slider abc;


ArrayList<PVector> shapes = new ArrayList<PVector>();

int resolution = 200;
int radius = 2;
float angle = 360/ resolution;

void setup() {
  size(1000, 1000, P3D);
  background(255);
  pixelDensity(2);
  //frameRate(200);
  smooth(8);

  cam = new PeasyCam(this, 100);
  
  cp5 = new ControlP5(this);
  
  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  //pushMatrix();
  //pushStyle();
  //cp5.addSlider("sliderValue")
  //   .setPosition(100,50)
  //   .setRange(0,255)
  //   ;
  //cp5.setAutoDraw(false);
  //popStyle();
  //popMatrix();
  

  float spiral = 1.0;

  //translate(width/2, height/2);
  //beginShape();
  for (int i = 0; i < 800 * 6; i++) {
    spiral += .1;


    float x = sin(radians(i * angle)) * (radius + spiral);
    float y = cos(radians(i * angle)) * (radius + spiral);


    PVector p = new PVector();
    p.x = x + (width/2);
    p.y = y + (height/2);
    p.z = random(0, sliderValue);
    //p.cv = fill(random(0, 255));

    shapes.add(p);



    //ellipse(x + (width/2), y + (height/2),5,5);
  }
  //endShape();

  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, width/height, cameraZ/100.0, cameraZ*10.0);
}


float noise_inc = .10;

void draw() {
  float a_l = 200;

  //pushStyle();
  //strokeWeight(1);
  //stroke(255, 0, 0);
  //line(-a_l, 0, 0, a_l, 0, 0);
  //stroke(0, 255, 0);
  //line(0, -a_l, 0, 0, a_l, 0);
  //stroke(0, 0, 255);
  //line(0, 0, -a_l, 0, 0, a_l);
  //popStyle();

  rotateX(radians(50));
  translate(300,height/4,0);
  for (PVector p : shapes) {

    pushMatrix();
    translate(p.x, p.y, p.z);
    fill(map(p.z, 10,30,0,255));
    box(4, 4, 4);
    popMatrix();
    
  }
  
  gui();
  println(frameRate);
  //noLoop();
}

void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}