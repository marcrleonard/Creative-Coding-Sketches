float list[];
float xoff = 0;
float yoff = 1 ;

void setup (){
  background(55); 
  size(400,400);
}

void draw() {
  background(55); 
  
  //float y = map(noise(yoff), 0, 1, 0,height);
  float y = height/2;

  stroke(255);
  noFill();
  beginShape();
  for (int x = 0; x < width; x++){
    float ypoint = noise(xoff)*width;
    ellipse(x,ypoint,5,5);
    vertex(x, ypoint);
    xoff += .01;
    yoff += .01;
  }
  endShape();
  noLoop();
  //println(list);
}