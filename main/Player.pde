class Player{
  PImage player = loadImage("wumpus.jpg");
  int xCoordinate; 
  int yCoordinate;
  
  int xGUI; 
  int yGUI;
  
  int speed = 75;
  
  Player(int x1, int y1){
   xCoordinate = x1;
   yCoordinate = y1; 
   
   xGUI = x1*75;
   yGUI = y1*75; 
  }
  void display(){
    image(player, xGUI, yGUI, 75, 75);
  }
  
  void move() {
    if (keyCode == UP) {
      yGUI = yGUI - speed; 
    }
    else if (keyCode == DOWN) {
      yGUI = yGUI + speed;
    }
    else if (keyCode == RIGHT) {
      xGUI = xGUI + speed;
    }
    else if (keyCode == LEFT) {
      xGUI = xGUI - speed;
    }
    else {
      println("Please use the arrow keys to move. Press repeatedly for motion. o and p control speed.");
    }       
  }
  
}
