float padding = 20.0; //<>// //<>// //<>//
int mover_amt = 200;
int catcher_amt = 3;
float min_distance = 400;
float max_distance = 800;
float middle_thresh = (max_distance - min_distance)/2;


int catcher_rows = 5;
float row_padding;
float catcher_width;
float catcher_inner_width = 100;

ArrayList<Catcher> catchers = new ArrayList<Catcher>();
ArrayList<Mover> movers = new ArrayList<Mover>();


void setup() {
  //size(2500, 1000, P2D);
  fullScreen(P2D);
  smooth(8);
  background(255);
  pixelDensity(2);
  //randomSeed(240);
  catcher_width = width/catcher_rows;
  row_padding = (catcher_width - catcher_inner_width)/2;

  // make catchers
  for (int rows = 1; rows<= catcher_rows; rows++) {
    float row_s = ((rows-1) * catcher_width) + row_padding;
    float row_e = (rows*catcher_width) - row_padding;
    float x_output = row_e;

    println("Row: " + rows + " | " + row_s + "->" + row_e);
    for (int i = 0; i < catcher_amt; i++) {

      if (i % 2 == 0) {
        //even
        //println("even " + i );
        x_output = row_s;
      } else {
        //println("odd " + i );
        x_output = row_e;
      }

      Catcher catcher_node = new Catcher();
      catcher_node.x = x_output;
      catcher_node.y = i * (height/catcher_amt) + (height/catcher_amt/2);
      catchers.add(catcher_node);
    }
  }

  // make movers
  for (int i =1; i <= mover_amt; i++) {
    Mover new_mover = new Mover();
    new_mover.sx = (height/mover_amt) * i;
    movers.add(new_mover);
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
      // check distance...
      float distance = dist(c.x, c.y, m.x, m.y);
      // check in array...
      boolean in_array = false;
      for (int i = 0; i < c.attached.size(); i++) {
        // check if m is in c.attached already.
        if (m == c.attached.get(i).mover_obj) {
          in_array = true;
          break;
        }
      }
      //println(in_array, + distance);

      // NOW make decision.
      if ( distance > min_distance && !in_array) {
        CatcherStorage m_obj = new CatcherStorage(); // init the object
        m_obj.mover_obj = m; // put the object in it
        // set it as 'in range'
        m_obj.grow = 1;

        c.attached.add(m_obj);  // add it to array
        //println(c.attached.size());
      }


      if (distance > max_distance && in_array) {
        for (int i = 0; i < c.attached.size(); i++) {
          // check if m is in c.attached already.
          if (m == c.attached.get(i).mover_obj) {
            // if so, remove m from c.attached.
            c.attached.remove(i);
           
            break;
          }
        }
      }

      if ( distance > min_distance + middle_thresh && in_array) {
        for (int i = 0; i < c.attached.size(); i++) {
          // check if m is in c.attached already.
          if (m == c.attached.get(i).mover_obj) {
            
            // increment grow line DOWN
            c.attached.get(i).l_d = c.attached.get(i).l_d - c.attached.get(i).line_inc;
            if (c.attached.get(i).l_d < 0) {
              c.attached.get(i).l_d = 0;
            }

            //c.attached.get(i).mover_obj.grow = 2;
          }
        }
 //<>//
        //m.grow = 2;
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


      // This code needs to move above...
      if (m.grow == 1) {
        // if gorwing line...
        if (m.l_d + m.line_inc < 1) {
          m.l_d = m.l_d + m.line_inc;
        } 
        if (m.l_d + m.line_inc > 1) {
          // if it's going to be larger than 1, set it and change grow state.
          m.l_d = 1;
          m.grow = 0;
        }
      }
    }
  }
}