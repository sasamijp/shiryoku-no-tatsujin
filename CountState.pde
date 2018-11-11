
class CountState extends State {
  int t;
  int t_start = 500; // 5秒後に開始
  
  CountState(){
    t = millis();
  }
  
  void drawState() {
    text((5000 - millis() + t) / 1000, width * 0.5, height * 0.5);
  }

  State nextState() {
    if (millis() - t > t_start)
      return new GameState();
    return this;
  }
}
