class Vehicle { //<>// //<>//
  //globals
  float padding = 50;
  float size = 30.0;

  //line creation
  float sx = random(padding, width - padding);
  float sy = random(padding, height - padding);
  float sides = random(3, 5);
  float ex = random(sx - size, sx+size);
  float ey = random(sy - size, sy+size);

  //movement
  float dx1 = random(-2, 2);
  float dy1 = random(-2, 2);
  //float dx2 = random(-2, 2); // if you set these two independantly, they will have their own speed/direcitons... which is kind of cool
  //float dy2 = random(-2, 2); // if you set these two independantly, they will have their own speed/direcitons... which is kind of cool
  float dx2 = dx1;
  float dy2 = dy1;
  float speed = random(1.0, 1.01);
  float srotation = random(0, 1);


  float x1 = sx;
  float y1 = sy;
  float x2 = ex;
  float y2 = ey;


  void show() {
    beginShape();

    vertex(x1, y1);

    vertex(x2, y2);
    endShape();
    ellipse(x1, y1, 5, 5);
    ellipse(x2, y2, 5, 5);
    inc();
  }
  void inc() {
    x1 = x1 + (speed * dx1);
    y1 = y1 + (speed * dy1);
    x2 = x2 + (speed * dx2);
    y2 = y2 + (speed * dy2);

    if (x1 > width || x1 < 0) {
      dx1 = dx1 * -1;
    }
    if (x2 > width || x2 < 0) {
      dx2 = dx2 * -1;
    }
    if (y1 > height || y1 < 0) {
      dy1 = dy1 * -1;
    }
    if (y2 > height || y2 < 0) {
      dy2 = dy2 * -1;
    }
  }
}