float t = 0; //<>// //<>// //<>// //<>//
float c_r = 35; // circle radius
float distance = 9;
int rings = 35;
float resolution = 400;
float angle = 360/resolution;
float s_vars = 0;
ArrayList<CV> original_circle = new ArrayList<CV>();

void setup() {
  size(1200, 900, P2D);
  //fullScreen(P2D);
  background(255);
  pixelDensity(2);
  smooth(8);
  randomSeed(27);
  //noiseDetail(200);
  noiseSeed(4);
  
  // create original circle.
  for (int i = 0; i<resolution; i++) {
    float xoff = map(noise(20+t), 0, 1, 0, 15);
    float yoff = map(noise(t), 0, 1, 0, 15);
    CV p = new CV();
    p.xoff = xoff;
    p.yoff = yoff;
    original_circle.add(p);
    t = t + .002;
  }
}

void draw() {
  background(247, 217, 184);
  float f_size = height/22.5;
  textSize(f_size);
  fill(175, 112, 56);
  textAlign(CENTER);
  textFont(createFont("courbd.ttf", 50));

  float f_yoff = height/15;
  text("tree", width/2, height-f_yoff);

  translate(width/2, height/2);



  for (int r=1; r <= rings; r++) {
    //for (int r=rings; r >= 1; r--) {
    //fill(247,217,184);
    noFill();
    stroke(175, 112, 56);
    strokeWeight(random(1, 2));

    if (r==rings) {
      scale(1.015);
      strokeWeight(random(6, 8));
    }

    beginShape();
    float r_noise = random(3, 8);
    for (int i = 0; i<resolution; i++) {

      float x_var = map(noise(s_vars+2), 0, 1, 0, 3);
      float y_var = map(noise(s_vars), 0, 1, 0, 3);
      s_vars += .1; // this is a secondary layer of noise
      //s_vars += map(mouseX, 0, width, .1, 20); // this is a secondary layer of noise

      original_circle.get(i).xoff += x_var ;
      original_circle.get(i).yoff += y_var ;

      float x = cos(radians(angle * i)) * (((c_r+r*distance)+r_noise) - original_circle.get(i).xoff);
      float y = sin(radians(angle * i)) * (((c_r+r*distance)+r_noise) - original_circle.get(i).yoff);
      vertex(x, y);

    }
    endShape(CLOSE);
  }
  noLoop();
}

class CV {
  float xoff = 0;
  float yoff = 0;
}