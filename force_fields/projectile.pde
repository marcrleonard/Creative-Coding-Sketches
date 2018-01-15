class Catcher {
  float x = random(width/2 + padding, width - padding);
  float y = random(0+ padding, height - padding);
  float t;

  void show() {
    fill(50);
    ellipse(x, y, 10, 10);
  }
}


class Mover {
  float sx = padding; //random(0+padding, width/2 - padding);
  float sy = random(0+ padding, height - padding);
  float x = sx;
  float y = sy;
  float t;
  float speed = random(.6, 1.1);

  void show() {
    fill(220, 240, 50);
    ellipse(x, y, 1, 1);
    inc();
  }
  void inc() {
    x = x + speed;
  
  }
}