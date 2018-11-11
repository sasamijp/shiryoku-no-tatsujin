
class TitleState extends State {
  private PImage back;
  private Button b;
  private int i_selected_song;
  private int t_lock=70, t_locked=0;
  
  TitleState(){
    back = loadImage("tatsujin.png");
    i_selected_song = 1;
    selected_song = songs[i_selected_song];
  }

  void drawState() {
    if(millis() - t_locked > t_lock){
      b = controller.get_input();
      if(b == Button.SHITA){
        i_selected_song = (i_selected_song + 1) % songs.length;
        selected_song = songs[i_selected_song];
      }
      if(b == Button.UE){
        if(i_selected_song == 0)
          i_selected_song = songs.length-1;
        else
          i_selected_song--;
        selected_song = songs[i_selected_song];
      }
      t_locked = millis();
    }
    
    background(255);
    image(back, 100, 100, back.width/2, back.height/2);
    strokeWeight(4); 
    translate(0, 700);
    for(int i=0; i<4; i++){
      noFill();
      rect(40, 40+i*60, width-100, 50);
      if(songs[i] == selected_song){
        stroke(255, 0, 0);
        rect(38, 38+i*60, width-96, 54);
      }
      fill(0);
      stroke(0, 0, 0);
      text(songs[i].name, 50, 60*(i+1)+23);
    }
  }

  State nextState() {
    if (b == Button.MIGI)
      return new CountState();
    return this;
  }
}
