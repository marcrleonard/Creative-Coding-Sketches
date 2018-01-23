ArrayList<PVector> points = new ArrayList<PVector>();
float num_p = 20;

void setup() {
  background(255);
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

  for (PVector p : points) {
    ellipse(p.x, p.y, 5, 5);
    p.lerp(points.get(int(random(0, points.size()))), .1);
  }
}