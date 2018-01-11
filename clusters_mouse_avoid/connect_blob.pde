class Cluster { //<>//

  int padding = 30;
  int number_points = int(random(3, 13));

  float o_s = random(30, 50000);
  float o_inc= 0;


  float o_x = random(0 + padding, width - padding);
  float o_y = random(0 + padding, height - padding);

  float o_xoff = 0;
  float o_xe = o_x + o_xoff;

  float o_yoff = 0;
  float o_ye = o_y + o_yoff;

  ArrayList<Particle> children;

  float child_pull = 2;
  float child_move_amnt = 50;

  float o_move_amnt = 20; // change to 0 to stop moving origin
  float o_move_inc = .01;


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
    o_xoff = map(noise(o_s + o_inc), 0, 1, -1 * o_move_amnt, o_move_amnt);
    o_yoff = map(noise(o_s + o_inc + 100), 0, 1, -1 * o_move_amnt, o_move_amnt);

    fill(180, 120, 80);
    o_xe = o_x + o_xoff;
    o_ye = o_y + o_yoff;
    ellipse(o_xe, o_ye, 10, 10);
    o_inc = o_inc + o_move_inc;
  }

  class Particle {

    float t = random(1, 10000);

    float xoff = 0;
    float yoff = 0;
    float x;
    float y;
    float inc = 0;
    
    float o_dist = 20; // max distance from origin

    float sx = random(o_xe - o_dist, o_xe + o_dist);
    float sy = random(o_ye - o_dist, o_ye + o_dist);
    
    float s_size = 1;
    float size = s_size;
    float size_max = 30;



    void show () {

      float x_dist = mouseX-x;
      float y_dist = mouseY-y;
      
      float avoid_distance = 50.0;
      float repel_speed = 10.0; // lower is faster
      
      // if there is mouse disruption...
      if (x_dist >= -avoid_distance && x_dist <= avoid_distance) {
        if (y_dist >= -avoid_distance && y_dist <= avoid_distance) {
          sy = sy - y_dist/repel_speed;
          sx = sx - x_dist/repel_speed;
          if (size < size_max) {
            size = size * 1.1;
          }
          
        }
      }
      // otherwise, check if size needs to be 'decayed'
      else {
        if (size > s_size) {
          size = size - ((size - s_size )/60);
        }
      }


      xoff = map(noise(t+inc), 0, 1, -1 * child_move_amnt, child_move_amnt);
      yoff = map(noise((t+20)+inc), 0, 1, -1 * child_move_amnt, child_move_amnt);

      x = sx + xoff + o_xoff/child_pull;
      y = sy + yoff + o_yoff/child_pull;


      line(o_xe, o_ye, x, y);
      fill(255);
      ellipse(x, y, 10*size, 10*size);

      inc = inc+ .004;

      //println(xoff);
    }

    void update() {
    }
  }
}