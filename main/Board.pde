/** Class Board
  * Stores the state of the board - creates 10 pits in random Tiles upon instantiation. Sets breeze in Tiles adjacent to pits 
  * Puts gold in a random Tile and sets glitter in adjacent Tiles
  *
  * Authors:         Kyle Davis, Kate Evans, Nadya Pena, Leanna Stecker
  * Last Modified:   5/7/2015
  * Arificial Intelligence
  * Dr. Salgian
  */
class Board{
  
  /** size - for an 8x8 board */
  final int size = 8;
  /** boardPix - sets the dimensions of the board */
  final int boardPix = 600;
  /** rectSize - the size of each Tile */
  final int rectSize = boardPix/8;
  /** board - 2d Tile array that acts as our board */
  Tile[][] board = new Tile [size][size];
  /** goldPickedUp - boolean that indicates if the player has landed on the Tile with gold */
  boolean goldPickedUp = false;
  
  /** Board Constructor - instantiates each position of board with Tiles. Gives each Tile what their X/Y position is on the board */
  public Board(){
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        board[i][j] = new Tile();
        board[i][j].setPit(false);
        board[i][j].updateXY(i*rectSize+rectSize/2,j*rectSize+rectSize/2);
        board[i][j].setXGUI(i);
        board[i][j].setYGUI(j);
      }
    }
  } 
   
   /** Function to set 10 random pits on the board */
   public void setPits(){
     for (int i = 0; i < 10; i++) {
       /** x coordinate of the pit */
        int pit1;
        /** y coordinate of the pit */
        int pit2;
        Tile tileToSet;
        do {
          /** random variables from 0-7 for the position of the pit */
          float x = random(0, 8);
          float y = random(0, 8);
          /** random variables are float - therefore, we cast them to int and make them the x/y coordinate of the pit */
          pit1 = int(x);
          pit2 = int(y);
          tileToSet = board[pit1][pit2];
        //the ORs are to ensure the player and Wumpus do not spawn on top of pits
        } while(tileToSet.getPit() == true || (pit1==0 && pit2==7) || tileToSet.getWumpus());
        tileToSet.setPit(true);
        /** If statements necessary to set breeze of Tiles adjacent to pits */
        if (pit2 < 7) {
           board[pit1][pit2+1].setBreeze(true); 
        }
        if (pit2 > 0) {
           board[pit1][pit2-1].setBreeze(true);
        }
        if (pit1 < 7) {
           board[pit1+1][pit2].setBreeze(true); 
        }
        if (pit1 > 0) {
           board[pit1-1][pit2].setBreeze(true); 
        }
     }
   }
   
   /** Function setGold randomly picks a Tile (that does not have a pit and does not contain the wumpus) and places gold on that Tile 
     * pre-condition: pits have to be set and Wumpus spawned 
     */ 
   public void setGold(){
     /** x/y coordinates of Tile on which to place gold */
     int gold1;
     int gold2;
     Tile tileToSet;
     do {
       /** random variables from 0-7 for the position of the pit */
       float x = random(0, 8);
       float y = random(0, 8);
       /** random variables are float - therefore, we cast them to int and make them the x/y coordinate of the pit */
       gold1 = int(x);
       gold2 = int(y);
       tileToSet = board[gold1][gold2];
     } while(tileToSet.getPit() || tileToSet.getWumpus() || (gold1==0 && gold2==7));
     tileToSet.setGold(true);
     /** If statements necessary to set glitter of Tiles adjacent to gold */
        if (gold2 < 7) {
           board[gold1][gold2+1].setGlitter(true); 
        }
        if (gold2 > 0) {
           board[gold1][gold2-1].setGlitter(true);
        }
        if (gold1 < 7) {
           board[gold1+1][gold2].setGlitter(true); 
        }
        if (gold1 > 0) {
           board[gold1-1][gold2].setGlitter(true); 
        }
   }
   
   /** getTile - given an x and y coordinate, it returns the Tile at that position of board */
   public Tile getTile(int x, int y){
     //print(x + ", " + y);
     return board[x][y]; 
   }
   
   /** function setGoldPickedUp - Once the gold is picked up by the player, it sets setGoldPickedUp to true, which then sets the boolean goldPickedUp to true */
   void setGoldPickedUp(boolean gpu) {
     goldPickedUp = gpu;
   }
   
   /** function getGoldPickedUp - Returns the boolean goldPickedUp */
   boolean getGoldPickedUp(){
     return goldPickedUp; 
   }
   
   
   
}
