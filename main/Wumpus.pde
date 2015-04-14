class Wumpus{
  PImage wumpus = loadImage("wumpus.jpg");
  
  int xCoordinate;
  int yCoordinate;
  
  int xGUI; 
  int yGUI;
  
  
  void display(){
    image(wumpus, xGUI, yGUI, 75, 75);
  }
  
}
