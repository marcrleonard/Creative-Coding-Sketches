int radius = 300;
float n_amount = .05;
float amplitude = 20;

// if this value is too low, you see the `CLOSE` connection
float resolution = 600.0;

void setup() {
  size(700, 700);
  background(255);
  pixelDensity(2);
  frameRate(24);
};

void draw() {
  background(255);
  translate(width/2, height/2);

  float angle = 360 / resolution;

  beginShape();
  for (int i = 0; i <= resolution; i++) {

    //float offset = map(noise(n), 0, 1, 0, 1);
    float offset = noise(n_amount, n_amount);
    n_amount += (.001 * frameCount);
    println(offset);

    float x = cos(radians(i * angle)) * radius * offset;
    float y = sin(radians(i * angle)) * radius * offset;
    //println(x, y);


    vertex(x, y);
  }
  endShape(CLOSE);
};