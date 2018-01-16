float padding = 20.0;  //<>// //<>//
int mover_amt = 50;

int catcher_amt = 30;

ArrayList<Catcher> catchers = new ArrayList<Catcher>();
ArrayList<Mover> movers = new ArrayList<Mover>();


void setup() {
  size(800, 600, P2D);
  //fullScreen(P2D);
  //smooth(8);
  background(255);
  pixelDensity(2);
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
  //frameRate(10);

  for (Catcher c : catchers) {
    c.show();
  }
  for (Mover m : movers) {
    m.show();
  }

  for (Catcher c : catchers) { //<>//
    for (Mover m : movers) {
      float distance = dist(c.x, c.y, m.x, m.y);     

      if ( distance < 100) { 

        c.attached.add(m);
      } else {
        if (c.attached.contains(m)) {
          c.attached.remove(m);
        }
      }
    }
  }
  for (Catcher c : catchers) { //<>//
    for (Mover m : c.attached) {
      // add into array...
      // this for all items in array, do this stuff...


      float xdist = c.x - m.x;
      float ydist = c.y - m.y;

      //m.speed = m.speed*.99;// * m.sspeed; ; // this makes the dots slow to a hault

      beginShape();
      //strokeWeight(1);
      strokeCap(SQUARE);
      line(c.x, c.y, c.x - (xdist * m.l_d), c.y - (ydist * m.l_d));
      endShape();
      float line_inc = .005;
      if (m.l_d + line_inc < 1) {
        m.l_d = m.l_d + line_inc;
      }
    }
  }
}

class LengthStorage {
float l_d;
Mover m;

}