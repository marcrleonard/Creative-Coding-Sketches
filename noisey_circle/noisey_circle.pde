int revolutions = 1;
int radius = 300;
float n_amount = .15;
float n = .01;
float noise_size = 30;

float first_x;
float first_y;

void setup() {
  size(700, 700);
  background(255);
  pixelDensity(2);
  frameRate(2);
};

void draw() {
  background(255);
  translate(width/2, height/2);

  beginShape();
  for (int i = 0; i < 360* revolutions; i++) {

    

    float offset = map(noise(n), 0, 1, -1, 1) * noise_size;
    n = n + n_amount;
    println(offset);

    //float x = cos(i) * radius ;
    //float y = sin(i) *radius ;

    float x = cos(radians(i + offset)) * radius;
    float y = sin(radians(i - offset)) * radius;
    
    vertex(x, y);
  }
  endShape(CLOSE);
};