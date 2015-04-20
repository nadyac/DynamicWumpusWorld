class Wumpus{
  PImage wumpus = loadImage("wumpus.png");
  
  int xCoordinate;
  int yCoordinate;
  Knowledgebase kb;
  
  int xGUI; 
  int yGUI;
  int speed = 75;
   
   /*Constructor*/
   Wumpus(){
     /*Calculate starting coordinates*/
     xCoordinate = startX();
     yCoordinate = startY(); 
     
<<<<<<< HEAD
=======
     print("wumpus starts at " + xCoordinate + "," + yCoordinate + "\n");
     
>>>>>>> d01ea5cea9b41c5f0fa1de8e7a263e66fb4f040a
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
  
  int getXCoordinate(){
     return xCoordinate; 
  }
  
  int getYCoordinate(){
    return yCoordinate;
  }
  
  /*Get all possible moves */
  void getPossibleMoves(){
    ArrayList<int[]> possibleMoves = new ArrayList<int[]>();
    
      //Assume that can move to all 4 directions (which is not true
      //when the wumpus is at the boundary of the world)
       int[] move0 = {xCoordinate-1,yCoordinate};
       possibleMoves.add(move0);
       
       int[] move1 = {xCoordinate + 1,yCoordinate};
       possibleMoves.add(move1);
       
       int[] move2 = {xCoordinate,yCoordinate + 1};
       possibleMoves.add(move2);
       
       int[] move3 = {xCoordinate,yCoordinate - 1};
       possibleMoves.add(move3);
       
       //print the possible moves (remove this later)
       print("possible wumpus moves: \n");
       for(int[] moves: possibleMoves){
         print(moves[0]+ "," + moves[1] + "\n");
       }
  }
  
  /* Calculate best move based on sound*/
  void getBestMoveBySound(ArrayList<int[]> possibleMovesList){
    
    //get possible tiles to move
    
  }
  
  /*Display the Wumpus on the board*/  
  void display(){
    image(wumpus, xGUI, yGUI, 75, 75);
  }
  
  /*Move that Wumpus!*/
  void move() {
    if (yGUI != 0 && yCoordinate!=0) {
      yGUI = yGUI - speed;
      yCoordinate = yCoordinate-1;
       
     } 
    else if (yGUI!=600 && yCoordinate!=7) {
      yGUI = yGUI + speed;
      yCoordinate = yCoordinate+1;
    }
    else if (xGUI!=600 && xCoordinate!=7) {
      xGUI = xGUI + speed;
      xCoordinate = xCoordinate+1;
    }
    else if (xGUI!=0 && xCoordinate!=0) {
      xGUI = xGUI - speed;
      xCoordinate = xCoordinate-1;
    }     
  }
  
}
