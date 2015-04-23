/**
* Knowledgebase.pde - stores information about the game board as 8 x 8 Tile array
*
*
**/
class Knowledgebase{
  Tile[][] KB;  
  
  Knowledgebase() {
    print("Susanna");
     KB = new Tile[8][8];
  }
  
  public void addKnowledge (Tile tile) {
    Tile tempTile = tile;
    int x =  tempTile.getXCoordinate();
    int y =  tempTile.getYCoordinate();
    KB[x][y] = tempTile; 
  }
  
  public Tile getTile (int xCoordinate, int yCoordinate) {
    return KB[xCoordinate][yCoordinate];  
  }
  
}
