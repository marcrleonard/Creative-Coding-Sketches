ArrayList<PVector> points = new ArrayList<PVector>();
float num_p = 200;

float sr = 183;
float sb = 140;
float sg = 87;

float fc = 140;

float inc_r = (sr - 110) / fc;
float inc_g = (sr - 120) / fc;
float inc_b = (sr - 20) / fc;

float r = sr - (inc_r * frameCount);
float g = sg - (inc_g * frameCount);
float b = sb - (inc_b * frameCount);

void setup() {
  background(35);
  size(1200, 800);
  pixelDensity(2);

  for (int i = 0; i< num_p; i++) {
    PVector p = new PVector();
    p.x = random(0, width);
    p.y = random(0, height);
    points.add(p);
  }
}

void draw() {
  //background(255);
  for (PVector p : points) {
    stroke(frameCount);
    fill(r, g, b);
    ellipse(p.x, p.y, 5, 5);
    PVector random_pv = points.get(int(random(0, points.size())));
    //p.lerp(random_pv, random(.01, .02));
    p.lerp(random_pv, .02);
  }
  if (frameCount == 140) {
    noLoop();
  }
}