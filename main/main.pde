int x;
int y;


int numberOfRectangles = 8;

Tile [][] board = new Tile[8][8];
Player player;

int boardSize = 600;
int rectSize = boardSize/8;


void setup(){
  size(boardSize, boardSize);
  player = new Player(0, 7);
  for(int i = 0; i < 8; i++){
    for(int j = 0; j < 8; j++){
      board[i][j] = new Tile();
        Tile tile = board[i][j];
        tile.setPit(false);
        tile.updateXY(i*rectSize+rectSize/2,j*rectSize+rectSize/2);
    }
  }
  for (int i = 0; i < 10; i++) {
        int pit1;
        int pit2;
        do {
          float x = random(0, 7);
          float y = random(0, 7);
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
  smooth();
  int count = 0;
  for(int i = 0; i < 8; i++){
    for(int j = 0; j < 8; j++){
        if (board[i][j].getPit() == true) {
          count++;
        }
    }
  }
  print(count);
}



void draw(){
  for (x = 0; x < numberOfRectangles; x++){
    for (y = 0; y < numberOfRectangles; y++){
      fill(153);
      stroke(0);
      rect(x*rectSize, y*rectSize, rectSize, rectSize);
      
     // if(x%2 == 0 && y%2 == 0){
         Tile tile = board[x][y];
         tile.display();
      //}
    }
  }
  player.display();
}

void keyPressed(){
 player.move();
}

