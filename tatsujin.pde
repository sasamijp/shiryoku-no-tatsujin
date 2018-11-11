
State state;
Minim minim;
Controller controller;
Song selected_song;
Song[] songs = {new Song("残酷な天使のテーゼ", "残酷な天使のテーゼ.mp3", "tese.humen"),
                new Song("ようこそジャパリパークへ", "ようこそジャパリパークへ.mp3", "japari.humen"),
                new Song("トルコ行進曲(ベートーヴェン)", "トルコ行進曲(ベートーヴェン).mp3", "toruko.humen"),
                new Song("残酷な天使のテーゼ(おに)", "残酷な天使のテーゼ.mp3", "tese_oni.humen")};

void setup() {
  size(800, 1000);
  textSize(32);
  frameRate(60);
  
  PFont font;
  font = createFont("HiraMinPro-W3-48", 32);
  textFont(font);
  
  minim = new Minim(this);
  state = new TitleState();
  controller = new JoyCon(this);
}

void draw() {
  background(0);
  state = state.doState();
}
