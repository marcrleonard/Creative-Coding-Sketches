class Particle {

  float sx;
  float sy;

  float random_offset = random(-150, 150);


  void show() {
    float x = sx;
    float y = sy;

    float r = map(y, 0, height, 255, 0);
    float g = map(y, 0, height, 0, 150);
    float b = 250;

    fill(r, g, b);
    ellipse(x, y, 10, 10);
  }
}