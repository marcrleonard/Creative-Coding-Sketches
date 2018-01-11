//Circle c;
int amt_obj = 1000;

Circle[] circ_list = new Circle[amt_obj];

void setup() {
  size(600, 600, P2D);
  background(255);
  pixelDensity(2);
  frameRate(2);

  // this init's one object
  //c = new Circle();
  
  for (int i = 0; i < circ_list.length; i++) {
    circ_list[i] = new Circle();
    float x = random(0, width);
    float y = sin(i);
    println(y);

  }
  
}

void draw() {
  
  background(255);
  
  for (int i = 0; i < circ_list.length -i; i++) {

    circ_list[i].update(); 
    circ_list[i].display();
  };
  

  
  //noLoop();
  
  //make items
  //for (int i=0; i<100; i++) {
  //}
  //println(frameRate);
  
}