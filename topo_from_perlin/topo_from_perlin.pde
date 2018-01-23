float inc = .009; //<>// //<>//
PVector v;
PVector a;

ArrayList<PVector> grade = new ArrayList<PVector>();

int num_gradations = 100;

ArrayList[] AllGradation = new ArrayList[num_gradations];

void setup() {
  size(700, 700, P2D);
  smooth(8);
  randomSeed(20);

  for (int l = 0; l>num_gradations; l++) {
    grade.add(new PVector());
    AllGradation[l] = grade;
  }
}

void draw() {
  background(255);
  stroke(0);

  int sq = 100;
  int xscl = width/sq;
  int yscl = height/sq;

  float zoff = 2;
  float yoff = 2;

  for (int y =0; y<sq; y++) {
    float xoff = 2;
    for (int x = 0; x<sq; x++) {
      float nv = noise(xoff, yoff, zoff);
      float angle = map(nv, 0, 1, 0, TWO_PI);
      //float angle = map(mouseX, 0, width, 0, TWO_PI);
      float cv = map(nv, 0, 1, 0, 255);

      float zval = floor(map(nv, 0, 1, 0, float(num_gradations)));

      ArrayList grad_list = AllGradation[int(zval)];
      if (grad_list == null) {
        AllGradation[int(zval)] = new ArrayList<PVector>();
      }
      
      a = new PVector();
      a.x = float(x);
      a.x = float(y);
      a.z = zval;
      
      

      AllGradation[int(zval)].add(a);

      a = PVector.fromAngle(angle);

      fill(cv);
      pushMatrix();
      translate(x*xscl, y*yscl);
      rotate(a.heading());

      stroke(255);
      line(0, 0, xscl, 0);
      popMatrix();

      //stroke(cv);
      //point(x* xscl,y*yscl);
      noStroke();
      fill(cv);
      rect(x*xscl, y*yscl, xscl, yscl);
      //line(x*scl, y*scl, x*scl, y*scl + scl );



      xoff += inc;
    }
    yoff += inc;
    zoff += inc;
  }
  
  for (int i = 0; i < AllGradation.length; i++) {
    if (AllGradation[i] == null){
      AllGradation[i] = new ArrayList<PVector>();
    }
    beginShape(); //<>//
    for (int l = 0; l < AllGradation[i].size(); l++) {
      Object cpv = AllGradation[i].get(l);
      println(cpv.toString());
      
    }
    endShape();
  }

  //println(frameRate);
  //noLoop();
}