float r = 480.0;

void setup () {
  size(1000, 1000);
  background(255);
  pixelDensity(2);
}

void draw() {


  float i = frameCount;
  noFill();
  beginShape();

  if (i % 1 == 0) {
    vertex(sin(radians(i))*r + width/2, cos(radians(i))*r + height/2);
    vertex(sin(radians(i * .8))*(r * .5) + width/2, cos(radians(i * .8))*(r * .5) + height/2);
  };
  if (frameCount > 360) {
    noLoop();
  }

  //ellipse(width/2, height/2, 180,180);

  endShape();
  //r -=.12;
}