int x;
int y;

PImage wumpus;

int numberOfRectangles = 8;

Tile [][] board = new Tile[8][8];

int boardSize = int(random(10,75))*8;
int rectSize = boardSize/8;

int rectColor1 = 0;
int rectColor2 = 255;

void setup(){
  size(boardSize, boardSize);
  wumpus = loadImage("wumpus.jpg");
  for(int i = 0; i < 8; i++){
    for(int j = 0; j < 8; j++){
      board[i][j] = new Tile();
        Tile tile = board[i][j];
        //tile.updatePit(true);
        tile.updateXY(i*rectSize,j*rectSize);
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
  //image(wumpus, 50, 50);
}


