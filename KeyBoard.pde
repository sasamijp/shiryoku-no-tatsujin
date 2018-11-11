
class KeyBoard extends Controller {
  char key_before;
  Button get_input(){
    if(keyPressed && key != key_before){
      key_before = key;
      switch(key){
        case 'w':
          return Button.UE;
        case 'a':
          return Button.HIDARI;
        case 's':
          return Button.SHITA;
        case 'd':
          return Button.MIGI;
        default:
          return Button.NONE;
      }
    }
    key_before = 0;
    return Button.NONE;
  }
}
