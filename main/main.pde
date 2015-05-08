import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer SFXgold, SFXinception, SFXpit;

int x;
int y;

int numberOfRectangles = 8;

boolean goldFound = false;

Player player;
AvoidingWumpus avoidingwumpus;
RandomWumpus randomWumpus;
AStarWumpus astarwumpus;
GreedyWumpus greedywumpus;
Knowledgebase kbDemo1;
Knowledgebase kbDemo2;
Knowledgebase kbPlay;

Board board;
Knowledgebase GUIKB;

int boardSize = 600;
int rectSize = boardSize/8;

//the # of turns the player has taken before the Wumpus moves
int playerTurns;
//2 if wumpus is not in a pit, 4 if wumpus is in a pit
int playerMoves = 2;

//# of turns the wumpus has been under penalty
//int wumpusPenaltyTurns = 0;
//is Wumpus in a pit?
boolean wumpusPit = false;

int time;
int screens = 0;

boolean playerMove;

void setup(){
  board = new Board();
  size(boardSize*2+10, boardSize+100);
  //timer.start();
  //time = millis();
  playerMove = true;
  
  minim = new Minim(this);
  SFXgold = minim.loadFile("goldsfx.wav");
  //SFXgold.loop();
  SFXpit = minim.loadFile("pitsfx.wav");
  //SFXpit.loop();
  SFXinception = minim.loadFile("inception.mp3");
  //SFXinception.loop();
  
  player = new Player(0, 7);
  
  avoidingwumpus = new AvoidingWumpus();
  randomWumpus = new RandomWumpus();
  astarwumpus = new AStarWumpus();
  greedywumpus = new GreedyWumpus();
  GUIKB = new Knowledgebase();
  kbDemo1 = avoidingwumpus.getKB();
  kbDemo2 = astarwumpus.getKB();
  kbPlay = player.getKB();
  
  Tile tile = board.getTile(player.getXCoordinate(), player.getYCoordinate());
  tile.setPlayer(true);
  
  board.setPits();
  board.setGold();
  
  Tile playerTile = board.getTile(player.getXCoordinate(), player.getYCoordinate());
  playerTile.setPlayer(true);
  int x = astarwumpus.getXCoordinate();
  int y = astarwumpus.getYCoordinate();
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
 else if (screens == 9){
  goldScreen(); 
 }
 else if (screens == 10){
  deadScreen(); 
 }
  else{
    mainScreen();
  }
}

void mainScreen(){
   for (x = 0; x < numberOfRectangles; x++){
    for (y = 0; y < numberOfRectangles; y++){
      fill(153);
      stroke(0);
      rect(x*rectSize, y*rectSize, rectSize, rectSize);
       rect(x*rectSize+610, y*rectSize, rectSize, rectSize);
      
      //if(x%2 == 0 && y%2 == 0){
         Tile tile = board.getTile(x, y);
         boolean goldCheck = player.checkForGold(board);
         if(goldCheck && !goldFound){
           if(!SFXgold.isPlaying())
             SFXgold.rewind();
           SFXgold.play();
           goldFound=true;
         }
         if(screens == 1 || screens == 2 || screens == 3 || screens == 7){
         tile.display(board);
        }
        
        Tile tempTile = null;
         if(screens == 1){
           textSize(48);
           text("NO KNOWLEDGEBASE", 665, 300);
         }
         if(screens == 7){
           textSize(48);
           text("NO KNOWLEDGEBASE", 665, 300);
         }
         textSize(12);
         if(screens == 2) {
           tempTile = kbDemo1.getTile(x,y);
         }
         if(screens == 3) {
           tempTile = kbDemo2.getTile(x,y);
         }
         if(screens == 4 || screens == 5 || screens == 6){
           tempTile = kbPlay.getTile(x,y);
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
           kbTile.display(board);
         }
    }
  } 
  player.display();
   if(screens == 1){
    randomWumpus.display();
  }
  if(screens == 2){
    avoidingwumpus.display();
  }
  if (screens == 3){
    astarwumpus.display();
  }
  if (screens == 7){
    greedywumpus.display();
  }
  
  /*wumpus movement for it's turn*/
  if(playerMove == false){
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        if(screens == 3 && board.getTile(astarwumpus.getXCoordinate(), astarwumpus.getYCoordinate()).getPit()){
            wumpusPit = true;
        }
        if (screens == 2 && board.getTile(avoidingwumpus.getXCoordinate(), avoidingwumpus.getYCoordinate()).getPit()) {
            wumpusPit = true;
        }
        if (screens == 1 && board.getTile(randomWumpus.getXCoordinate(), randomWumpus.getYCoordinate()).getPit()) {
            wumpusPit = true;
        }
        if (screens == 7 && board.getTile(greedywumpus.getXCoordinate(), greedywumpus.getYCoordinate()).getPit()) {
            wumpusPit = true;
        }
      }
    }
    //print(wumpusPit);
    if(wumpusPit){
      playerMoves = 4;       
    }
    else{
      playerMoves = 2;
    }
    
    //print(wumpusPit);
    
    if(playerTurns == playerMoves){
     // avoidingwumpus.makeMove(board, SFXpit);
     // astarwumpus.makeMove(board, SFXpit);
       if (screens == 1 || screens == 4){
      randomWumpus.makeMove(SFXpit);
    }
    if(screens == 2 || screens == 5){
      avoidingwumpus.makeMove(board, SFXpit);
    }
    if (screens == 3 || screens == 6){
      astarwumpus.makeMove(board, SFXpit);
    }
    if (screens == 7 || screens == 8){
      greedywumpus.makeMove(board, SFXpit);
    }
      playerTurns = 0;
      wumpusPit = false;
      
    }
    if(player.getXCoordinate() == 0 && player.getYCoordinate() == 7 && board.getGoldPickedUp()){
      print("YOU ESCAPED THE CAVE WITH THE GOLD!!!");
      //exit();
      clear();
      screens = 9;
    }
    if(board.getTile(player.getXCoordinate(), player.getYCoordinate()).getPit()){
      print("YOU DIED!!!");
      //exit();
      clear();
      screens = 10;
    }
    playerMove = true;
  }
  /*wumpus movement for when the player takes too long to move*/
  if(millis() - time >= 6000 && playerMove == true){
    astarwumpus.makeMove(board, SFXpit);
    randomWumpus.makeMove(SFXpit);
    avoidingwumpus.makeMove(board, SFXpit);
    greedywumpus.makeMove(board, SFXpit);
    time = millis();
  }

  /*
  SFXpit.rewind();
  SFXgold.rewind();
  */
  /*
  for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        if(board.getTile(i, j).getWumpus() && board.getTile(i, j).getPlayer()){
          SFXinception.play();
        }
      }
  }
  */
  if(screens == 1 || screens == 4){
    if(randomWumpus.getXCoordinate()==player.getXCoordinate() && randomWumpus.getYCoordinate()==player.getYCoordinate()){
    clear();
      screens = 10;
  }
  }
  if(screens == 2 || screens == 5){
    if(avoidingwumpus.getXCoordinate()==player.getXCoordinate() && avoidingwumpus.getYCoordinate()==player.getYCoordinate()){
    clear();
      screens = 10;
  }
  }
  if(screens == 3 || screens == 6){
    if(astarwumpus.getXCoordinate()==player.getXCoordinate() && astarwumpus.getYCoordinate()==player.getYCoordinate()){
      clear();
      screens = 10;
  }
  }
  if(screens == 7 || screens == 8){
    if(greedywumpus.getXCoordinate()==player.getXCoordinate() && greedywumpus.getYCoordinate()==player.getYCoordinate()){
      clear();
      screens = 10;
  }
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
  text("AVOIDING WUMPUS", 76, 600);
  
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
  text("AVOIDING WUMPUS", 816, 600);
}

