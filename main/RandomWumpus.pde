import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

class RandomWumpus{
  PImage randomWumpus = loadImage("randomwumpus.png");
  
  Minim minim;
  AudioPlayer SFXpit;
  
  int xCoordinate;
  int yCoordinate;
  Knowledgebase kb;
  
  int xGUI; 
  int yGUI;
  int speed = 75;
   
   /*Constructor*/
   RandomWumpus(){
     /*Calculate starting coordinates*/
     xCoordinate = startX();
     yCoordinate = startY(); 
     
    /*Set the wumpus's coordinates in pixels*/
     xGUI = xCoordinate*75;
     yGUI = yCoordinate*75; 
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
       //print the possible moves (remove this later)
       /*
       print("possible wumpus moves: \n");
       for(int[] moves: possibleMoves){
         print(moves[0]+ "," + moves[1] + "\n");
       }
       return possibleMoves;
       */
  }
   
   /*Choose a random move from the possible moves*/
   void makeMove(AudioPlayer SFXpit){
     
     int[] nextMove = null;
     
     //get the list of possible moves
      ArrayList<int[]> possibleMoves = getPossibleMoves();
      
     //randomly choose a move from the list of moves
      float randMove = random(0,2);
      int randomMove = int(randMove);
      //print("next Move for RandomWumpus: " + possibleMoves.get(randomMove) + "\n");
      nextMove = possibleMoves.get(randomMove);
      
      //print("next move: " + nextMove[0] + "," + nextMove[1] + "\n");
      move(nextMove);
      if(board.getTile(xCoordinate, yCoordinate).getPit()){
        if(!SFXpit.isPlaying())
          SFXpit.rewind();
        SFXpit.play();
      }
     }
  
    /*Display the Wumpus on the board*/  
    void display(){
      image(randomWumpus, xGUI, yGUI, 75, 75);
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
          //print("wumpus location: " + xCoordinate + "," + yCoordinate + "\n");
    }
}
  
