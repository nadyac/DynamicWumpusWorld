class Tile{
  PImage gold = loadImage("goldBar.png");
  
  int xCoordinate;
  int yCoordinate;
  
  int xGUI;
  int yGUI;
  
  boolean hasGold;
  boolean hasGlitter;
  boolean hasBreeze;
  boolean hasStench;
  boolean hasWumpus;
  boolean hasPlayer;
  boolean hasPit = false;
  float safety = 0; 
  
  void setGold(boolean setGold){
    hasGold = setGold;
  }
  
  void setGlitter(boolean set){
    hasGlitter = set;
  }
  
  void setBreeze(boolean setBreeze){
      hasBreeze = setBreeze;
  }
  
  void setPit(boolean set){
    hasPit = set;
  }
  
  void setStench(boolean set){
    hasStench = set;
  }
  
  void setWumpus(boolean set){
    hasWumpus = set;
  }
  
  void setPlayer(boolean set){
    hasPlayer = set;
  }
  
  void setXGUI(int x1) {
    xGUI = x1;  
  }
  
  void setYGUI(int y1) {
     yGUI = y1; 
  }
  
  void setSafety(float safetyRanking) {
    safety = safetyRanking;
  }
  
  void updateXY(int x1, int y1){
    xCoordinate = x1;
    yCoordinate = y1;
    
  }
  
  boolean getPit() {
    return hasPit;  
  }
  
  boolean getBreeze() {
    return hasBreeze;  
  }
  
  boolean getWumpus() {
    return hasWumpus; 
  }
  
  boolean getStench() {
    return hasStench; 
  }
  
  boolean getGlitter() {
    return hasGlitter; 
  }
  
  boolean getGold() {
    return hasGold; 
  }
  
   int getXGUI() {
      return xGUI;
  }
  
  int getYGUI() {
     return yGUI; 
  }
  
  float getSafety() {
     return safety; 
  }
  
  int getXCoordinate() {
      return xCoordinate;
  }
  
  int getYCoordinate() {
     return yCoordinate; 
  }
  
  void display(){
    if(hasPit == true){
      fill(0, 50);
      ellipseMode(CENTER);
      ellipse(xCoordinate, yCoordinate, 50, 50);
    }
    //the 25 was trial and error!
    if(hasGold == true){
      image(gold, xCoordinate-25, yCoordinate-25, 50, 50);
    } 
    if(hasGlitter == true){
      fill(0);
      text("G", xCoordinate-25, yCoordinate-25);
    }
    if(hasBreeze == true){
      fill(0);
      text("B", xCoordinate-35, yCoordinate-25);
    }
  }
  
}
