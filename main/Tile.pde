class Tile{
  int xCoordinate;
  int yCoordinate;
  
  boolean hasGold;
  boolean hasBreeze;
  boolean hasStench;
  boolean hasWumpus;
  boolean hasPlayer;
  boolean hasPit = false;
  
  void setGold(){
    
  }
  
  void setBreeze(boolean setBreeze){
      hasBreeze = setBreeze;
  }
  
  void setPit(boolean set){
    hasPit = set;
  }
  
  void setStench(){
    
  }
  
  void setWumpus(){
    
  }
  
  void setPlayer(){
    
  }
  
  void updateXY(int x1, int y1){
    xCoordinate = x1;
    yCoordinate = y1;
    
  }
  
  boolean getPit() {
    return hasPit;  
  }
  
  void display(){
    if(hasPit == true){
      fill(0);
      ellipseMode(CENTER);
      ellipse(xCoordinate, yCoordinate, 50, 50);
    }
  }
  
}
