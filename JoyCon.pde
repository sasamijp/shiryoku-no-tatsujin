import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;


class JoyCon extends Controller {
  ControlIO control;
  ControlDevice device;
  String[] names = {"A", "B", "X", "Y", "SL", "SR", "PLUS", "STICK", "HOME", "R", "ZR"};
  Button bstate;

  JoyCon(PApplet p){
    control = ControlIO.getInstance(p);
    device = control.getMatchedDevice("joy-con-r");
    bstate = Button.NONE;
  }
  
  Button get_input(){
    if(device.getButton("A").pressed() && bstate != Button.MIGI){
      bstate = Button.MIGI;
      return Button.MIGI;
    }else if(device.getButton("Y").pressed() && bstate != Button.HIDARI){
      bstate = Button.HIDARI;
      return Button.HIDARI;
    }else if(device.getButton("X").pressed() && bstate != Button.UE){
      bstate = Button.UE;
      return Button.UE;
    }else if(device.getButton("B").pressed() && bstate != Button.SHITA){
      bstate = Button.SHITA;
      return Button.SHITA;
    }
    bstate = Button.NONE;
    return Button.NONE;  
  } 
}
