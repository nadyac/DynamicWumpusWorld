class Arrow{
  PImage arrow = loadImage("doodleArrow.png");
  
  int xGUI = 300;
  int yGUI = 300;
 
  void shoot(int x1, int y1){
    xGUI = x1;
    yGUI = y1;
  }
  
  void display(){
    image(arrow, xGUI, yGUI, 50, 25);
  }
}
