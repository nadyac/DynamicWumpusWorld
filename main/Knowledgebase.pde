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
  
  /* Method used to give information to SafeTile */
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
                 //If this position already exists in our knowledge base, then we can do some inference on it (top-left diagonal)
                 if (KB[xCoordinate-1][yCoordinate-1] != null) {
                     print("I've been to: " + Integer.toString(xCoordinate-1) + " " + Integer.toString(yCoordinate-1) + "\n");
                     //If there is no breeze at the coordinate above the one we wish to go to (left and up), then we can assume there is no pit to our left - the safety level is set to 0 for "no pit"
                     if (KB[xCoordinate-1][yCoordinate-1].getBreeze() != true) {
                          this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                          this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                          KB[xCoordinate-1][yCoordinate].setSafety(0);
                          KB[xCoordinate][yCoordinate-1].setSafety(0);
                     }
                     //if there is a breeze in the top-left diagonal, check and see if we've visied the tile above or to the left of where we currently are
                     else {
                       //tile to the left?
                       if (KB[xCoordinate-1][yCoordinate] != null) {
                          print("I've been to: " + Integer.toString(xCoordinate-1) + " " + yCoordinate + "\n");
                         //we've fallen into a pit going to the left. This means we won't fall into this one again.
                         if (KB[xCoordinate-1][yCoordinate].getPit() == true) {
                            KB[xCoordinate-1][yCoordinate].setSafety(2);
                         }
                         //no pit going left! we'll remember that
                         else {
                            KB[xCoordinate-1][yCoordinate].setSafety(0); 
                         }
                       }
                       //tile above?
                       if(KB[xCoordinate][yCoordinate-1] != null){
                          print("I've been to: " + xCoordinate + " " + Integer.toString(yCoordinate-1) + "\n");
                         //we've fallen into a pit going up. This means we won't fall into this again.
                         if (KB[xCoordinate][yCoordinate-1].getPit() == true) {
                            KB[xCoordinate][yCoordinate-1].setSafety(2);
                         }
                         //no pit going up! we'll remember that
                         else {
                            KB[xCoordinate][yCoordinate-1].setSafety(0); 
                         }
                       }
                       //if both possible moves out of up and left are not in the knowledge base, but a breeze was perceived in two spaces next to them, then we set uncertainty
                       // Attempt not working yet - only does inference to see if there were no pits, not possible pits 
                       if(KB[xCoordinate][yCoordinate-1] == null && KB[xCoordinate-1][yCoordinate] == null) {
                           /* 
                           this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                           this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                           KB[xCoordinate-1][yCoordinate].setSafety(1.5);
                           KB[xCoordinate][yCoordinate-1].setSafety(1.5); 
                           */
                       }
                     }
                 }
                 else { 
                   //If the diagonal tile is not in our knowledge base, then we can only check to see if the adjacent tiles are pits or not
                   if (KB[xCoordinate-1][yCoordinate] != null) {
                      print("I've been to: " + Integer.toString(xCoordinate-1) + " " + yCoordinate + "\n");
                      // if it is a pit, then we add that to our knowledge base
                     if (KB[xCoordinate-1][yCoordinate].getPit() == true) {
                        KB[xCoordinate-1][yCoordinate].setSafety(2);
                     }
                     // if it isn't, then we can safely go in that tile
                     else {
                        KB[xCoordinate][yCoordinate].setSafety(0); 
                     }
                   }
                   // If the diagonal tile is not in our knowledge base, then we can only check to see if the adjacent tiles are pits or not 
                   if (KB[xCoordinate][yCoordinate-1] != null){
                       print("I've been to: " + xCoordinate + " " + Integer.toString(yCoordinate-1) + "\n");
                       // If it is a pit, then we add that to our knowledge base 
                       if (KB[xCoordinate][yCoordinate-1].getPit() == true) {
                          KB[xCoordinate][yCoordinate-1].setSafety(2);
                       }
                       // if it isn't, then we can safely go in that tile 
                       else {
                          KB[xCoordinate][yCoordinate-1].setSafety(0); 
                       }
                   }
                   
                   if (KB[xCoordinate][yCoordinate-1] == null && KB[xCoordinate-1][yCoordinate] == null) {
                     print("shosh2"); 
                   }
                   
                 } 
             }
             // Everything here is pretty much the same as above, just different locations (will comment later when less lazy)
            if (xCoordinate != 7) {
                if (KB[xCoordinate+1][yCoordinate-1] != null) {
                   print("I've been to: " + Integer.toString(xCoordinate+1) + " " + Integer.toString(yCoordinate-1) + "\n");
                     if (KB[xCoordinate+1][yCoordinate-1].getBreeze() != true) {
                       this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                       this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                        KB[xCoordinate+1][yCoordinate].setSafety(0);
                        KB[xCoordinate][yCoordinate-1].setSafety(0);
                     }
                     else {
                         if (KB[xCoordinate+1][yCoordinate] != null) {
                             print("I've been to: " + Integer.toString(xCoordinate+1) + " " + yCoordinate + "\n");
                             print("shouldn't know this either");
                             if (KB[xCoordinate+1][yCoordinate].getPit() == true) {
                                KB[xCoordinate+1][yCoordinate].setSafety(2);
                             }
                             else {
                                KB[xCoordinate+1][yCoordinate].setSafety(0); 
                             }
                         }
                         if(KB[xCoordinate][yCoordinate-1] != null){
                            print("I've been to: " + xCoordinate + " " + Integer.toString(yCoordinate-1) + "\n");
                             if (KB[xCoordinate][yCoordinate-1].getPit() == true) {
                                KB[xCoordinate][yCoordinate-1].setSafety(2);
                             }
                             else {
                                KB[xCoordinate][yCoordinate-1].setSafety(0); 
                             }
                         }
                         if(KB[xCoordinate][yCoordinate-1] == null && KB[xCoordinate+1][yCoordinate] == null) {
                             /*
                             this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                             this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                             KB[xCoordinate-1][yCoordinate].setSafety(1.5);
                             KB[xCoordinate][yCoordinate-1].setSafety(1.5); 
                             */
                         }
                     }
                 }
                 
                 else { 
                      if (KB[xCoordinate+1][yCoordinate] != null) {
                           print("I've been to: " + xCoordinate+1 + " " + yCoordinate + "\n");
                             if (KB[xCoordinate+1][yCoordinate].getPit() == true) {
                                KB[xCoordinate+1][yCoordinate].setSafety(2);
                             }
                             else {
                                KB[xCoordinate+1][yCoordinate].setSafety(0); 
                             }
                      }
                     if(KB[xCoordinate][yCoordinate-1] != null){
                        print("I've been to: " + xCoordinate + " " + Integer.toString(yCoordinate-1) + "\n");
                         if (KB[xCoordinate][yCoordinate-1].getPit() == true) {
                            KB[xCoordinate][yCoordinate-1].setSafety(2);
                         }
                         else {
                            KB[xCoordinate][yCoordinate-1].setSafety(0); 
                         }
                     }
                     if(KB[xCoordinate][yCoordinate-1] == null && KB[xCoordinate+1][yCoordinate] == null) {
                         /*
                         this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                         this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                         KB[xCoordinate+1][yCoordinate].setSafety(1.5);
                         KB[xCoordinate][yCoordinate-1].setSafety(1.5); 
                         */
                     }
              }
            }  
          }
          if (yCoordinate != 7) {
             if (xCoordinate > 0) {
                 if (KB[xCoordinate-1][yCoordinate+1] != null) {
                      print("I've been to: " + Integer.toString(xCoordinate-1) + " " + Integer.toString(yCoordinate+1) + "\n");
                     if (KB[xCoordinate-1][yCoordinate+1].getBreeze() != true) {
                       this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                       this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                        KB[xCoordinate-1][yCoordinate].setSafety(0);
                        KB[xCoordinate][yCoordinate+1].setSafety(0);
                     }
                     else {
                         if (KB[xCoordinate-1][yCoordinate] != null) {
                            print("I've been to: " + Integer.toString(xCoordinate-1) + " " + yCoordinate + "\n");
                             if (KB[xCoordinate-1][yCoordinate].getPit() == true) {
                                KB[xCoordinate-1][yCoordinate].setSafety(2);
                             }
                             else {
                                KB[xCoordinate-1][yCoordinate].setSafety(0); 
                             }
                         }
                         if(KB[xCoordinate][yCoordinate+1] != null){
                              print("I've been to: " + xCoordinate + " " + Integer.toString(yCoordinate+1) + "\n");
                             if (KB[xCoordinate][yCoordinate+1].getPit() == true) {
                                KB[xCoordinate][yCoordinate+1].setSafety(2);
                             }
                             else {
                                KB[xCoordinate][yCoordinate+1].setSafety(0); 
                             }
                         }
                         if(KB[xCoordinate-1][yCoordinate] == null && KB[xCoordinate][yCoordinate+1] == null) {
                             /*
                             this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                             this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                             KB[xCoordinate-1][yCoordinate].setSafety(1.5);
                             KB[xCoordinate][yCoordinate-1].setSafety(1.5); 
                             */
                         }
                     }
                 }
                 else { 
                     if (KB[xCoordinate-1][yCoordinate] != null) {
                          print("I've been to: " + Integer.toString(xCoordinate-1) + " " + yCoordinate + "\n");
                         if (KB[xCoordinate-1][yCoordinate].getPit() == true) {
                            KB[xCoordinate-1][yCoordinate].setSafety(2);
                         }
                         else {
                            KB[xCoordinate-1][yCoordinate].setSafety(0); 
                         }
                     }
                     if (KB[xCoordinate][yCoordinate+1] != null){
                          print("I've been to: " + xCoordinate + " " + Integer.toString(yCoordinate+1) + "\n");
                         if (KB[xCoordinate][yCoordinate+1].getPit() == true) {
                            KB[xCoordinate][yCoordinate+1].setSafety(2);
                         }
                         else {
                            KB[xCoordinate][yCoordinate+1].setSafety(0); 
                         }
                     }
                     if(KB[xCoordinate-1][yCoordinate] == null && KB[xCoordinate][yCoordinate+1] == null) {
                     }
                 } 
             }
            if (xCoordinate != 7) {
                if (KB[xCoordinate+1][yCoordinate+1] != null) {
                   print("I've been to: " + Integer.toString(xCoordinate+1) + " " + Integer.toString(yCoordinate+1) + "\n");
                     if (KB[xCoordinate+1][yCoordinate+1].getBreeze() != true) {
                         this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                         this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                        KB[xCoordinate+1][yCoordinate].setSafety(0);
                        KB[xCoordinate][yCoordinate+1].setSafety(0);
                     }
                     else {
                       if (KB[xCoordinate+1][yCoordinate] != null) {
                            print("I've been to: " + Integer.toString(xCoordinate+1) + " " + yCoordinate + "\n");
                           if (KB[xCoordinate+1][yCoordinate].getPit() == true) {
                              KB[xCoordinate+1][yCoordinate].setSafety(2);
                           }
                           else {
                              KB[xCoordinate+1][yCoordinate].setSafety(0); 
                           }
                       }
                       if (KB[xCoordinate][yCoordinate+1] != null){
                            print("I've been to: " + xCoordinate + " " + Integer.toString(yCoordinate+1) + "\n");
                           if (KB[xCoordinate][yCoordinate+1].getPit() == true) {
                              KB[xCoordinate][yCoordinate+1].setSafety(2);
                           }
                           else {
                              KB[xCoordinate][yCoordinate+1].setSafety(0); 
                           }
                       }
                       if(KB[xCoordinate+1][yCoordinate] == null && KB[xCoordinate][yCoordinate+1] == null) {
                           /*
                           this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                           this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                           KB[xCoordinate+1][yCoordinate].setSafety(1.5);
                           KB[xCoordinate][yCoordinate+1].setSafety(1.5);
                          */ 
                       }
                   }
               }
                 else { 
                   //If the tile does not exist in our knowledge base, then we will assume it could potentially have a pit - the safety level is set to one for "possible pit"
                  if (KB[xCoordinate+1][yCoordinate] != null) {
                       print("I've been to: " + Integer.toString(xCoordinate+1) + " " + yCoordinate + "\n");
                           if (KB[xCoordinate+1][yCoordinate].getPit() == true) {
                              KB[xCoordinate+1][yCoordinate].setSafety(2);
                           }
                           else {
                              KB[xCoordinate+1][yCoordinate].setSafety(0); 
                           }
                       }
                       if (KB[xCoordinate][yCoordinate+1] != null){
                            print("I've been to: " + xCoordinate + " " + Integer.toString(yCoordinate+1) + "\n");
                           if (KB[xCoordinate][yCoordinate+1].getPit() == true) {
                              KB[xCoordinate][yCoordinate+1].setSafety(2);
                           }
                           else {
                              KB[xCoordinate][yCoordinate+1].setSafety(0); 
                           }
                       }
                           //if both possible moves out of up and left are not in the knowledge base, but a breeze was perceived in two spaces next to them, then we set uncertainty
                       if(KB[xCoordinate+1][yCoordinate] == null && KB[xCoordinate][yCoordinate+1] == null) {
                       }
                 } 
            } 
          }
    }
    
    /** If there was no breeze, then we see if there was a pit */
    if (KB[xCoordinate][yCoordinate].getPit() == true) {
      KB[xCoordinate][yCoordinate].setSafety(2);  
    }
    /** Otherwise, we say that the safety is uncertain */
    else {
      KB[xCoordinate][yCoordinate].setSafety(1);  
    }
  }
  
  public Tile[][] returnKB() {
     return KB; 
  }
  
}
