class Circle {

  float sx = random(2, 600);
  float sy = random(2, 600);
  float r_color = random(150, 190);
  float g_color = random(170, 225);
  float b_color = random(170, 225);
  float t = random(1, 100);
  float color_diff;



  int intensity = 100;

  void display() {
    //println(color_diff* intensity);
    float xoffset = map(noise(t + .5), 0, 1, -1, 1);
    float yoffset = map(noise(t), 0, 1, -1, 1);
    float r = r_color;
    float g = g_color;
    float b = b_color;
    fill(r, g, b);

    float ox = (sx+xoffset*intensity);
    float oy = (sy+yoffset*intensity);
    
    float to_mousex = dist(ox, oy, mouseX, mouseY);
    //println(to_mousex);
    
    float x = ox + (to_mousex/3);
    float y = oy + (to_mousex/3);

    ellipse(ox, oy, 10, 10);
  }

  void update() {

    t += .003;
  }
}