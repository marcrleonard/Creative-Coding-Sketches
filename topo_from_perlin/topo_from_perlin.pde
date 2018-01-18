float inc = .009; //<>//
PVector v;

void setup() {
  size(1200, 1200, P2D);
  smooth(8);
}

void draw() {
  background(255);
  stroke(0);

  int sq = 120;
  int xscl = width/sq;
  int yscl = height/sq;

  float yoff = 2;
  for (int y =0; y<sq; y++) {
    float xoff = 2;
    for (int x = 0; x<sq; x++) {
      float nv = noise(xoff, yoff);
      float angle = map(nv, 0, 1, 0, TWO_PI);
      //float angle = map(mouseX, 0, width, 0, TWO_PI);
      float cv = map(nv, 0, 1, 0, 255);

      v = PVector.fromAngle(angle);
      fill(cv);
      pushMatrix();
      translate(x*xscl, y*yscl);
      rotate(v.heading());

      stroke(0);
      line(0, 0, xscl, 0);
      popMatrix();
      
      //stroke(cv);
      //point(x* xscl,y*yscl);
      //line(x*scl, y*scl, x*scl, y*scl + scl );



      xoff += inc;
    }
    yoff += inc;
  }

  //println(frameRate);
  //noLoop();
}