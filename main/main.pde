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
        tile.updatePit(true);
        tile.updateXY(i*rectSize+rectSize/2,j*rectSize+rectSize/2);
    }
  }
  smooth();
}

void draw(){
  for (x = 0; x < numberOfRectangles; x++){
    for (y = 0; y < numberOfRectangles; y++){
      fill(153);
      stroke(0);
      rect(x*rectSize, y*rectSize, rectSize, rectSize);
      
      if(x%2 == 0 && y%2 == 0){
         Tile tile = board[x][y];
         tile.display();
      }
    }
  }
  player.display();
}

void keyPressed(){
 player.move();
}

