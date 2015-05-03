class Arrow{
  PImage arrowImg = loadImage("doodleArrow.png");
  PVector p,v;
  //PVector pos_player;
  
  int numArrows = 3;
  
  int xCoordinate; 
  int yCoordinate;
  
  int xGUI; 
  int yGUI;
  
  public Arrow(PVector pos_player){    
    p = new PVector(pos_player.x, pos_player.y, 0);
    v = new PVector(1,0,0);
  }
  /*
  void update(){
     
  }
  */
  
  void simulate(){
    //if(numArrows >0){
      p.x+=v.x;
      p.y+=v.y;
      //numArrows--;
    //}
  }
  
  void draw(){
    image(arrowImg, p.x, p.y, 75, 25); 
  }
}
