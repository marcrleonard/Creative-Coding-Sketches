float t = 0; //<>// //<>//
float c_r = 25; // circle radius
float distance = 9;
int rings = 50;
float resolution = 400;
float angle = 360/resolution;

void setup() {
  size(900, 900, P2D);
  background(255);
  pixelDensity(2);
  smooth(8);
  randomSeed(27);
  //noiseDetail(200);
  noiseSeed(4);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  
  ArrayList<CV> original_circle = new ArrayList<CV>();
  
  float s_vars = 0;
  
  for (int i = 0; i<resolution; i++) {
    float xoff = map(noise(20+t), 0, 1, 0, 15);
    float yoff = map(noise(t), 0, 1, 0, 15);
    CV p = new CV();
    p.xoff = xoff;
    p.yoff = yoff;
    original_circle.add(p);
    t = t + .002;
  }

  for (int r=1; r <= rings; r++) {
    noFill();
    beginShape();
    float r_noise = random(3,8);
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
      
      

      //c_r = c_r + 5;
    }
    endShape(CLOSE);
  }
  noLoop();
}

class CV {
  float xoff = 0;
  float yoff = 0;
}