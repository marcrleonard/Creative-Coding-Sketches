class Circ {

  float x;
  float y;
  float resolution = 100;
  void make_circle() {
    for (int i = 0; i <= 100; i++) {
      float angle_size = random(20, 360);
      float r = random(100, 160);
      float g = random(115, 140);
      float b = random(110, 230);

      beginShape();
      stroke(r, g, b);
      strokeWeight(1);
      rotate(random(2, 360));
      noFill();
      for (int j = 0; j <= resolution; j++) {
        x = sin(radians(angle_size/resolution*j))* c_r;
        y = cos(radians(angle_size/resolution*j))* c_r;
        vertex(x, y);
      }
      endShape();
      c_r = c_r + 5;
    }
  }
}