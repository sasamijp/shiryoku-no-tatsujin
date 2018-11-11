
class EndingState extends State {
  void drawState() {
    text("Ending", width * 0.5, height * 0.5);
  }

  State nextState() {
    if (keyPressed && key == 'a') {
      return new TitleState();
    }
    return this;
  }
}
