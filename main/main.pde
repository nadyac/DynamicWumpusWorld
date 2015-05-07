int x;
int y;

int numberOfRectangles = 8;

Player player;
AvoidingWumpus avoidingwumpus;
RandomWumpus randomWumpus;
Knowledgebase kbDemo1;
Knowledgebase kbDemo2;
Knowledgebase kbPlay;

Board board;
Knowledgebase GUIKB;

int boardSize = 600;
int rectSize = boardSize/8;


int time;
int screens = 0;

boolean playerMove;


void setup(){
  board = new Board();
  size(boardSize*2+10, boardSize+100);
  //timer.start();
  time = millis();
  playerMove = true;
  
  player = new Player(0, 7);
  
  avoidingwumpus = new AvoidingWumpus();
  randomWumpus = new RandomWumpus();
  
  GUIKB = new Knowledgebase();
  kbDemo1 = avoidingwumpus.getKB();
  //kbDemo2 = astarwumpus.getKB();
  
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
  if(screens == 0){
    openScreen();
  }
  else{
    mainScreen();
  }
   
}

void mainScreen(){
  textSize(12);
   for (x = 0; x < numberOfRectangles; x++){
    for (y = 0; y < numberOfRectangles; y++){
      fill(153);
      stroke(0);
      rect(x*rectSize, y*rectSize, rectSize, rectSize);
      rect(x*rectSize+610, y*rectSize, rectSize, rectSize);
      fill(0);
      if(screens == 1 || screens == 2 || screens == 3 || screens == 7){
         Tile tile = board.getTile(x, y);
         tile.display();
      }
         Tile tempTile = null;
         if(screens == 1){
           textSize(48);
           text("NO KNOWLEDGEBASE", 665, 300);
         }
         textSize(12);
         if(screens == 2 || screens == 7 || screens == 8) {
           tempTile = kbDemo1.getTile(x,y);
         }
         if(screens == 3) {
           tempTile = kbDemo2.getTile(x,y);
         }
         if(screens == 4 || screens == 5 || screens == 6){
           tempTile = kbDemo1.getTile(x,y);
         }
         Tile newTile = new Tile();
         if(tempTile !=null){
           newTile.setXGUI(x);
           newTile.setYGUI(y);
           newTile.updateXY(tempTile.getXCoordinate(), tempTile.getYCoordinate());
           newTile.setPit(tempTile.getPit());
           newTile.setBreeze(tempTile.getBreeze());
           newTile.setStench(tempTile.getStench());
           newTile.setGlitter(tempTile.getGlitter());
           newTile.setGold(tempTile.getGold());
           GUIKB.addKnowledge(newTile);
         }
         
         Tile kbTile = GUIKB.getTile(x,y);
         if(kbTile != null){
           int xG = kbTile.getXCoordinate();
           int yG = kbTile.getYCoordinate();
           kbTile.updateXY(xG+610, yG);
           kbTile.display();
         }
    }
  } 
  player.display();
  if(screens == 1 || screens == 7){
    randomWumpus.display();
  }
  if(screens == 2 || screens == 7){
    avoidingwumpus.display();
  }
  if (screens == 3 || screens == 7){
    //astarwumpus.display();
  }
  
  /*wumpus movement for it's turn*/
  if(millis() - time >= 1000 && playerMove == false){
    if (screens == 1 || screens == 4 || screens == 7 || screens == 8){
      randomWumpus.makeMove();
    }
    if(screens == 2 || screens == 5 || screens == 7 || screens == 8){
      avoidingwumpus.makeMove(board);
    }
    if (screens == 3 || screens == 6 || screens == 7 || screens == 8){
      
    }
    time = millis();
    playerMove = true;
  }
  /*wumpus movement for when the player takes too long to move*/
  if(millis() - time >= 5000 && playerMove == true){
    avoidingwumpus.makeMove(board);
    randomWumpus.makeMove();
    time = millis();
  }
}

