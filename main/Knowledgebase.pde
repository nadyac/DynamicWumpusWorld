/**
* Knowledgebase.pde - stores information about the game board as 8 x 8 Tile array
*
*
**/
class Knowledgebase{
  Tile[][] KB; 
  Board board;
  int safeTiles; 
  
  Knowledgebase() {
     KB = new Tile[8][8];
  }
  
  public void addKnowledge (Tile tile) {
    Tile tempTile = tile;
   int x =  tempTile.getXGUI();
   int y =  tempTile.getYGUI();
      print("x2: " + x + " y2: " + y);
    KB[x][y] = tempTile; 
  }
  
  public void updateInference(Board b) {
      board = b;
  }
  
  public Tile getTile (int xCoordinate, int yCoordinate) {
    return KB[xCoordinate][yCoordinate];  
  }
  
  public void SafeTile (int xCoordinate, int yCoordinate) {
    if (KB[xCoordinate][yCoordinate].getBreeze() == true) {
         if (yCoordinate != 0) {
             if (xCoordinate != 0) {
                 //If this position already exists in our knowledge base, then we can do some inference on it
                 if (KB[xCoordinate-1][yCoordinate-1] != null) {
                     //If there is no breeze at the coordinate above the one we wish to go to, then we can assume there is no pit at our left move - the safety level is set to 0 for "no pit"
                     if (KB[xCoordinate-1][yCoordinate-1].getBreeze() != true) {
                          this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                          this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                          KB[xCoordinate-1][yCoordinate].setSafety(0);
                          KB[xCoordinate][yCoordinate-1].setSafety(0);
                     }
                     //If there is a breeze at the coordinate above the one we wish to go to, then there might be a pit - the safety level is set to one for "possible pit"
                     else {
                       if (KB[xCoordinate-1][yCoordinate] != null) {
                         if (KB[xCoordinate-1][yCoordinate].getPit() == true) {
                            KB[xCoordinate-1][yCoordinate].setSafety(2);
                         }
                         else {
                            KB[xCoordinate][yCoordinate].setSafety(0); 
                         }
                       }
                       else {
                         this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                         this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                         KB[xCoordinate-1][yCoordinate].setSafety(1);
                         KB[xCoordinate][yCoordinate-1].setSafety(1); 
                       }
                     }
                 }
                 else { 
                   //If the tile does not exist in our knowledge base, then we will assume it could potentially have a pit - the safety level is set to one for "possible pit"
                   this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                   this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                   KB[xCoordinate-1][yCoordinate].setSafety(1);
                   KB[xCoordinate][yCoordinate-1].setSafety(1);
                 } 
             }
            if (xCoordinate != 7) {
                if (KB[xCoordinate+1][yCoordinate-1] != null) {
                     //If there is no breeze at the coordinate above the one we wish to go to, then we can assume there is no pit at our right move - the safety level is set to 0 for "no pit"
                     if (KB[xCoordinate+1][yCoordinate-1].getBreeze() != true) {
                       this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                       this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                        KB[xCoordinate+1][yCoordinate].setSafety(0);
                        KB[xCoordinate][yCoordinate-1].setSafety(0);
                     }
                     //If there is a breeze at the coordinate above the one we wish to go to, then there might be a pit - the safety level is set to one for "possible pit"
                     else {
                        this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                        this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                        KB[xCoordinate+1][yCoordinate].setSafety(1.5);
                        KB[xCoordinate][yCoordinate-1].setSafety(1.5);
                     }
                 }
                 else { 
                   //If the tile does not exist in our knowledge base, then we will assume it could potentially have a pit - the safety level is set to one for "possible pit"
                   this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                   this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                   KB[xCoordinate+1][yCoordinate].setSafety(1);
                   KB[xCoordinate][yCoordinate-1].setSafety(1);
                 } 
            }  
          }
          if (yCoordinate != 7) {
             if (xCoordinate > 0) {
                 //If this position already exists in our knowledge base, then we can do some inference on it
                 if (KB[xCoordinate-1][yCoordinate+1] != null) {
                     //If there is no breeze at the coordinate above the one we wish to go to, then we can assume there is no pit at our left move - the safety level is set to 0 for "no pit"
                     if (KB[xCoordinate-1][yCoordinate+1].getBreeze() != true) {
                       this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                       this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                        KB[xCoordinate-1][yCoordinate].setSafety(0);
                        KB[xCoordinate][yCoordinate+1].setSafety(0);
                     }
                     //If there is a breeze at the coordinate above the one we wish to go to, then there might be a pit - the safety level is set to one for "possible pit"
                     else {
                        this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                         this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                        KB[xCoordinate-1][yCoordinate].setSafety(1.5);
                        KB[xCoordinate][yCoordinate+1].setSafety(1.5);
                     }
                 }
                 else { 
                   //If the tile does not exist in our knowledge base, then we will assume it could potentially have a pit - the safety level is set to one for "possible pit"
                   this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                   this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                   KB[xCoordinate-1][yCoordinate].setSafety(1);
                   KB[xCoordinate][yCoordinate+1].setSafety(1);
                 } 
             }
            if (xCoordinate != 7) {
                if (KB[xCoordinate+1][yCoordinate+1] != null) {
                     //If there is no breeze at the coordinate above the one we wish to go to, then we can assume there is no pit at our right move - the safety level is set to 0 for "no pit"
                     if (KB[xCoordinate+1][yCoordinate+1].getBreeze() != true) {
                         this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                         this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                        KB[xCoordinate+1][yCoordinate].setSafety(0);
                        KB[xCoordinate][yCoordinate+1].setSafety(0);
                     }
                     //If there is a breeze at the coordinate above the one we wish to go to, then there might be a pit - the safety level is set to one for "possible pit"
                     else {
                        this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                        this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                        KB[xCoordinate+1][yCoordinate].setSafety(1.5);
                        KB[xCoordinate][yCoordinate+1].setSafety(1.5);
                     }
                 }
                 else { 
                   //If the tile does not exist in our knowledge base, then we will assume it could potentially have a pit - the safety level is set to one for "possible pit"
                   this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                   this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                   KB[xCoordinate+1][yCoordinate].setSafety(1);
                   KB[xCoordinate][yCoordinate+1].setSafety(1);
                 } 
            } 
          }
    }
    if (KB[xCoordinate][yCoordinate].getPit() == true) {
      KB[xCoordinate][yCoordinate].setSafety(2);  
    }
    else {
      KB[xCoordinate][yCoordinate].setSafety(0);  
    }
  }
  
  public Tile[][] returnKB() {
     return KB; 
  }
  
}
