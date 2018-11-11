import ddf.minim.*;

class Song{
  String name;
  String mp3_file_name;
  String humen_file_name;
  Song(String n, String m ,String h){
    this.name = n;
    this.mp3_file_name = m;
    this.humen_file_name = h;
  }
}

class GameState extends State {
  String[] lines;
  char[] notes;
  float[] times;
  PImage u, s, m, h, e1, e2, e3;
  float r_landolt=100, time_delta;
  int t_started, time_took;
  float speed=0.4, y, voice;
  boolean[] hit;
  int judgement_radius=100;
  int t_judgement_offset=100;
  int score=0, renda=0;
  int effect_point=0;
  Button b;
  AudioPlayer player, dp, kp, ue, shita, migi, hidari;
  AudioInput in;

  GameState(){
    u = loadImage("ue.png");
    s = loadImage("shita.png");
    m = loadImage("migi.png");
    h = loadImage("hidari.png");
    e1 = loadImage("effect1.png");
    e2 = loadImage("effect2.png");
    e3 = loadImage("effect3.png");

    lines = loadStrings(selected_song.humen_file_name);
    notes = new char[lines.length];
    times = new float[lines.length];
    hit   = new boolean[lines.length];
    for (int i=0 ; i<lines.length; i++) {
      String[] l = lines[i].split(" ");
      notes[i] = l[0].charAt(0);
      times[i] = float(l[1]) * 1000;
      hit[i] = false;
    }

    in = minim.getLineIn(Minim.STEREO, 512); 
    
    player = minim.loadFile(selected_song.mp3_file_name);
    player.play(); 
    t_started = millis();
    
    dp = minim.loadFile("don.wav");
    kp = minim.loadFile("ka.wav");
    
    ue = minim.loadFile("ue.mp3");
    migi = minim.loadFile("migi.mp3");
    hidari = minim.loadFile("hidari.mp3");
    shita = minim.loadFile("shita.mp3");
  }

  private PImage getImage(char note){
    switch(note){
      case 'u':
        return u;
      case 's':
        return s;
      case 'm':
        return m;
    }
    return h;
  }

  private void drawEffect(int point){
    switch(point){
      case 5:
        image(e1, -15, -15, r_landolt+30, r_landolt+30);
        break;
      case 4:
        image(e2, -15, -15, r_landolt+30, r_landolt+30);
        break;
      default:
        image(e3, -15, -15, r_landolt+30, r_landolt+30);
    }  
  }

  void drawState() {
    background(255);
    noFill();
    pushMatrix();
    voice = map(in.mix.level(), 0, 0.5, 0, 80);
    //rect(100, 100, voice*5, 100);
    //rect(100, 100, 20*5, 100);
    //if(voice > 20){
    //  background(200,255,255);
    //}
    r_landolt = 100 - (millis()-t_started)*15/10000;
    translate(width * 0.5 - r_landolt/2, height*0.8);
    
    ellipseMode(CORNER);
    ellipse(6, 6, r_landolt-12, r_landolt-12);
    b = controller.get_input();
    
    if(effect_point > 0)
      drawEffect(effect_point--);
    
    for(int i=0; i<notes.length; i++){
      time_took = millis() - t_started;
      time_delta = time_took - times[i];
      y = speed*time_delta;
      
      if(y > -height*0.8 && y < height-500 && !hit[i]){
        time_delta -= t_judgement_offset;
        if(abs(time_delta) < judgement_radius){ //&& voice > 20){
          if(notes[i] == 'u' && b == Button.UE){
            dp.play();
            dp.rewind();
            effect_point+=5;
            hit[i] = true;
            renda++;
            score += renda;
          }else if(notes[i] == 's' && b == Button.SHITA){
            dp.play();
            dp.rewind();
            hit[i] = true;
            effect_point+=5;
            renda++;
            score += renda;
          }else if(notes[i] == 'm' && b == Button.MIGI){
            kp.play();
            kp.rewind();
            effect_point+=5;
            hit[i] = true;
            renda++;
            score += renda;
          }else if(notes[i] == 'h' && b == Button.HIDARI){
            kp.play();
            kp.rewind();
            effect_point+=5;
            hit[i] = true;
            renda++;
            score += renda;
          }
        }else if(time_delta > judgement_radius){
          renda = 0;
        }
        image(getImage(notes[i]), 0, y, r_landolt, r_landolt);
      }
    }
    popMatrix();
    line(0, height*0.8, width, height*0.8);
    line(0, height*0.8+r_landolt, width, height*0.8+r_landolt);
    fill(0);
    text("連打:"+str(renda), 0, 30);
    text("スコア:"+str(score), 0, 60);
  }

  State nextState() {
    if (keyPressed && key == 'z')
      return new EndingState();
    return this;
  }
}