void deadScreen(){
  background(0);
  fill(255);
  textSize(88);
  text("YOU DIED", 390, 100);
  if(!SFXinception.isPlaying()){
      SFXinception.rewind();}
    SFXinception.play();
 
  rect(450,180,300,100);
  fill(0);
  textSize(32);
  text("PLAY AGAIN", 500, 245);
  
}

void goldScreen(){
  fill(255);
  textSize(40);
  text("YOU ESCAPED THE CAVE WITH THE GOLD!!!", 50, 100);
  
  rect(450,180,300,100);
  fill(0);
  textSize(32);
  text("PLAY AGAIN", 500, 245);
}

/*move if the player pressed a key. this is when the board updates. */
void keyPressed(){
  if(playerMove == true){
    time = millis();
    /** Unsets the player's position from the old tile */
    board.getTile(player.getXCoordinate(), player.getYCoordinate()).setPlayer(false);
    /** Player makes their new move */
    player.move();
    player.getKB().addKnowledge(board.getTile(player.getXCoordinate(), player.getYCoordinate()));
    //print(player.getKB().getTile().getYGUI());
    playerTurns++;
    
    /** Sets the tile for the player's new position */
    board.getTile(player.getXCoordinate(), player.getYCoordinate()).setPlayer(true);
    
    /** If there is a tile near a pit and the wumpus */
     if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getStench() == true && board.getTile(player.getXCoordinate(), player.getYCoordinate()).getBreeze() == true) {
        print("There is a stenchy breeze...\n\n\n");  
        fill(255);
        text("There is a stenchy breeze...\n\n\n", 100, 640); 
     }
     /** If there is a tile only near a pit */
     else if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getBreeze() == true) {
        print("There is a breeze..." + "\n\n\n");  
        fill(255);
        text("There is a breeze...", 100, 650);
     }
     /** If there is a tile only near the wumpus */
     else if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getStench() == true) {
        print("There is a stench..." + "\n\n\n");  
        fill(255);
        text("There is a stench...", 100, 630);
    }
    else if (board.getTile(player.getXCoordinate(), player.getYCoordinate()).getGlitter() == true) {
      print("There is glitter..." + "\n\n\n");  
      fill(255);
      text("There is glitter...", 100, 670);
  }
    /** Otherwise, it is a safe tile and should "clear" the console */
    else {
      print("\n\n\n\n\n");  
      fill(0);
     rect(95, 610, 200, 400);
    }
      playerMove = false;
  }

}

void mouseClicked(){
  if(screens == 0){
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
  else if(screens == 9 || screens == 10){
    if(mouseX > 450 && mouseX < 750 && mouseY > 180 && mouseY < 280){
      clear();
      screens = 0;
    }
  }
}
