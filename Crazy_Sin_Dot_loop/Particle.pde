class Particle {

  //float sx = random(1, 3);
  //float sy = random(1, 3);
  //float r_color = random(150, 190);
  //float g_color = random(170, 225);
  //float b_color = random(170, 225);
  //float t = random(1, 100);
  //float color_diff;
  float sx;
  float sy;
  float yoff;
  
  //float set_off = random(-5,52,2);
  
  float random = random(0,1);
  
  float inc = .01;

  void get_noise() {
    yoff = map(noise(random + inc), 0, 1, 0,2);
      //yoff = random(-5-,5);
  
    //inc += .001;
    //println(yoff);
  
  }

  void show() {
    float x = sx;
    float y = sy;
    ellipse(x, y, 10, 10);
  }
}