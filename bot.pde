class bot extends player {

  bot(position p) {
    super(p);
  }


  void addCard(card c) {
    //set card state to bot player
    c.state = cardState.botHand;
    cards.add(c);
    c.fliped = true;
    //reorder cards
    for (int i = 0; i < cards.size(); i++) 
      for (int j = i+1; j < cards.size(); j++) {
        card c1 = cards.get(i);
        card c2 = cards.get(j);
        if (c1.zIndex > c2.zIndex) {
          java.util.Collections.swap(cards, i, j);
        }
      }
  }
  card autoPlay(type t) {
    //while (true) {
    //  card c = cards.get(floor(random(cards.size())));
    //  if (c.t == t || t == null || !checkTypeExs(t))
    //    if (c.state == cardState.botHand) {
    //      c.state = cardState.onFloor;
    //      c.fliped = false;
    //      //println(""+c.number+c.t, t);
    //      return c;
    //    }
    //}

    ArrayList<card> options = new ArrayList<card>();
    for (int i = 0; i < cards.size(); i++) {
      card c = cards.get(i);
      //if (t != null);
      //if (c.t == t);
      //if (checkTypeExs(t));

      if (c.state == cardState.botHand)
        if (c.t == t || t == null || !checkTypeExs(t))
          options.add(c);
    }


    println(options.size());
    options.get(0).state = cardState.onFloor;
    options.get(0).fliped = false;
    return options.get(0);
  }

  int assess() {
    int a = floor(random(2, 5));
    assessment = a;
    return a;
  }
}
