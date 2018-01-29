ArrayList<PVector> points = new ArrayList<PVector>(); //<>//

ArrayList<PVector> connectors = new ArrayList<PVector>();
float amt_connectors = 3;

float sx = 0;
float sy = 0;
float sz = 0;

float sizex = 100; 
float sizey = sizex;
float sizez = sizex;


void setup() {
  size(1000, 700, P3D);
  smooth(8);
  pixelDensity(2);

  for (int i = 1; i <= 3; i++) {

    PVector p1 = new PVector();
    p1.x = sx + (i * sizex);
    p1.y = sy;
    p1.z = sz;

    PVector p2 = new PVector();
    p2.x = p1.x + sizex;
    p2.y = p1.y;
    p2.z = p1.z;

    PVector p3 = new PVector();
    p3.x = p1.x;
    p3.y = p1.y + sizey;
    p3.z = p1.z;

    PVector p4 = new PVector();
    p4.x = p1.x + sizex;
    p4.y = p1.y + sizey;
    p4.z = p1.z;


    PVector p5 = new PVector();
    p5.x = p1.x;
    p5.y = p1.y;
    p5.z = p1.z + sizez;

    PVector p6 = new PVector();
    p6.x = p1.x + sizex;
    p6.y = p1.y;
    p6.z = p1.z + sizez;

    PVector p7 = new PVector();
    p7.x = p1.x;
    p7.y = p1.y + sizey;
    p7.z = p1.z + sizez;

    PVector p8 = new PVector();
    p8.x = p1.x + sizex;
    p8.y = p1.y + sizey;
    p8.z = p1.z + sizez;

    points.add(p1);
    points.add(p2);
    points.add(p3);
    points.add(p4);
    points.add(p5);
    points.add(p6);
    points.add(p7);
    points.add(p8);
  }

  // choose the random points...

  for (int i = 0; i < amt_connectors; i++) {
    boolean add = false; // while in there some where...
    while (!add) {

      PVector pv = points.get(int(random(0, points.size())));

      if (connectors.size() == 0) {
        connectors.add(pv);
        add = true;
      }

      for (int j = 0; j < connectors.size(); j++)
        if (pv == connectors.get(j)) {
          //println("already in!");
        } else {
          connectors.add(pv);
          add = true;
        }
    }
  }
}



void draw() {

  background(255);
  stroke(0);
  //translate(width/2, height/2);
  //rotateX(2);
  //rotateY(10);
  translate(width/2  - sizex/2, height/2 - sizex/2);


  make_bez();

  strokeWeight(10);

  for (PVector p : points) {
    point(p.x, p.y, p.z);
  }
  println(connectors.size());
  noLoop();
}

void make_bez() {
  PVector fp;
  PVector np;
  for (int i =0; i<connectors.size(); i++) {
    fp = connectors.get(i);

    if (i<(connectors.size() - 1)) {
      np = connectors.get(i+1);
      noFill();
      bezier(fp.x, fp.y, fp.z, 5, 5, 5, 5, 5, 5, np.x, np.y, np.z);
     
    }

    
  }
}