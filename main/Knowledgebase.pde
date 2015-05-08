/**
 * Knowledgebase.pde - stores information about the game board as 8 x 8 Tile array
 *
 * Authors:         Kyle Davis, Kate Evans, Nadya Pena, Leanna Stecker
 * Last Modified:   5/7/2015
 * Arificial Intelligence
 * Dr. Salgian
 */
class Knowledgebase{
  Tile[][] KB; 
  Board board;
  
  Knowledgebase() {
     KB = new Tile[8][8];
  }
  
  /** Add knowledge function - given a Tile in its parameters, it adds it to the knowledge base */
  public void addKnowledge (Tile tile) {
    Tile tempTile = tile;
   int x =  tempTile.getXGUI();
   int y =  tempTile.getYGUI();
   KB[x][y] = tempTile; 
  }
  
  /* Method used to give information to the function SafeTile */
  public void updateInference(Board b) {
      board = b;
  }
  
  /** Given an x and y coordinate, it returns the Tile at that location in the knowledge base */
  public Tile getTile (int xCoordinate, int yCoordinate) {
    return KB[xCoordinate][yCoordinate];  
  }
  
  /** Determines the safety of a particular Tile at an x and y coordinate 
    * If the Tile is in the knowledge base, then it is able to do some inference 
    * If it is not yet in our knowledge base, then we say it is uncertain 
    */
  public void SafeTile (int xCoordinate, int yCoordinate) {
    /** If the tile in our KB has a breeze, then we must do inference to find if it's safe */
    if (KB[xCoordinate][yCoordinate].getBreeze() == true) {
        /** Checks for yCoordinates greater than 0 */
         if (yCoordinate != 0) {
           /** Checks for xCoordinates greater than 0 */
             if (xCoordinate != 0) {
                 //If this position already exists in our knowledge base, then we can do some inference on it (top-left diagonal)
                 if (KB[xCoordinate-1][yCoordinate-1] != null) {
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
                         //we've fallen into a pit going to the left. This means we won't fall into this one again.
                         if (KB[xCoordinate-1][yCoordinate].getPit() == true) {
                            KB[xCoordinate-1][yCoordinate].setSafety(1.4);
                         }
                         //no pit going left! we'll remember that
                         else {
                            KB[xCoordinate-1][yCoordinate].setSafety(0); 
                         }
                       }
                       //tile above?
                       if(KB[xCoordinate][yCoordinate-1] != null){
                         //we've fallen into a pit going up. This means we won't fall into this again.
                         if (KB[xCoordinate][yCoordinate-1].getPit() == true) {
                            KB[xCoordinate][yCoordinate-1].setSafety(1.4);
                         }
                         //no pit going up! we'll remember that
                         else {
                            KB[xCoordinate][yCoordinate-1].setSafety(0); 
                         }
                       }
                       //if both possible moves out of up and left are not in the knowledge base, but a breeze was perceived in two spaces next to them, then we do nothing (no inference can be made) 
                       if(KB[xCoordinate][yCoordinate-1] == null && KB[xCoordinate-1][yCoordinate] == null) {
                       }
                     }
                 }
                 else { 
                   //If the diagonal tile is not in our knowledge base, then we can only check to see if the adjacent tiles are pits or not
                   if (KB[xCoordinate-1][yCoordinate] != null) {
                      // if it is a pit, then we add that to our knowledge base
                     if (KB[xCoordinate-1][yCoordinate].getPit() == true) {
                        KB[xCoordinate-1][yCoordinate].setSafety(1.4);
                     }
                     // if it isn't, then we can safely go in that tile
                     else {
                        KB[xCoordinate][yCoordinate].setSafety(0); 
                     }
                   }
                   // If the diagonal tile is not in our knowledge base, then we can only check to see if the adjacent tiles are pits or not 
                   if (KB[xCoordinate][yCoordinate-1] != null){
                       // If it is a pit, then we add that to our knowledge base 
                       if (KB[xCoordinate][yCoordinate-1].getPit() == true) {
                          KB[xCoordinate][yCoordinate-1].setSafety(1.4);
                       }
                       // if it isn't, then we can safely go in that tile 
                       else {
                          KB[xCoordinate][yCoordinate-1].setSafety(0); 
                       }
                   }
                 } 
             }
            /** Checks for xCoordinates less than 7 */
            if (xCoordinate != 7) {
                /** If the tile below the one we wish to go to is in our knowledge base, then we can do some inference */
                if (KB[xCoordinate+1][yCoordinate-1] != null) {
                    /** If the tile does not have a breeze in the tile below it, then it is safe (safety set to 0)*/
                     if (KB[xCoordinate+1][yCoordinate-1].getBreeze() != true) {
                       this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                       this.addKnowledge(board.getTile(xCoordinate, yCoordinate-1));
                        KB[xCoordinate+1][yCoordinate].setSafety(0);
                        KB[xCoordinate][yCoordinate-1].setSafety(0);
                     }
                     else {
                         /** If the tile we wish to go to is in our KB, then we can check it directly */
                         if (KB[xCoordinate+1][yCoordinate] != null) {
                             /** If it contains a pit, then we set the safety level of that tile to 1.4, for pit */
                             if (KB[xCoordinate+1][yCoordinate].getPit() == true) {
                                KB[xCoordinate+1][yCoordinate].setSafety(1.4);
                             }
                             /** If there is no pit in the tile that we want to go to, then we set the safety to 0 */
                             else {
                                KB[xCoordinate+1][yCoordinate].setSafety(0); 
                             }
                         }
                         /** If the tile we wish to go to is already in our knowledge base, then we check to see if it already contains a pit */
                         if(KB[xCoordinate][yCoordinate-1] != null){
                             /** If it does, safety is 1.4 for pit */
                             if (KB[xCoordinate][yCoordinate-1].getPit() == true) {
                                KB[xCoordinate][yCoordinate-1].setSafety(1.4);
                             }
                             else {
                               /** If it does not, safety is 0 for no pit */
                                KB[xCoordinate][yCoordinate-1].setSafety(0); 
                             }
                         }
                         /** If neither tiles adjacent to the one we wish to go to are in the knowledge base, then we cannot do any inference */
                         if(KB[xCoordinate][yCoordinate-1] == null && KB[xCoordinate+1][yCoordinate] == null) {

                         }
                     }
                 }
                 /** If the tile that we wish to go to is null, then we check to see if the tiles surrounding it are in our KB */
                 else { 
                     /** If it is, we check to see if there is a pit */
                      if (KB[xCoordinate+1][yCoordinate] != null) {
                            /** If there is a pit, then it is 1.4, for pit */
                             if (KB[xCoordinate+1][yCoordinate].getPit() == true) {
                                KB[xCoordinate+1][yCoordinate].setSafety(1.4);
                             }
                             /** If there is not a pit, then it is set to 0*/
                             else {
                                KB[xCoordinate+1][yCoordinate].setSafety(0); 
                             }
                      }
                     if(KB[xCoordinate][yCoordinate-1] != null){
                         /** If there is a pit, then it is 1.4, for pit */
                         if (KB[xCoordinate][yCoordinate-1].getPit() == true) {
                            KB[xCoordinate][yCoordinate-1].setSafety(1.4);
                         }
                         /** If there is not a pit, then it is set to 0*/
                         else {
                            KB[xCoordinate][yCoordinate-1].setSafety(0); 
                         }
                     }
                      /** If neither tiles adjacent to the one we wish to go to are in the knowledge base, then we cannot do any inference */
                     if(KB[xCoordinate][yCoordinate-1] == null && KB[xCoordinate+1][yCoordinate] == null) {
                       
                     }
              }
            }  
          }
          /** Does the same thing for yCoordinate greater than 7 that it did for yCoordinate != 0*/
          if (yCoordinate != 7) {
             if (xCoordinate > 0) {
                 if (KB[xCoordinate-1][yCoordinate+1] != null) {
                     if (KB[xCoordinate-1][yCoordinate+1].getBreeze() != true) {
                       this.addKnowledge(board.getTile(xCoordinate-1, yCoordinate));
                       this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                        KB[xCoordinate-1][yCoordinate].setSafety(0);
                        KB[xCoordinate][yCoordinate+1].setSafety(0);
                     }
                     else {
                         if (KB[xCoordinate-1][yCoordinate] != null) {
                             if (KB[xCoordinate-1][yCoordinate].getPit() == true) {
                                KB[xCoordinate-1][yCoordinate].setSafety(1.4);
                             }
                             else {
                                KB[xCoordinate-1][yCoordinate].setSafety(0); 
                             }
                         }
                         if(KB[xCoordinate][yCoordinate+1] != null){
                             if (KB[xCoordinate][yCoordinate+1].getPit() == true) {
                                KB[xCoordinate][yCoordinate+1].setSafety(1.4);
                             }
                             else {
                                KB[xCoordinate][yCoordinate+1].setSafety(0); 
                             }
                         }
                         if(KB[xCoordinate-1][yCoordinate] == null && KB[xCoordinate][yCoordinate+1] == null) {
                           
                         }
                     }
                 }
                 else { 
                     if (KB[xCoordinate-1][yCoordinate] != null) {
                         if (KB[xCoordinate-1][yCoordinate].getPit() == true) {
                            KB[xCoordinate-1][yCoordinate].setSafety(1.4);
                         }
                         else {
                            KB[xCoordinate-1][yCoordinate].setSafety(0); 
                         }
                     }
                     if (KB[xCoordinate][yCoordinate+1] != null){
                         if (KB[xCoordinate][yCoordinate+1].getPit() == true) {
                            KB[xCoordinate][yCoordinate+1].setSafety(1.4);
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
                     if (KB[xCoordinate+1][yCoordinate+1].getBreeze() != true) {
                         this.addKnowledge(board.getTile(xCoordinate+1, yCoordinate));
                         this.addKnowledge(board.getTile(xCoordinate, yCoordinate+1));
                        KB[xCoordinate+1][yCoordinate].setSafety(0);
                        KB[xCoordinate][yCoordinate+1].setSafety(0);
                     }
                     else {
                       if (KB[xCoordinate+1][yCoordinate] != null) {
                           if (KB[xCoordinate+1][yCoordinate].getPit() == true) {
                              KB[xCoordinate+1][yCoordinate].setSafety(1.4);
                           }
                           else {
                              KB[xCoordinate+1][yCoordinate].setSafety(0); 
                           }
                       }
                       if (KB[xCoordinate][yCoordinate+1] != null){
                           if (KB[xCoordinate][yCoordinate+1].getPit() == true) {
                              KB[xCoordinate][yCoordinate+1].setSafety(1.4);
                           }
                           else {
                              KB[xCoordinate][yCoordinate+1].setSafety(0); 
                           }
                       }
                       if(KB[xCoordinate+1][yCoordinate] == null && KB[xCoordinate][yCoordinate+1] == null) {
                         
                       }
                   }
               }
                 else { 
                   //If the tile does not exist in our knowledge base, then we will assume it could potentially have a pit - the safety level is set to one for "possible pit"
                  if (KB[xCoordinate+1][yCoordinate] != null) {
                           if (KB[xCoordinate+1][yCoordinate].getPit() == true) {
                              KB[xCoordinate+1][yCoordinate].setSafety(1.4);
                           }
                           else {
                              KB[xCoordinate+1][yCoordinate].setSafety(0); 
                           }
                       }
                       if (KB[xCoordinate][yCoordinate+1] != null){
                           if (KB[xCoordinate][yCoordinate+1].getPit() == true) {
                              KB[xCoordinate][yCoordinate+1].setSafety(1.4);
                           }
                           else {
                              KB[xCoordinate][yCoordinate+1].setSafety(0); 
                           }
                       }
                       if(KB[xCoordinate+1][yCoordinate] == null && KB[xCoordinate][yCoordinate+1] == null) {
                       }
                 } 
            } 
          }
    }
    
    /** If there was no breeze, then we see if there was a pit */
    if (KB[xCoordinate][yCoordinate].getPit() == true) {
      KB[xCoordinate][yCoordinate].setSafety(1.4);  
    }
    /** Otherwise, we say that the safety is uncertain */
    else {
      KB[xCoordinate][yCoordinate].setSafety(1.4);  
    }
  }
  
  
  /** Returns the 2D array KB */
  public Tile[][] returnKB() {
     return KB; 
  }
  
}
