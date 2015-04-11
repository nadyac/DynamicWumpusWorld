int x;
int y;

int numberOfRectangles = 8;

int boardSize = int(random(10,75))*8;
int rectSize = boardSize/8;

int rectColor1 = 0;
int rectColor2 = 255;

void setup(){
  size(boardSize,boardSize);
  smooth();
}

void draw(){
  for (x = 0; x < numberOfRectangles; x++){
    for (y = 0; y < numberOfRectangles; y++){
      if((x+y) % 2 == 0){
        fill(rectColor1);
      }
      else{
        fill(rectColor2);
      }
      rect(x*rectSize, y*rectSize, rectSize, rectSize);
    }
  }
}

void mousePressed(){
  rectColor1 = -1*rectColor1+255;
  rectColor2 = -1*rectColor2+255;
}
