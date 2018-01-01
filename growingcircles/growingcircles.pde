

void setup() {

  background(255);
  size(1280, 720);
  //smooth();
  //pixelDensity(2);
}

void draw() {

  background(255);

  // Display circle at x position
  stroke(0);
  strokeWeight(2);
  fill(127);


  int pixelSpacingX = 20;
  int pixelSpacingY = 20;
  
  int rowsX = width/pixelSpacingX;
  int rowsY = height/pixelSpacingY;
  
  int paddingX = pixelSpacingX/2;
  int paddingY = pixelSpacingY/2;
 //<>//
  int counter = 1;
  
  //println(rowsY);
  //println(rowsX);
  //text(rowsY, 10, 30);
  
  for ( int y = 0; y < rowsY; y++) {
    for ( int x = 0; x < rowsX; x++) {
      fill(50);
      ellipse((x * rowsX) , (y * rowsY),1*frameCount,1*frameCount);
      counter +=1;
    }
  }
  //noLoop();
  fill(0, 102, 255);
  text(frameRate, 10,20);
  text(counter, 10,40);

  
  
  
}