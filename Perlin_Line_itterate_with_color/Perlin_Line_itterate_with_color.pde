ArrayList<Point> points = new ArrayList<Point>();
float lowest_y = height;
float xoff = 0;
float yoff = 1;
float resolution = 250;
float lines = 30;
float noise_inc = .004;

void setup () {
  noiseSeed(19);
  background(55); 
  size(1200, 700);
  pixelDensity(2);
  smooth(16);

  for (int x = 1; x <= resolution; x++) {
    float y = (noise(yoff)*width);
    Point p = new Point();
    p.x = (width/resolution) * x;
    p.y = y;
    points.add(p);

    vertex(x, y);
    yoff += noise_inc;
  }

  for (Point p : points) {
    if (p.y < lowest_y) {
      lowest_y = p.y;
      println(p.y);
    }

  }
}

void draw() {
  background(55); 

  float sr = 163;
  float sb = 79;
  float sg = 67;
  
  float inc_r = (sr - 98) / lines;
  float inc_g = (sr - 117) / lines;
  float inc_b = (sr - 186) / lines;

  stroke(sr, sg, sb);
  noFill();
  
  // 163, 79, 67 start
  // 98, 117, 186 end
  
  for (int i = 0; i < lines; i++) {
    float sw = 1 + i;
    float spacing = i + (i * sw);
    
    stroke(sr - (inc_r * i), sg - (inc_g * i), sb - (inc_b * i));
    strokeWeight(sw);
    beginShape();
    for (Point p : points) {
      
      vertex(p.x, (p.y - spacing));
    }
    endShape();
  }

  println(lowest_y);
  noLoop();


  //println(list);
}

class Point {
  float x;
  float y;
}