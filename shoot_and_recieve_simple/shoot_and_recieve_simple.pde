float padding = 20.0;  //<>// //<>//
int mover_amt = 50;

int catcher_amt = 30;

ArrayList<Catcher> catchers = new ArrayList<Catcher>();
ArrayList<Mover> movers = new ArrayList<Mover>();


void setup() {
  //size(800, 600, P2D);
  fullScreen(P2D);
  smooth(8);
  background(255);
  //pixelDensity(2);
  //randomSeed(240);
  frameRate(60);

  // make catchers
  for (int i =0; i < catcher_amt; i++) {
    catchers.add(new Catcher());
  }

  // make movers
  for (int i =0; i < mover_amt; i++) {
    movers.add(new Mover());
  }
}


void draw() {
  background(255);
  textSize(16);
  fill(0);
  text(frameRate, 10, height-20); 

  for (Catcher c : catchers) {
    c.show();
  }
  for (Mover m : movers) {


    m.show();
  }

  for (Catcher c : catchers) {
    for (Mover m : movers) {
      float distance = dist(c.x, c.y, m.x, m.y);     
      if ( distance < 1000) { 
        float xdist = c.x - m.x;
        float ydist = c.y - m.y;

        //m.speed = m.speed*.99;// * m.sspeed; ; // this makes the dots slow to a hault

        beginShape();
        strokeWeight(1);
        strokeCap(SQUARE);
        line(c.x, c.y, c.x - (xdist * c.l_d), c.y - (ydist * c.l_d));
        endShape();
        float line_inc = .005;
        if (c.l_d + line_inc < 1) {
          c.l_d = c.l_d + line_inc;
        }
      }
    }
  }
}