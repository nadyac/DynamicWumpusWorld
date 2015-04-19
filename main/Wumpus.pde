class Wumpus{
  PImage wumpus = loadImage("wumpus.jpg");
  
  int xCoordinate;
  int yCoordinate;
  Knowledgebase kb;
  
  int xGUI; 
  int yGUI;
 
   Wumpus(){
     xCoordinate = startX();
     yCoordinate = startY(); 
     
     print("wumpus starts at " + xCoordinate + "," + yCoordinate);
     
    /*Set the wumpus's coordinates in pixels*/
     xGUI = xCoordinate*75;
     yGUI = yCoordinate*75; 
     
     /*Create empty knowledgebase*/
     Knowledgebase kb = new Knowledgebase();
  }
  
  /*Set x Coord for the Wumpus to start in*/
  int startX(){
     float x = random(3, 7);
     int xCoord = int(x); 
     return xCoord;
  }
  
  /* Set y Coord for the Wumpus to start in*/
  int startY(){
      float y = random(0, 4);
      int yCoord = int(y);
      return yCoord;
  }
  
  int getXposition(){
     return xCoordinate; 
  }
  
  int getYposition(){
    return yCoordinate;
  }
  
  /*Display the Wumpus on the board*/  
  void display(){
    image(wumpus, xGUI, yGUI, 75, 75);
  }
  
  
}
