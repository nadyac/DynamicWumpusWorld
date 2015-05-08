/**
 * main.pde - runs the game
 *
 * Authors:         Kyle Davis, Kate Evans, Nadya Pena, Leanna Stecker
 * Last Modified:   5/7/2015
 * Arificial Intelligence
 * Dr. Salgian
 */

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
/** Knowledge base for AvoidingWumpus*/
Knowledgebase kbDemo1;
/** Knowledge base for AStarWumpus*/
Knowledgebase kbDemo2;
/** Knowledge base for the player - adds tiles the player has been to */
Knowledgebase kbPlay;

Board board;
/** Knowledge base GUIKB - acts as a copy for the knowledge base */
Knowledgebase GUIKB;

int boardSize = 600;
int rectSize = boardSize/8;

/** the # of turns the player has taken before the Wumpus moves */
int playerTurns;
/** 2 if wumpus is not in a pit, 4 if wumpus is in a pit */
int playerMoves = 2;
/**is Wumpus in a pit? */
boolean wumpusPit = false;

int time;
int screens = 0;
String deathOutput = "";

boolean playerMove;

void setup(){
  board = new Board();
  size(boardSize*2+10, boardSize+100);
  playerMove = true;
  /** minim - object needed to load and play audio files*/
  minim = new Minim(this);
  /** sound effect files */
  SFXgold = minim.loadFile("goldsfx.wav");
  SFXpit = minim.loadFile("pitsfx.wav");
  SFXinception = minim.loadFile("inception.mp3");
  /** Player spawns at (0,7) */
  player = new Player(0, 7);
  /** Declaration of the wumpuses */
  avoidingwumpus = new AvoidingWumpus();
  randomWumpus = new RandomWumpus();
  astarwumpus = new AStarWumpus();
  greedywumpus = new GreedyWumpus();
  GUIKB = new Knowledgebase();
  /** Declaration of knowledge bases */
  kbDemo1 = avoidingwumpus.getKB();
  kbDemo2 = astarwumpus.getKB();
  kbPlay = player.getKB();
  /** Sets the Tile that contains the player (now that Tile knows it contains the player) */
  Tile tile = board.getTile(player.getXCoordinate(), player.getYCoordinate());
  tile.setPlayer(true);
  /** Sets all the pits on the board (10 random pits) */
  board.setPits();
  /** Sets the gold on the board (one random tile) */
  board.setGold();
  smooth();
}

/**
* draw - main function that runs the program. Processing continuously calls this function to refresh the canvas
* calls the various game
*/
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