void openScreen(){
  fill(255);
  textSize(88);
  text("WUMPUS WORLD", 250, 100);
  textSize(50);
  text("DEMO", 150, 160);
  rect(75,180,300,100);
  fill(0);
  textSize(32);
  text("RANDOM WUMPUS", 83, 245);
  
  fill(255);
  rect(75,300,300,100);
  fill(0);
  textSize(32);
  text("GREEDY WUMPUS", 94, 360);
  
  fill(255);
  rect(75,420,300,100);
  fill(0);
  textSize(32);
  text("A* WUMPUS", 130, 480);
  
  fill(255);
  rect(75,540,300,100);
  fill(0);
  textSize(32);
  text("GOD MODE", 135, 600);
  
  textSize(50);
  fill(255);
  text("PLAY", 900, 160);
  rect(815,180,300,100);
  fill(0);
  textSize(32);
  text("RANDOM WUMPUS", 822, 245);
  
  fill(255);
  rect(815,300,300,100);
  fill(0);
  textSize(32);
  text("GREEDY WUMPUS", 833, 360);
  
  fill(255);
  rect(815,420,300,100);
  fill(0);
  textSize(32);
  text("A* WUMPUS", 878, 480);
  
  fill(255);
  rect(815,540,300,100);
  fill(0);
  textSize(32);
  text("GOD MODE", 878, 600);
}

/*move if the player pressed a key. this is when the board updates. */
String output = " ";
void keyPressed(){
  if(playerMove == true){
  /** Unsets the player's position from the old tile */
  board.getTile(player.getXCoordinate(), player.getYCoordinate()).setPlayer(false);
  /** Player makes their new move */
  player.move();
  /** Sets the tile for the player's new position */
  board.getTile(player.getXCoordinate(), player.getYCoordinate()).setPlayer(true);
  
  /** If there is a tile near a pit and the wumpus */
   if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getStench() == true && board.getTile(player.getXCoordinate(), player.getYCoordinate()).getBreeze() == true) {
      print("There is a stenchy breeze...\n\n\n"); 
      output = "There is a stenchy breeze...\n\n\n";
      fill(255);
      text(output, 100, 640); 
   }
   /** If there is a tile only near a pit */
   else if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getBreeze() == true) {
      print("There is a breeze..." + "\n\n\n");  
      output = "There is a breeze...";
      fill(255);
      text(output, 100, 650);
   }
   /** If there is a tile only near the wumpus */
   else if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getStench() == true) {
      print("There is a stench..." + "\n\n\n");  
      output = "There is a stench...";
      fill(255);
      text(output, 100, 630);
  }
  else if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getGlitter() == true) {
      print("There is glitter..." + "\n\n\n");  
      output = "There is glitter...";
      fill(255);
      text(output, 100, 670);
  }
  /** Otherwise, it is a safe tile and should "clear" the console */
  else {
    print("\n\n\n\n\n"); 
   fill(0);
   rect(95, 640, 200, 400);
  }
    playerMove = false;
  }

}

void mouseClicked(){
 if(mouseX > 75 && mouseX < 375){
   if(mouseY > 180 && mouseY < 280){
     clear();
     screens = 1;
   }
   if(mouseY > 300 && mouseY < 400){
     clear();
     screens = 2;
   }
   if(mouseY > 420 && mouseY < 520){
     clear();
     screens = 3;
   }
   if(mouseY > 540 && mouseY < 640){
     clear();
     screens = 7;
   }
 }
 if(mouseX > 815 && mouseX < 1115){
   if(mouseY > 180 && mouseY < 280){
     clear();
     screens = 4;
   }
   if(mouseY > 300 && mouseY < 400){
     clear();
     screens = 5;
   }
   if(mouseY > 420 && mouseY < 520){
     clear();
     screens = 6;
   }  
   if(mouseY > 540 && mouseY < 640){
     clear();
     screens = 8;
   }
 } 
}
