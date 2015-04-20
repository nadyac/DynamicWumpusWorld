class Tile{
  int xCoordinate;
  int yCoordinate;
  
  boolean hasGold;
  boolean hasBreeze;
  boolean hasStench;
  boolean hasWumpus;
  boolean hasPlayer;
  boolean hasPit = false;
  
  void setGold(boolean setGold){
    hasGold = setGold;
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
  
  void display(){
    if(hasPit == true){
      fill(0);
      ellipseMode(CENTER);
      ellipse(xCoordinate, yCoordinate, 50, 50);
    }
  }
  
}
