float inc = .01;



void setup() {
  size(600, 600, P2D);
}

void draw() {
  background(255);
  stroke(0);
  noFill();
  float yoff = 2;
  for (int y =0; y<height; y++) {
    float xoff = 2;
    for (int x =0; x<width; x++) {
      float nvx = map(noise(xoff, yoff), 0, 1, 0, 255);
      noStroke();
      fill(nvx);
      rect(x, y, 1, 1);
      xoff += inc;
    }

    yoff += inc;
  }
  println(frameRate);

  //noLoop();
}