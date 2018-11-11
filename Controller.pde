
enum Button {
  UE,
  SHITA,
  MIGI,
  HIDARI,
  NONE
}

abstract class Controller{
  abstract Button get_input();
}
