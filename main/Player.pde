class Player{
  PImage player = loadImage("archer1.png");
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
  
  int getXCoordinate(){
    return xCoordinate; 
  }
  
  int getYCoordinate(){
    return yCoordinate;
  }
  
  void setXCoordinate(int x){
    xCoordinate = x; 
  }
  
  void setYCoordinate(int y){
    yCoordinate = y; 
  }
  
  void move() {
    if (keyCode == UP && yGUI != 0 && yCoordinate!=0) {
      yGUI = yGUI - speed;
       yCoordinate = yCoordinate-1;
     } 
    else if (keyCode == DOWN && yGUI!=600 && yCoordinate!=7) {
      yGUI = yGUI + speed;
      yCoordinate = yCoordinate+1;
    }
    else if (keyCode == RIGHT && xGUI!=600 && xCoordinate!=7) {
      xGUI = xGUI + speed;
      xCoordinate = xCoordinate+1;
    }
    else if (keyCode == LEFT && xGUI!=0 && xCoordinate!=0) {
      xGUI = xGUI - speed;
      xCoordinate = xCoordinate-1;
    }
    else {
      println("Please use the arrow keys to move. Press repeatedly for motion. o and p control speed.");
    }       
  }
  
}
