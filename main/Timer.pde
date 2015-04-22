class Timer{
  
  int start;
  int stop;
  
  Timer (int time){
    int stop = time;
  }
  
  void start(){
    start = millis();
  }
  
  boolean finish(){
    boolean finished = false;
    
    int timeNow = millis();
    int passed = timeNow - start;
    
    System.out.println("\nStart: " + start + "Now: " + timeNow + "Passed: " + passed + "\n");
    if(passed % 30 == 0){
      finished = true;
    }
    else{
      finished = false; 
    }
    return finished;
  }
  
  
  
}
