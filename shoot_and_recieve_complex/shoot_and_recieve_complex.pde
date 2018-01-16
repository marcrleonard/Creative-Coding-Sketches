float padding = 20.0;  //<>// //<>// //<>// //<>// //<>// //<>//
int mover_amt = 10;

int catcher_amt = 3;

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
  
  // this should prob just show in the other loop...
  for (Catcher c : catchers) {
    c.show();
  }
  for (Mover m : movers) {
    m.show();
  }

  for (Catcher c : catchers) {
    for (Mover m : movers) {
      float distance = dist(c.x, c.y, m.x, m.y);     

      if ( distance < 100) { 
        CatcherStorage m_obj = new CatcherStorage(); // init the object
        m_obj.mover_obj = m; // put the object in it

        c.attached.add(m_obj);  // add it to array
      } else {

        for (int i = 0; i < c.attached.size(); i++) {
          // check if m is in c.attached already.
          if (m == c.attached.get(i).mover_obj) {
            // if so, remove m from c.attached.
            c.attached.remove(i); //<>//
          }
        }
        // remove if object is in catcher's array
      }
    }
  }


  for (Catcher c : catchers) {
    for (CatcherStorage m : c.attached) {

      float xdist = c.x - m.mover_obj.x;
      float ydist = c.y - m.mover_obj.y;

      //m.speed = m.speed*.99;// * m.sspeed; ; // this makes the dots slow to a hault

      beginShape();
      //strokeWeight(1);
      strokeCap(SQUARE);
      line(c.x, c.y, c.x - (xdist * m.l_d), c.y - (ydist * m.l_d));
      endShape();
      float line_inc = .1;
      if (m.l_d + line_inc < 1) {
        m.l_d = m.l_d + line_inc;
      }
      else{
      m.l_d = 1;
      }
      //if (m.l_d > 20 && m.l_d < 40) {
      //  println("about to dis!");
      //}
    }
  }
}