int revolutions = 1;
int radius = 300;
float n_amount = .15;
float n = .01;
float noise_size = 30;

float resolution = 200.0;
float angle = 360 / resolution;

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
  for (int i = 0; i < resolution * revolutions; i++) {

    

    float offset = map(noise(n), 0, 1, -2, 2);
    n = n + n_amount;
    println(offset);
  
    
    // crazy mandala circle...
    //float x = cos(i) * radius ;
    //float y = sin(i) *radius ;
    
    // crazy noiseyt circle
    //float x = cos(radians(i + offset)) * radius;
    //float y = sin(radians(i - offset)) * radius;
    
    
    float x = cos(radians(i * angle)) * radius;
    float y = sin(radians(i * angle)) * radius;
    
    // this will show where the points are
    //ellipse(x,y,10,10);
    
    vertex(x * offset, y * offset);
    noFill();
  }
  endShape(CLOSE);
  //if (frameCount == 10){
  //  saveFrame();
  //};
};