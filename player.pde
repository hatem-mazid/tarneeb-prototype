class player {
  //cards
  final ArrayList<card> cards;

  //posistion on table
  //0 right
  //1 top
  //2 left
  //3 bottom
  position pos;

  //turn
  boolean turn;

  //score
  int score;
  int finalScore;
  int assessment;
  String log;

  player(position p) {
    cards = new ArrayList<card>();
    pos = p;

    turn = false;

    score = 0;

    log = p + "\n";
  }

  void addCard(card c) {
  }
  card autoPlay(type t) { 
    return null;
  }
  int assess(float x, float y) {
    return 0;
  }
  int assess() {
    return 0;
  }

  void display() {
    for (int i = 0; i < cards.size(); i++) {
      card c = cards.get(i);
      if (c.state == cardState.humanHand || c.state == cardState.botHand) {
        if (pos == position.right) {
          c.posX = width - 75;
          c.posY = 50 + i*20;
        }
        if (pos == position.top) {
          c.posX = 100+i * 20;
          c.posY = 25;
        }
        if (pos == position.left) {
          c.posX = 25;
          c.posY = 50 + i*20;
        }
        if (pos == position.bottom) {
          c.posX = 100+i * 20;
          c.posY = height - 75;
        }
      }
      //show cards
      c.display();
    }
    textSize(12);
    fill(0);
    if (pos == position.bottom) text(score+"/"+assessment, width/2, height-100);
    if (pos == position.right) text(score+"/"+assessment, width - 100, height/2);
    if (pos == position.top) text(score+"/"+assessment, width/2, 100);
    if (pos == position.left) text(score+"/"+assessment, 100, height/2);
  }

  boolean checkTypeExs(type t) {
    for (int i = 0; i < cards.size(); i++) {
      if (cards.get(i).t == t &&
        (cards.get(i).state == cardState.humanHand || cards.get(i).state == cardState.botHand) ) {
        return true;
      }
    }
    return false;
  }

  void addScore() {
    if (assessment != 0) {
      if (assessment > score)
        finalScore -= assessment;
      else 
      finalScore += assessment;
      fill(0);
      log += score+"/"+assessment+" : "+finalScore+"\n";
      score = 0;
      assessment = 0;
    }
  }
}
