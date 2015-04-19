int x;
int y;


int numberOfRectangles = 8;

Player player;
Board board;

int boardSize = 600;
int rectSize = boardSize/8;


void setup(){
  board = new Board();
  size(boardSize, boardSize);
  player = new Player(0, 7);
  Tile tile = board.getTile(player.getXCoordinate(), player.getYCoordinate());
  tile.setPlayer(true);
  board.setPits();
  smooth();
}



void draw(){
  for (x = 0; x < numberOfRectangles; x++){
    for (y = 0; y < numberOfRectangles; y++){
      fill(153);
      stroke(0);
      rect(x*rectSize, y*rectSize, rectSize, rectSize);
      
      //if(x%2 == 0 && y%2 == 0){
         Tile tile = board.getTile(x, y);
         tile.display();
     // }
    }
  } 
  player.display();
}
/*move if the player pressed a key */
void keyPressed(){
  board.getTile(player.getXCoordinate(), player.getYCoordinate()).setPlayer(false);
  player.move();
  board.getTile(player.getXCoordinate(), player.getYCoordinate()).setPlayer(true);
  int x = player.getXCoordinate();
  int y = player.getYCoordinate();
  
  print(x + ", " + y);  
}

