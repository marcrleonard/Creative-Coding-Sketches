class Catcher {
  float x = random( padding, width - padding);
  float y = random(0+ padding, height - padding);

  
  float t;

  ArrayList<CatcherStorage> attached = new ArrayList<CatcherStorage>();

  void show() {
    strokeWeight(1);
    fill(0);
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
  float sspeed = random(5, 8); // 5,8 was cooll for full screen... otherwise...
  float speed = sspeed;
  
  int grow = 0; // 0 is nothing, 1 is growing line, 2 is shrinking line;

  float push_through = random(1, 1.05);
  void show() {
    inc();
    strokeWeight(1);
    fill(0);
    ellipse(x, y, 4, 4);
  }
  void inc() {
    x = (x + speed); // * push_through; // adding push through makes them not 'abide' by the speed

    if (x > width || x < 0) {
      //x = -10;
      speed = -speed;
    }
  }
}

class CatcherStorage extends Mover {
  //int grow = 0; // 0 is nothing, 1 is growing line, 2 is shrinking line;
  float l_d;

  float line_inc = .05;
  Mover mover_obj;
  
  //float get_inc() {
    
  //  if(mover_obj.grow == 1){
  //    return line_inc_amt;
  //  }
  //  if(mover_obj.grow == 2){
  //    return -line_inc_amt;
  //  }    
  //}
}