PImage img;

void setup() {
  size(1000,1000,P2D);
  // Images must be in the "data" directory to load correctly
  img = loadImage("MarcBW.jpg");
  img.loadPixels();
  
}

void draw() {
  rect(0, width/2, width/2, height/2);

}