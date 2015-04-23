int x;
int y;

int numberOfRectangles = 8;

Player player;
Wumpus wumpus;
RandomWumpus randomWumpus;

Board board;
Timer timer = new Timer(2000);

int boardSize = 600;
int rectSize = boardSize/8;


void setup(){
  board = new Board();
  size(boardSize, boardSize);
  timer.start();
  
  player = new Player(0, 7);
  
  wumpus = new Wumpus();
  randomWumpus = new RandomWumpus();
  
  Tile tile = board.getTile(player.getXCoordinate(), player.getYCoordinate());
  tile.setPlayer(true);
  
  board.setPits();
  board.setGold();
  
  Tile playerTile = board.getTile(player.getXCoordinate(), player.getYCoordinate());
  playerTile.setPlayer(true);
  int x = wumpus.getXCoordinate();
  int y = wumpus.getYCoordinate();
  Tile wumpusTile = board.getTile(x, y);
  wumpusTile.setWumpus(true);
  /** Setting all the tiles around the wumpus that have stench - this probably should be done in board, but wumpus is initiated here, so I kept it as is.
    * Feel free to change as you see fit!
    */
   if (y < 7) {
      Tile wt1 = board.getTile(x, y+1);
      wt1.setStench(true); 
   }
   if (y > 0) {
      Tile wt2 = board.getTile(x, y-1);
      wt2.setStench(true);
   }
   if (x < 7) {
      Tile wt3 = board.getTile(x+1, y);
      wt3.setStench(true);
   }
   if (x > 0) {
      Tile wt4 = board.getTile(x-1, y);
      wt4.setStench(true);
   }
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
  wumpus.display();
  randomWumpus.display();
  
  //timer stuff
    if(timer.finish()){
    wumpus.makeMove(board);
    randomWumpus.makeMove();
    timer.start();
  }
}

/*move if the player pressed a key. this is when the board updates. */
void keyPressed(){
  /** Unsets the player's position from the old tile */
  board.getTile(player.getXCoordinate(), player.getYCoordinate()).setPlayer(false);
  /** Player makes their new move */
  player.move();
  /** Sets the tile for the player's new position */
  board.getTile(player.getXCoordinate(), player.getYCoordinate()).setPlayer(true);
  
  /** If there is a tile near a pit and the wumpus */
   if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getStench() == true && board.getTile(player.getXCoordinate(), player.getYCoordinate()).getBreeze() == true) {
      print("There is a stenchy breeze...\n\n\n");  
   }
   /** If there is a tile only near a pit */
   else if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getBreeze() == true) {
      print("There is a breeze..." + "\n\n\n");  
   }
   /** If there is a tile only near the wumpus */
   else if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getStench() == true) {
      print("There is a stench..." + "\n\n\n");  
  }
  /** Otherwise, it is a safe tile and should "clear" the console */
  else {
    print("\n\n\n\n\n");  
  }

}
