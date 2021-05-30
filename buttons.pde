class button {
  float posX, posY;
  int w, h;
  int val;
  String text;

  player belong;

  button(int s, String txt, float x, float y, player p) {
    w = 30;
    h = 30;
    posX = x;
    posY = y;
    val = s;
    text = txt;
    belong = p;
  }
  void display() {
    fill(255);
    rect(posX, posY, w, h);
    textAlign(CENTER, CENTER);
    fill(0);
    text(text, posX+w/2, posY+h/2);
  }

  int click(float x, float y) {
    if (x > posX && x < posX + w &&
      y > posY && y < posY + h) {
      return val;
    }
    return 0;
  }
}
