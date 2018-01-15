float padding = 20.0; //<>// //<>//
int mover_amt = 5000;

ArrayList<Catcher> catchers = new ArrayList<Catcher>();
ArrayList<Mover> movers = new ArrayList<Mover>();


void setup() {
  size(1280, 720, P2D);
  //fullScreen(P2D);
  background(255);
  //pixelDensity(2);
  //randomSeed(21);

  // make catchers
  for (int i =0; i<3; i++) {
    catchers.add(new Catcher());
  }

  // make movers
  for (int i =0; i<mover_amt; i++) {
    movers.add(new Mover());
  }
}


 //<>// //<>//
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
      if (dist(c.x, c.y, m.x, m.y) < 200) {
        m.speed = m.speed*.99 ;
        //if (m.speed> .001) {
        //  println("stopped");
        //  m.speed = 0;
        //}
      }
    }
  }
}