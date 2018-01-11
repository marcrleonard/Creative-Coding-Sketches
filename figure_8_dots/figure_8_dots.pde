int resolution = 100;
int radius = 200;
float angle = 360/ resolution;
float noise_inc = .10;

void setup() {
  size(600, 600);
  background(255);
  pixelDensity(2);
  //frameRate(200);
}

void draw() {
  float spiral = 1.0;
  
  
  
  int i = frameCount;
  //beginShape();
  //for (int i = 0; i < 360 * 6; i++) {
    spiral += .1;
    
    float color_amt = noise(noise_inc);
    noise_inc += 10;
    
    
    float x = sin(radians(i * angle)) * (radius + spiral);
    float y = cos(radians(i * .5 * angle)) * (radius + spiral);
    stroke(255*color_amt*2 + 40, 255*color_amt*2-30, 255*color_amt+20);
    //vertex(x + (width/2), y + (height/2));
   
    ellipse(x + (width/2), y + (height/2),5,5);
  //}
  //endShape();
  //noLoop();
  
}