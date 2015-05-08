import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

class AvoidingWumpus{
  PImage wumpus = loadImage("wumpus.png");//image of the wumpus
  
  Minim minim;
  AudioPlayer SFXpit;
  
  // coordinates on the board
  int xCoordinate;
  int yCoordinate;
  Knowledgebase kb;// knowledgebase
  
   //coordinates for the GUI
  int xGUI; 
  int yGUI;
   
   /*Constructor*/
   AvoidingWumpus(){
     /*Calculate starting coordinates*/
     xCoordinate = startX();
     yCoordinate = startY(); 
     
    /*Set the wumpus's coordinates in pixels*/
     xGUI = xCoordinate*75;
     yGUI = yCoordinate*75; 
     
     /*Create empty knowledgebase*/
     kb = new Knowledgebase();
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
  /* returns the x-coordinate of the wumpus on the board */
  int getXCoordinate(){
     return xCoordinate; 
  }
  /* returns the x-coordinate of the wumpus on the board */
  int getYCoordinate(){
    return yCoordinate;
  }
  
  /*Get all possible moves */
  ArrayList<int[]> getPossibleMoves(){
    ArrayList<int[]> possibleMoves = new ArrayList<int[]>();
      
      
      
      /**
      *Calculate all possible moves. Some moves will not 
      *be valid because they are off the grid (when the wumpus
      *is at the edge of the world)
      */
      if(xCoordinate != 0)
      {
         int[] move0 = {xCoordinate-1,yCoordinate}; //left
         possibleMoves.add(move0);
      }
      if(xCoordinate != 7) 
      {
         int[] move1 = {xCoordinate + 1,yCoordinate}; //right
         possibleMoves.add(move1);
      }
      if(yCoordinate != 7)
      { 
         int[] move2 = {xCoordinate,yCoordinate + 1}; //up
         possibleMoves.add(move2);
      }
      if(yCoordinate != 0)
      {
         int[] move3 = {xCoordinate,yCoordinate - 1}; //down
         possibleMoves.add(move3);
      } 
       return possibleMoves;
  }
  /**
  * getPlayerLocation - scan the board's tiles for the location of the player 
  */
  int[] getPlayerLocation(Board b){
    
     /*get player's location by searching the board and store them in an array*/
    for (int i = 0; i < 8; i++){
       for(int j = 0; j < 8; j++){
         if (b.getTile(i,j).hasPlayer == true){
             int[] playerCoordinates = {i, j};
             return playerCoordinates;
         } 
       }
    }
    return null;
  }
  
  float calculateSound(int[] possibleMove, int[] playerLocation){
    
    float result;
    //calculate straight line distance from player to given location
    result = sqrt(pow(playerLocation[0]-possibleMove[0], 2) + pow(playerLocation[1]-possibleMove[1], 2));
    return result;
  }
   
   /*Call necessary functions to get wumpus to move*/
   void makeMove(Board b, AudioPlayer SFXpit){
     Tile tempTile = b.getTile(xCoordinate, yCoordinate);
     kb.addKnowledge(tempTile);
     kb.updateInference(b);
     kb.SafeTile(xCoordinate, yCoordinate);
     float tmpSound = 0;
     float sound = 9;
     int[] bestMove = null;
     boolean shouldMove = true;
     
     //get the player's location 
      int[] playerLocation = getPlayerLocation(b);
      ArrayList<int[]> possibleMoves = getPossibleMoves();
      
      //loop through each possible move and evaluate them
      for (int[] possibleMove: possibleMoves){
        tmpSound = calculateSound(possibleMove, playerLocation);
        print("Tmp: " + tmpSound + " S: " + sound + "\n");
        print("current possible move: " + possibleMove[0] + "," + possibleMove[1] + " straightLine dist: " + tmpSound + " current sound: " + sound + "\n");
        print("x1: " + possibleMove[0] + " y1: " + possibleMove[1] + "\n");
        if (kb.getTile(possibleMove[0], possibleMove[1]) != null) { 
          print("Safety of this tile is: " + kb.getTile(possibleMove[0], possibleMove[1]).getSafety());
          tmpSound = tmpSound + kb.getTile(possibleMove[0], possibleMove[1]).getSafety();  
        }
        if(tmpSound < sound){
          sound = tmpSound;
          bestMove = possibleMove; //current possible move is best so far 
        }
      } 
      
      move(bestMove);
      if(board.getTile(xCoordinate, yCoordinate).getPit()){
          if(!SFXpit.isPlaying()) {
            SFXpit.rewind();
            SFXpit.play();
          }
      }
     
     }
  
    /*Display the Wumpus on the board*/  
    void display(){
      image(wumpus, xGUI, yGUI, 75, 75);
    }
    
    /*Move that Wumpus!*/
    void move(int[] bestMove) {
        //move down 1 square
        if (yGUI != 0 && yCoordinate!=0) {
          yGUI = bestMove[1]*75;
          yCoordinate = bestMove[1];
           
         } 
         //move up one square
        if (yGUI!=600 && yCoordinate!=7) {
          yGUI = bestMove[1]*75;
          yCoordinate = bestMove[1];
        }
        //move to the right 1 square
        if (xGUI!=600 && xCoordinate!=7) {
          xGUI = bestMove[0]*75;
          xCoordinate = bestMove[0];
        }
        //move to the left 1 square
        if (xGUI!=0 && xCoordinate!=0) {
          xGUI =  bestMove[0]*75;
          xCoordinate = bestMove[0];
        }     
    }
    
    /* returns the wumpus' knowledgebase*/
    public Knowledgebase getKB(){
       return kb; 
    }
}
  
