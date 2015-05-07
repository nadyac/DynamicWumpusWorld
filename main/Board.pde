class Board{
  
  final int size = 8;
  final int boardPix = 600;
  final int rectSize = boardPix/8;
  Tile[][] board = new Tile [size][size];
  
  boolean goldPickedUp = false;
  
  public Board(){
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        board[i][j] = new Tile();
        //Tile tile = board[i][j];
        board[i][j].setPit(false);
        //tile.setPit(false);
        board[i][j].updateXY(i*rectSize+rectSize/2,j*rectSize+rectSize/2);
        board[i][j].setXGUI(i);
        board[i][j].setYGUI(j);
      }
    }
  } 
   
   public void setPits(){
     for (int i = 0; i < 10; i++) {
        int pit1;
        int pit2;
        Tile tileToSet;
        do {
          float x = random(0, 8);
          float y = random(0, 8);
          pit1 = int(x);
          pit2 = int(y);
          tileToSet = board[pit1][pit2];
        //the ORs are to ensure the player and Wumpus do not spawn on top of pits
        } while(tileToSet.getPit() == true || (pit1==0 && pit2==7) || tileToSet.getWumpus());
        tileToSet.setPit(true);
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
   
   //pre-condition: pits have to be set and Wumpus spawned
   public void setGold(){
     int gold1;
     int gold2;
     Tile tileToSet;
     do {
       float x = random(0, 8);
       float y = random(0, 8);
       gold1 = int(x);
       gold2 = int(y);
       tileToSet = board[gold1][gold2];
     } while(tileToSet.getPit() == true || tileToSet.getWumpus());
     tileToSet.setGold(true);
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
   
   public Tile getTile(int x, int y){
     //print(x + ", " + y);
     return board[x][y]; 
   }
   
   void setGoldPickedUp(boolean gpu) {
     goldPickedUp = gpu;
   }
   
   boolean getGoldPickedUp(){
     return goldPickedUp; 
   }
   
}
