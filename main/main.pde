int x;
int y;

int numberOfRectangles = 8;

Player player;
AvoidingWumpus avoidingwumpus;
RandomWumpus randomWumpus;

Board board;
//Timer timer = new Timer(2000);

int boardSize = 600;
int rectSize = boardSize/8;

//the # of turns the player has taken before the Wumpus moves
int playerTurns = 0;

int time;

boolean playerMove;

void setup(){
  board = new Board();
  size(boardSize, boardSize);
  //timer.start();
  //time = millis();
  playerMove = true;
  
  player = new Player(0, 7);
  
  avoidingwumpus = new AvoidingWumpus();
  randomWumpus = new RandomWumpus();
  
  Tile tile = board.getTile(player.getXCoordinate(), player.getYCoordinate());
  tile.setPlayer(true);
  
  board.setPits();
  board.setGold();
  
  Tile playerTile = board.getTile(player.getXCoordinate(), player.getYCoordinate());
  playerTile.setPlayer(true);
  int x = avoidingwumpus.getXCoordinate();
  int y = avoidingwumpus.getYCoordinate();
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
  avoidingwumpus.display();
  randomWumpus.display();
  
  /*wumpus movement for it's turn*/
  if(/*millis() - time >= 1000 &&*/ playerMove == false){
    if(playerTurns == 2){
      avoidingwumpus.makeMove(board);
      randomWumpus.makeMove();
      //time = millis();
      
      playerTurns = 0;
    }
    playerMove = true;
  }
  /*wumpus movement for when the player takes too long to move*/
  /*
  if(millis() - time >= 5000 && playerMove == true){
    avoidingwumpus.makeMove(board);
    randomWumpus.makeMove();
    //time = millis();
  }
  */
}

/*void delay(int d){
  int time = millis();
  while(millis() - time <= d);
}*/

/*move if the player pressed a key. this is when the board updates. */
void keyPressed(){
  if(playerMove == true){
    /** Unsets the player's position from the old tile */
    board.getTile(player.getXCoordinate(), player.getYCoordinate()).setPlayer(false);
    /** Player makes their new move */
    player.move();
    playerTurns++;
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
      playerMove = false;
  }

}
