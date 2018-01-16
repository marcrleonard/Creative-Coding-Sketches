float padding = 20.0;  //<>// //<>// //<>// //<>// //<>// //<>//
int mover_amt = 60;
int catcher_amt = 50;
float max_distance = 250;

ArrayList<Catcher> catchers = new ArrayList<Catcher>();
ArrayList<Mover> movers = new ArrayList<Mover>();


void setup() {
  //size(1280, 720, P2D);
  fullScreen(P2D);
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

      // these shrinking/growing operations need to be two different functions.
      if ( distance < max_distance) { 

        // this does not check if it's already in the array. There might be multiple connections...
        boolean new_item = true;
        for (int i = 0; i < c.attached.size(); i++) {
          // check if m is in c.attached already.
          if (m == c.attached.get(i).mover_obj) {
            // if so, remove m from c.attached.
            new_item = false;
            break; //<>//
          }
        }
        if (new_item) {
          CatcherStorage m_obj = new CatcherStorage(); // init the object
          m_obj.mover_obj = m; // put the object in it

          c.attached.add(m_obj);  // add it to array
          println(c.attached.size());
        }
      } else {
        for (int i = 0; i < c.attached.size(); i++) {
          // check if m is in c.attached already.
          if (m == c.attached.get(i).mover_obj) {
            // if so, remove m from c.attached.
            c.attached.remove(i);
            break;
          }
        }
      }

      if ( distance > 180) {
        //println("shrink!");
      }
    }
  }


  for (Catcher c : catchers) {
    for (CatcherStorage m : c.attached) {

      float xdist = c.x - m.mover_obj.x;
      float ydist = c.y - m.mover_obj.y;

      //m.speed = m.speed*.99;// * m.sspeed; ; // this makes the dots slow to a hault

      beginShape();
      strokeCap(SQUARE);
      line(c.x, c.y, c.x - (xdist * m.l_d), c.y - (ydist * m.l_d));
      endShape();

      if (m.l_d + m.line_inc < 1) {
        //m.l_d_last = m.l_d; // store last distance
        m.l_d = m.l_d + m.line_inc;
      } else {
        m.l_d = 1;
      }
    }
  }
}