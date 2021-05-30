class cardSys {
  private ArrayList<card> cards;

  cardSys() {
    cards = new ArrayList<card>();
    for (int t = 0; t < 4; t++)
      for (int n = 0; n < 13; n++) {
        card c = new card(n, type.values()[t]);
        cards.add(c);
        cards.get(n + t*13).zIndex = n + t*13;
      }
  }

  void display() {
    for (int i = 0; i < cards.size(); i++) {
      cards.get(i).display();
    }
  }

  void cardReset() {
    for (card c : cards) {
      c.state = cardState.initial;
      c.tarneeb = false;
      c.belong = null;
    }
  }

  void distr(player b1, player b2, player b3, player b4) {
    java.util.Collections.shuffle(cards);    
    for (int i = 0; i < 52; i++) {
      card c = cards.get(i);
      if (i < 13) {
        c.belong = b1;
        b1.addCard(c);
      } else if (i >= 13 && i < 26) {
        c.belong = b2;
        b2.addCard(c);
      } else if (i >= 26 && i < 39) {
        c.belong = b3;
        b3.addCard(c);
      } else {
        c.belong = b4;
        b4.addCard(c);
      }
    }
  }

  //t for conditional type
  card select(float x, float y, type t) {
    card selected = null;
    int order = -1;

    for (int i = 0; i < cards.size(); i++) {
      card c = cards.get(i);
      player p = c.belong;
      if (c.state == cardState.humanHand)
        if (x > c.posX && x < c.posX + c.w &&
          y > c.posY && y < c.posY + c.h &&
          p.turn)
          if (c.zIndex > order)
          {
            order = c.zIndex;
            selected = c;
          }
    }
    if (selected != null)
      if (selected.t == t || t == null || !selected.belong.checkTypeExs(t)) {
        selected.state = cardState.onFloor;
        selected.display();
        //println(t);
        return selected;
      }
    return null;
  }
}
