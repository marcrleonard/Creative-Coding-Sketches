// description: this is a sin wave of particles with some perlin noise. The noise that creates a perlin y offset is one directional and multiplied (ie, always possitive, and multiplied). The distribution of the perlin is what makes it 'top heavy' the noise makes it vary TON //<>//

int amt_obj = 800;

// 1200, .005
// 2400, .0025

//float thresh = .0025;

float thresh = 2400 * .0025;
float freq = ((thresh) / float(amt_obj));



Particle[] particle_list = new Particle[amt_obj];

float speed_var = 1; // ignore this.. it's where the speed starts...
int ampl = 150; // how high the waves are
float speed_inc = .05; // how fast it waves
//float freq = .0025; // frequency

void setup() {
  size(1280, 720, P2D);
  background(255);
  pixelDensity(2);
  
  //frameRate(4);
  float x_dist = (float(width)/float(particle_list.length)); //<>//
  
  for (int i = 1; i < particle_list.length; i++) {
    // this is the offset...   
    particle_list[i] = new Particle();
    particle_list[i].sx = i * x_dist + random(-40,40);
  }
}

void draw() {


  background(255);
  //text(frameRate, 10, 20);
  for (int i = 1; i < particle_list.length; i++) {
    float yoff = particle_list[i].random_offset;
    //println(yoff);
    particle_list[i].sy = ( (height/2) + (sin((i * freq) + speed_var) ) * ampl) + yoff ;
    particle_list[i].show();
    
    
  }
  speed_var += speed_inc;
  
}