/**
* mainScreen - function that runs the game. Is called continuously by draw when in demo or play mode.
*/
void mainScreen(){
  /**Drawing the playing board */ 
   for (x = 0; x < numberOfRectangles; x++){
    for (y = 0; y < numberOfRectangles; y++){
      fill(153);
      stroke(0);
      rect(x*rectSize, y*rectSize, rectSize, rectSize);
      rect(x*rectSize+610, y*rectSize, rectSize, rectSize);
      
      /** Displaying the tiles on the board */ 
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
        
        /**Displaying the wumpuses' or players knowledge base depending on when mode the player selects. */
        Tile tempTile = null;
         if(screens == 1){
           fill(0);
           textSize(48);
           text("NO KNOWLEDGEBASE", 665, 300);
         }
         if(screens == 7){
           textSize(48);
           text("NO KNOWLEDGEBASE", 665, 300);
         }
         textSize(12);
         /** Gets the appropriate knoweledge base to display */
         if(screens == 2) {
           tempTile = kbDemo1.getTile(x,y);
         }
         if(screens == 3) {
           tempTile = kbDemo2.getTile(x,y);
         }
         if(screens == 4 || screens == 5 || screens == 6){
           tempTile = kbPlay.getTile(x,y);
         }
         /**Copies the knoweledge base in order to be correctly displayed. */
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
  
  /**Displaying the player */ 
  player.display();
  
  /**Displaying the different wumpuses based on the users selection */ 
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
    /**Penalty for the wumpus falling into puts. */
    if(wumpusPit){
      playerMoves = 4;       
    }
    else{
      playerMoves = 2;
    }
    
    /**Turn based movement for when the player does move */
    if(playerTurns == playerMoves){
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
    /**Check if the player has the gold and has returned to the start position to win the game */
    if(player.getXCoordinate() == 0 && player.getYCoordinate() == 7 && board.getGoldPickedUp()){
      print("YOU ESCAPED THE CAVE WITH THE GOLD!!!");
      //exit();
      clear();
      screens = 9;
    }
    /**Checks if the player has fallen in a pit */
    if(board.getTile(player.getXCoordinate(), player.getYCoordinate()).getPit()){
      deathOutput = "You fell in a pit";
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

  /** The following if statements check to see if the player and the wumpus are on the same tile. If they are it ends the game and brings up the death screen*/
  if(screens == 1 || screens == 4){
    if(randomWumpus.getXCoordinate()==player.getXCoordinate() && randomWumpus.getYCoordinate()==player.getYCoordinate()){
      deathOutput = "The wumpus found you";
      clear();
      screens = 10;
    }
  }
  if(screens == 2 || screens == 5){
    if(avoidingwumpus.getXCoordinate()==player.getXCoordinate() && avoidingwumpus.getYCoordinate()==player.getYCoordinate()){
       deathOutput = "The wumpus found you";
      clear();
      screens = 10;
    }
  }
  if(screens == 3 || screens == 6){
    if(astarwumpus.getXCoordinate()==player.getXCoordinate() && astarwumpus.getYCoordinate()==player.getYCoordinate()){
      deathOutput = "The wumpus found you";
      clear();
      screens = 10;
    }
  }
  if(screens == 7 || screens == 8){
    if(greedywumpus.getXCoordinate()==player.getXCoordinate() && greedywumpus.getYCoordinate()==player.getYCoordinate()){
       deathOutput = "The wumpus found you";
      clear();
      screens = 10;
    }
  }
  
}

/**
* openScreen - function that runs the opening screen of the game. Displays the buttons for choosing what type of wumpus to use.
*/
void openScreen(){
  fill(255);
  textSize(88);
  text("WUMPUS WORLD", 250, 100);
 
  textSize(50);
  text("DEMO", 150, 160);
  
  /** Sets up the graphics that represent a button on the screen */
  rect(75,180,310,100);
  fill(0);
  textSize(32);
  text("RANDOM WUMPUS", 83, 245);
  
   /** Sets up the graphics that represent a button on the screen */
  fill(255);
  rect(75,300,310,100);
  fill(0);
  textSize(32);
  text("GREEDY WUMPUS", 94, 360);
  
   /** Sets up the graphics that represent a button on the screen */
  fill(255);
  rect(75,420,310,100);
  fill(0);
  textSize(32);
  text("A* WUMPUS", 130, 480);
  
   /** Sets up the graphics that represent a button on the screen */
  fill(255);
  rect(75,540,310,100);
  fill(0);
  textSize(32);
  text("INFERENCE WUMPUS", 75, 600);
  
  textSize(50);
  fill(255);
  text("PLAY", 900, 160);
  
   /** Sets up the graphics that represent a button on the screen */
  rect(815,180,310,100);
  fill(0);
  textSize(32);
  text("RANDOM WUMPUS", 822, 245);
  
   /** Sets up the graphics that represent a button on the screen */
  fill(255);
  rect(815,300,310,100);
  fill(0);
  textSize(32);
  text("GREEDY WUMPUS", 833, 360);
  
   /** Sets up the graphics that represent a button on the screen */
  fill(255);
  rect(815,420,310,100);
  fill(0);
  textSize(32);
  text("A* WUMPUS", 878, 480);
  
   /** Sets up the graphics that represent a button on the screen */
  fill(255);
  rect(815,540,310,100);
  fill(0);
  textSize(32);
  text("INFERENCE WUMPUS", 815, 600);
}

/**
* mainScreen - function that runs the screen the player sees when they lose the game
*/
void deadScreen(){
  background(0);
  fill(255);
  textSize(88);
  text("YOU DIED", 390, 100);
  text(deathOutput, 100, 200);
  if(!SFXinception.isPlaying()){
      SFXinception.rewind();}
    SFXinception.play();
  
}

/**
* goldScreen - function that runs the screen the player sees when they win the game
*/
void goldScreen(){
  fill(255);
  textSize(40);
  text("YOU ESCAPED THE CAVE WITH THE GOLD!!!", 50, 100);
}

/**
* keyPressed - function that controls the players movements. When the arrow keys are pressed the player moves.
*/
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

/**
* mouseClicked - function that allows the player to click on the screen to select what wumpus to use.
*/
void mouseClicked(){
  if(screens == 0){
    /** mouseX and mouseY represent the coordinates of the mouse on the canvas.
    * The if statements below show which areas of the canvas are "clickable".
    */
    if(mouseX > 75 && mouseX < 375){
      if(mouseY > 180 && mouseY < 280){
        clear();
        screens = 1;
      }
    if(mouseY > 300 && mouseY < 400){
       clear();
       screens = 7;
    }
    if(mouseY > 420 && mouseY < 520){
     clear();
     screens = 3;
    }
    if(mouseY > 540 && mouseY < 640){
     clear();
     screens = 2;
   }
 }
 if(mouseX > 815 && mouseX < 1115){
   if(mouseY > 180 && mouseY < 280){
     clear();
     screens = 4;
   }
   if(mouseY > 300 && mouseY < 400){
     clear();
     screens = 8;
   }
   if(mouseY > 420 && mouseY < 520){
     clear();
     screens = 6;
   }  
   if(mouseY > 540 && mouseY < 640){
     clear();
     screens = 5;
   }
 } 
  }

}
