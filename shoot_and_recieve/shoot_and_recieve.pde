ArrayList<Vehicle> particles;
float shooter_x = 0;
int shooter_y = height;


void setup() {
  size(1000, 700);
  background(255);
  pixelDensity(2);


  particles = new ArrayList<Vehicle>();

  for (int i=0; i < 3; i++) {
    Vehicle new_vehicle = new Vehicle();
    particles.add(new_vehicle);
    new_vehicle.sx = shooter_x;
    new_vehicle.sy = shooter_y;
  }
}



void draw() {

  ellipse(0, height, 20, 20);

  for (Vehicle c : particles) {
    c.show();
  }
}