Circ c = new Circ();
Circ[] circ_list = new Circ[1];


void setup() {
  size(1000, 700);
  background(0);
  pixelDensity(2);
  
  for (int i =0; i< circ_list.length; i++) {
    circ_list[i] = new Circ();
  }
}


float c_r = 20;

void draw() {
  background(300);
  
  translate(width/2, height/2);
  circ_list[0].make_circle();
  noLoop(); //<>//
}