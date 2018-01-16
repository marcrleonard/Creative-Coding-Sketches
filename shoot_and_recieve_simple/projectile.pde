class Catcher {
  float x = random( width/2 - padding, width - padding);
  float y = random(0+ padding, height - padding);
  float t;
  float l_d = 0;
  
  ArrayList<Mover> attached = new ArrayList<Mover>();

  void show() {
    strokeWeight(1);
    fill(255, 198, 125);
    ellipse(x, y, 10, 10);
  }
}


class Mover {
  float l_d = 0;
  float sx = padding; //random(0+padding, width/2 - padding);
  float sy = random(0+ padding, height - padding);
  float x = sx;
  float y = sy;
  float t;
  float sspeed = random(.2, 1.3); // 5,8 was cooll for full screen...
  float speed = sspeed;
  
  float push_through = random(1,1.05);
  void show() {
    inc();
    strokeWeight(1);
    fill(51, 153, 240);
    ellipse(x, y, 4, 4);
    
  }
  void inc() {
    x = (x + speed); // * push_through; // adding push through makes them not 'abide' by the speed
    
    if (x > width || x < 0){
      println("too far!");
      speed = -speed;
    
    }
  }
}