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
  
  void setBreeze(){
    
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
    x = x1;
    y = y1;
    
  }
  
  void display(){
    if(hasPit == true){
      fill(0);
      ellipseMode(CENTER);
      ellipse(x, y, 50, 50);
    }
  }
  
}
