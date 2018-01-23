float x1 = 0; //<>//
float sx2 = 40;
float x2 = sx2;
float inc = 1;

float far_distance1 = 80;
float far_distance2 = far_distance1 - x2;

boolean move_leader = true;
boolean move_follower = false;

void setup() {
  size(200, 200, P2D);
  background(35, 57, 84);
  pixelDensity(2);
}

void draw() {
  translate(width/2, height/2);
  background(35, 57, 84);
  //translate(width/2, height/2);
  stroke(156, 145, 87);
  strokeWeight(2);
  line(x1, 0, x2, 0);
  noStroke();
  fill(156, 145, 87);
  
  ellipse(x1, 0, 12, 12);
  ellipse(x2, 0, 12, 12);
  move();
 
  
}


void move() {
  if (move_leader) {
    if (x2 < far_distance1) {
      x2 = x2 + inc;
    } else {
      move_leader = false;
      move_follower = true;
    }
  }
  if (move_follower) {
    if (x1 < far_distance2) {
      x1 = x1 + inc;
    } else {
      inc = -inc;
      x1 = x1 + inc;
    }
  }
  if (x2-x1 > far_distance1) {
    move_follower = false;
    move_leader = true;
    x2 = x2 + inc;
  } 
  if (x2 < sx2) {
    // basicallt reset everything...
    move_leader = true;
    move_follower = false;
    inc = inc * -1;
    x1 = 0;
    sx2 = 40;
    x2 = sx2;
    
  }
}