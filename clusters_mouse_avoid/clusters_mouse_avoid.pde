int amt_obj = 100;
Cluster c = new Cluster();
Cluster[] cluster_list = new Cluster[amt_obj];

void setup () {
  size(1280, 720, P2D);
  background(255);
  pixelDensity(2);
  //frameRate(24);
  
  // init clusters...
  for (int i =0; i< cluster_list.length; i++) {
    cluster_list[i] = new Cluster();
  }
}



void draw() {
  background(255); //<>//
  for (int i =0; i< cluster_list.length; i++) {
    cluster_list[i].show();
    
  }
  println(frameRate);


  //noLoop();
}