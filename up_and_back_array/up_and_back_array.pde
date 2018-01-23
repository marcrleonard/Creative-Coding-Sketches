//Bouncer b = new Bouncer(); //<>// //<>//
Bouncer[] bouncers = new Bouncer[4];
Particle[] particles = new Particle[500];

void setup() {
  size(1280, 720, P2D);
  background(35, 57, 84);
  pixelDensity(2);
  //frameRate(1);
  
  for (int i =0; i<particles.length; i++) {
    Particle p = new Particle();
    particles[i] = p;
  }
  
  for (int i =0; i<bouncers.length; i++) {
    float padding = 200;
    
    Bouncer b = new Bouncer();
    if (i == 0) {
      b.t_x = random(padding, width/2-padding);
      b.t_y = random(padding, height/2-padding);
    }
    if (i == 1) {
      b.t_x = random(width/2+padding, width-padding );
      b.t_y = random(padding, height/2-padding);
    }
    if (i == 2) {
      b.t_x = random(padding, width/2-padding);
      b.t_y = random(height/2+padding, height-padding);
    }
    if (i == 3) {
      b.t_x = random(width/2+padding, width-padding);
      b.t_y = random(height/2+padding, height-padding);
    }

    bouncers[i] = b;
  }
}

void draw() {
  background(35, 57, 84);
  for (int i =0; i<bouncers.length; i++) {
    bouncers[i].show();
  }
    for (int i =0; i<particles.length; i++) {
    particles[i].move();
  }
}

class Bouncer {

  float sx1 = 0;
  float y = 0;

  float x1 = sx1;  
  float sx2 = 40; // starting width
  float x2 = x1 + sx2;
  float inc = .5;

  float far_distance1 = 80;
  float far_distance2 = far_distance1 - x2;

  boolean move_leader = true;
  boolean move_follower = false;

  float c_s = 6;

  float t_x = 0;
  float t_y = 0;


  void show () {
    pushMatrix();
    translate(t_x, t_y);
    stroke(156, 145, 87);
    strokeWeight(2);
    line(x1, y, x2, y);
    noStroke();
    fill(156, 145, 87);
    ellipse(x1, y, c_s, c_s);
    ellipse(x2, y, c_s, c_s);
    popMatrix();
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
      x1 = sx1;
    }
  }
}

class Particle {
  float x = random(0, width);
  float y = random(0, height);
  float t = random(0,20);
  float inc = random(.002, .01);
  float nx=0;
  float ny=0;
  void move() {
    nx = map(noise(t), 0,1,0,30);
    ny = map(noise(t+4),0,1,0,30);
    ellipse(x+nx + 10, y+ny, 2, 2);
    t = t+inc;
  }
}