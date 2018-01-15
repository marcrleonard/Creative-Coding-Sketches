ArrayList<Vehicle> particles; //<>//
float particle_number = 200;


void setup() {
  size(1000, 700);
  background(255);
  pixelDensity(2);


  particles = new ArrayList<Vehicle>();

  for (int i=0; i < particle_number; i++) {
    Vehicle new_vehicle = new Vehicle();
    particles.add(new_vehicle);
  }
}


void draw() {
  background(255);


  for (Vehicle c : particles) {
    c.show();
  }
}