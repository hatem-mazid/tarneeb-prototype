class humanPlayer extends player {

  humanPlayer(position p) {
    super(p);
  }

  void addCard(card c) {
    //set card state to player
    c.state = cardState.humanHand;
    cards.add(c);
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
}
