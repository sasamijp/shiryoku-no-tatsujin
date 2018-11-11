
abstract class State {
  State() {}

  State doState() {
    drawState();
    return nextState();
  }

  abstract void drawState();
  abstract State nextState();
}
