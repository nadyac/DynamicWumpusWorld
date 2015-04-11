class Tile{
  int x;
  int y;
  
  boolean hasPit = true;
  
  void display(){
    if(hasPit == true){
      fill(0);
      ellipseMode(CORNER);
      ellipse(x, y, 10, 10);
      System.out.println("X: " + x + " Y: " + y);
    }
  }
    
  void updateXY(int x1, int y1){
    x = x1;
    y = y1;
    
  }
  
  void updatePit(boolean update){
    hasPit = update;
  }
  
}
