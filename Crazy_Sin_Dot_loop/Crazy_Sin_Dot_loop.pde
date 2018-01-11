// description: this is a sin wave of particles with some perlin noise. The noise that creates a perlin y offset is one directional and multiplied (ie, always possitive, and multiplied). The distribution of the perlin is what makes it 'top heavy' the noise makes it vary TON //<>//

int amt_obj = 1300;

Particle[] particle_list = new Particle[amt_obj];

float speed_var = 1; // ignore this.. it's where the speed starts...
int ampl = 100; // how high the waves are
float speed_inc = .05; // how fast it waves
float freq = .005; // frequency

void setup() {
  size(1280, 720, P2D);
  background(255);
  pixelDensity(2);
  //frameRate(4);
  float x_dist = (float(width)/float(particle_list.length)); //<>//
  
  for (int i = 1; i < particle_list.length; i++) {
    // this is the offset...   
    particle_list[i] = new Particle();
    particle_list[i].sx = i * x_dist + random(2,10);
  }
}

void draw() {


  background(255);
  //text(frameRate, 10, 20);
  for (int i = 1; i < particle_list.length; i++) {
    particle_list[i].get_noise();
    float yoff = particle_list[i].yoff;
    //println(yoff);
    particle_list[i].sy = (height/2-cos((i * freq) + speed_var) * ampl) * yoff;
    particle_list[i].show();
    
    
  }
  speed_var += speed_inc;
  
  //float cirx = width/2;
  
  //float ciry = height/2 + (cos(speed) * ampl);
  //ellipse(cirx, ciry, 20, 20);
  println(frameRate);
  
  
  
}