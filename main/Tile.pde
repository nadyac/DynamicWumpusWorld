/**
 * Class Tile
 * Representation of a tile on the game grid.
 */

class Tile{
  PImage gold = loadImage("goldBar.png");
  
  /** Unlike other classes, is actually pixel location of tile out of 600 */
  int xCoordinate;
  int yCoordinate;
  
  /** Unlike other classes, is actually coordinate location of tile based on 8x8 grid */
  int xGUI;
  int yGUI;
  
  /** "has" variables contain info of what is on the tile. These include percepts and game objects. */
  boolean hasGold;
  boolean hasGlitter;
  boolean hasBreeze;
  boolean hasStench;
  boolean hasWumpus;
  boolean hasPlayer;
  boolean hasPit = false;
  
  /** danger level rating of tile. 0 for absolutely no pit, 1.4 for definite pit, and 1 for possible pit  */
  float safety = 0; 
  
  /** update if tile has gold on it */
  void setGold(boolean setGold){
    hasGold = setGold;
  }
  
  /** update if tile has glitter percept on it */
  void setGlitter(boolean set){
    hasGlitter = set;
  }
  
  /** update if tile has breeze percept on it */
  void setBreeze(boolean setBreeze){
      hasBreeze = setBreeze;
  }
  
  /** update if tile has pit on it */
  void setPit(boolean set){
    hasPit = set;
  }
  
  /** update if tile has stench percept on it */
  void setStench(boolean set){
    hasStench = set;
  }
  
  /** update id tile has the Wumpus on it */
  void setWumpus(boolean set){
    hasWumpus = set;
  }
  
  /** update if tile has the player on it */
  void setPlayer(boolean set){
    hasPlayer = set;
  }
  
  /** update x coordinate */
  void setXGUI(int x1) {
    xGUI = x1;  
  }
  
  /** update y coordinate */
  void setYGUI(int y1) {
     yGUI = y1; 
  }
  
  /** update danger level */
  void setSafety(float safetyRanking) {
    safety = safetyRanking;
  }
  
  /** update pixel coordinates */
  void updateXY(int x1, int y1){
    xCoordinate = x1;
    yCoordinate = y1;
    
  }
  
  /** return if this tile has a pit on it */
  boolean getPit() {
    return hasPit;  
  }
  
  /** return if this tile has a breeze percept on it */
  boolean getBreeze() {
    return hasBreeze;  
  }
  
  /** return if this tile has a Wumpus on it */
  boolean getWumpus() {
    return hasWumpus; 
  }
  
  /** return if this tile has a stench percept on it */
  boolean getStench() {
    return hasStench; 
  }
  
  /** return if this tile has a glitter percept on it */
  boolean getGlitter() {
    return hasGlitter; 
  }
  
  /** return if this tile has the gold on it */
  boolean getGold() {
    return hasGold; 
  }
  
  /** return this tile's x coordinate */
  int getXGUI() {
      return xGUI;
  }
  
  /** return this tile's y coordinate */
  int getYGUI() {
     return yGUI; 
  }
  
  /** return this tile's danger rating */
  float getSafety() {
     return safety; 
  }
  
  /** return this tile's x pixel location */
  int getXCoordinate() {
      return xCoordinate;
  }
  
  /** return this tile's y pixel location */
  int getYCoordinate() {
     return yCoordinate; 
  }
  
  /** displaying this tile on the GUI as (1/64th of the whole game grid) */
  void display(Board b){
    /** drawing a pit; 50 x 50 pixels */
    if(hasPit == true){
      fill(0, 50);
      ellipseMode(CENTER);
      ellipse(xCoordinate, yCoordinate, 50, 50);
    }
    /** print a "G" on the tile if glitter percept is found on this tile */
    if(hasGlitter == true){
      fill(0);
      text("G", xCoordinate-25, yCoordinate-25);
    }
    /** print a "B" on the tile if breeze percept is found on this tile */
    if(hasBreeze == true){
      fill(0);
      text("B", xCoordinate-35, yCoordinate-25);
    }
    /** display image of gold bars on tile if the gold has not been previously picked up */
    if(hasGold == true && !b.getGoldPickedUp()){
      image(gold, xCoordinate-25, yCoordinate-25, 50, 50);
    } 
    
  }
  
}
