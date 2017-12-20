
float offset;
float speed;
int amplitude = 100;
float [] balls;
int xoffset = 110;
float steepness = .14555;

void Line () {
  //ellipse(10, 10, 10, 10);
  offset += 5;
  
  
  speed += .03;
  

  
   //+ sin(offsety)*amplitude
  
  for (int i = 0; i<25; i++){
    
    float x = xoffset + i*20;
    float y = height/2;
    float yoffset = cos(speed + i * .9 * steepness)*amplitude;
    int sizex = 10;
    int sizey = 10;
      
    fill(0,0,0);
    ellipse(x , y + yoffset * -1, sizex, sizey);
    fill(255,0,0);
    ellipse(x, y + yoffset, sizex, sizey);

  };
  
  
};

void setup() {
  size(640, 360);
  background(255);
  pixelDensity(2);
  //frameRate(4);
}

void draw() {
  background(255);
  fill(0);
  Line();
  
  fill(0, 102, 255);
  text(frameRate, 10,20);
}