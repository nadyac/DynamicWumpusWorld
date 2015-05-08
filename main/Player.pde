/** 
 * Class Player
 * Representation of the human-controlled entity of the game
 *
 * Authors:         Kyle Davis, Kate Evans, Nadya Pena, Leanna Stecker
 * Last Modified:   5/7/2015
 * Arificial Intelligence
 * Dr. Salgian
 */
class Player{
  PImage player = loadImage("archer1.png");
  
  /* xCoordinate: player's x coord in terms of the gam grid (0-7)
     yCoordinate: player's y coord in terms of the gam grid (0-7) */
  int xCoordinate; 
  int yCoordinate;
  
  /** The player's knowledgebase. The board as the player has seen so far */
  Knowledgebase kb;
  
 /* xGUI: player's x coord in pixels
    yGUI: player's y coord in pixels */
  int xGUI; 
  int yGUI;
  
 /* speed: how many pixels the player travels each move */  
  int speed = 75;
  
  /** 
   * Constructor for instantiating a player object. 
   * x1: the player's x coord in terms of the grid 
   * y1: the player's y coord in terms of the grid*/
  Player(int x1, int y1){
   kb = new Knowledgebase();
   xCoordinate = x1;
   yCoordinate = y1; 
   
  /*Set the player's coordinates in pixels*/
   xGUI = x1*75;
   yGUI = y1*75; 
  }
  
  /** display the player on the GUI */
  void display(){
    image(player, xGUI, yGUI, 75, 75);
  }
  
  /** returns x coord of player */
  int getXCoordinate(){
    return xCoordinate; 
  }
  
  /** returns y coord of player */
  int getYCoordinate(){
    return yCoordinate;
  }
  
  /** returns knowledgebase of player */
  Knowledgebase getKB() {
     return kb; 
  }
  
  /** modify the x coord of player */
  void setXCoordinate(int x){
    xCoordinate = x; 
  }
  
  /** modify the y coord of player */
  void setYCoordinate(int y){
    yCoordinate = y; 
  }
  
  /** updates the coordinates of the player upon pressing on of the directional keys,
   *  providing the player is not trying to move out of the boundary of the board */
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
      println("Please use the arrow keys to move. Press repeatedly for motion.");
    }       
  }
  
  /** Determines if the tile the player is on is also the tile that contains gold. */
  boolean checkForGold(Board board) {
    if(board.getTile(xCoordinate, yCoordinate).getGold()){
      board.setGoldPickedUp(true);
      return true;
    } 
    return false;
  }
  
}
