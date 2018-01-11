class Cluster { //<>//

  int padding = 30;
  int number_points = int(random(3, 13));
  float o_x = random(0 + padding, width - padding);
  float o_y = random(0 + padding, height - padding);

  ArrayList<Particle> children;


  Cluster() {
    children = new ArrayList<Particle>();

    for (int i =0; i < number_points; i++) {
      children.add(new Particle());
    }
  }

  void show() {
    // load children circles
    for (int i = 0; i < children.size(); i++) {
      //children.get(i).index = i;
      children.get(i).show();
    }

    // load origin
    fill(100, 200, 80);
    ellipse(o_x, o_y, 10, 10);
  }

  class Particle {
    
    float t = random(1,10000);

    float xoff = 0;
    float yoff = 0;
    float x;
    float y;
    float inc = 0;

    float sx = random(o_x - padding, o_x + padding);
    float sy = random(o_y - padding, o_y + padding);

    void show () {
      
      xoff = map(noise(t+inc), 0,1,-100,100);
      yoff = map(noise((t+.5)+inc), 0,1,-100,100);
      x = sx + xoff;
      y = sy + yoff;
      line(x,y, o_x, o_y);
      fill(255);
      ellipse(x, y, 10, 10);
      inc = inc+ .004;
      
      //println(xoff);
      
    }
    
    void update() {
    
      
    }
  }
}