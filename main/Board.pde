class Board{
  
  final int size = 8;
  final int boardPix = 600;
  final int rectSize = boardPix/8;
  Tile[][] board = new Tile [size][size];
  
  public Board(){
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        board[i][j] = new Tile();
        //Tile tile = board[i][j];
        board[i][j].setPit(false);
        //tile.setPit(false);
        board[i][j].updateXY(i*rectSize+rectSize/2,j*rectSize+rectSize/2);
      }
    }
  } 
   
   public void setPits(){
     for (int i = 0; i < 10; i++) {
        int pit1;
        int pit2;
        do {
          float x = random(0, 8);
          float y = random(0, 8);
          pit1 = int(x);
          pit2 = int(y);
        } while(board[pit1][pit2].getPit() == true);
        board[pit1][pit2].setPit(true);
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
   
   public Tile getTile(int x, int y){
     //print(x + ", " + y);
     return board[x][y]; 
   }
   
}
