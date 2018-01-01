int resolution = 360;
int radius = 3;

void setup() {
  size(700, 700);
  background(255);
  
};

void draw() {
  translate(width/2, height/2);
  
  beginShape();
  for (int i = 0; i < resolution; i++) {
    
    float x = i* radius * sin(i);
    float y = i* radius * cos(i);
    
    vertex(x,y);
 
 }
 endShape();
}