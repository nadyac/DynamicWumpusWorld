import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

class AStarWumpus{
  PImage astar_wumpus = loadImage("smartwumpus.png");
  
  int xCoordinate;
  int yCoordinate;
  Knowledgebase kb;
  float travelDistance; //unit dist traveled already
  
  int xGUI; 
  int yGUI;
  int speed = 75;
   
   /*Constructor*/
   AStarWumpus(){
     
     /*Calculate starting coordinates*/
     xCoordinate = startX();
     yCoordinate = startY(); 
     
    /*Set the wumpus's coordinates in pixels*/
     xGUI = xCoordinate*75;
     yGUI = yCoordinate*75; 
     
     /*Initialize the travel cost encurred thus far (should be 0) */
     travelDistance = 0;
     
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
  
  int getXCoordinate(){
     return xCoordinate; 
  }
  
  int getYCoordinate(){
    return yCoordinate;
  }
  
  /*Get all possible moves and weight them against the current travel cost
   as well as the estimated travel cost (considering pits) and safer routes*/
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
  
  /**
  * Calculate straight-line distance between Wumpus's possible moves and the player
  */
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
     
      float currentETD = 0; //Estimated Travel Distance from current move to player
      float bestETD = 10000; //Estimated Travel Distance current best move to player (initially something arbitrarily high)
      
     float tmpSound = 0;
     float sound = 10000;
     int[] bestMove = null;
     boolean shouldMove = true;
     
     //get the player's location 
      int[] playerLocation = getPlayerLocation(b);
      ArrayList<int[]> possibleMoves = getPossibleMoves();
      
      //print ("\n ****************************************************");
      //loop through each possible move and evaluate them
      for (int[] possibleMove: possibleMoves){
        tmpSound = calculateSound(possibleMove, playerLocation);
        
        currentETD = travelDistance + tmpSound;
        
        //print ("\n" + "Travel Distance: " + travelDistance + "\n");
        //print("current ETD of tile " + possibleMove[0] + "," + possibleMove[1] + " is: " + currentETD + "\n");
        
        //if tile exists in kb, then get its safety value and its total estimated travel distance
        if (kb.getTile(possibleMove[0], possibleMove[1]) != null) { 
          
          //print ("***Tile already in KB***" + "\n");

          //print ("SAFETY being added to currentETD: " + kb.getTile(possibleMove[0], possibleMove[1]).getSafety() + "\n");
          currentETD = currentETD + kb.getTile(possibleMove[0], possibleMove[1]).getSafety();  //calculate estimated travel cost for the possible move with penalty
          //print("UPDATED current ETD of tile " + possibleMove[0] + "," + possibleMove[1] + " is: " + currentETD + "\n");
          
        } if (b.getTile(xCoordinate, yCoordinate).getBreeze() == true){
          currentETD = currentETD + 1; //add penalty of 1 to each possible move because there is a pit nearby
          //print("Breeze in tile " + possibleMove[0] + "," + possibleMove[1] + " UPDATED current ETD is: " + currentETD + "\n");
        }
        
        if(currentETD < bestETD){
          sound = tmpSound;
          bestMove = possibleMove; //current possible move is best so far 
          bestETD = currentETD;
        } 
      } 
     /* 
     print("\n" + "best move for A* Wumpus: " + bestMove[0] + "," + bestMove[1] + "\n");
     print ("**************************************************** \n");
     */
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
      image(astar_wumpus, xGUI, yGUI, 75, 75);
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
        
        travelDistance++;    
    }
    
     public Knowledgebase getKB(){
       return kb; 
    }
    
}
  
