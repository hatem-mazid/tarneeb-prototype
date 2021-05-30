class rulesT { //<>//
  cardSys cards;
  int finishedCards;

  ArrayList<player> players;

  int initialTurnNum;
  int turnNum;
  player turn;

  ArrayList<card> floorCards;
  ArrayList<card> lastHand;

  type roundType;
  type tarneeb;

  stages stage;
  ArrayList<button> assessmentButtons;

  button resetButton;

  rulesT(cardSys cs, player p1, player p2, player p3, player p4) {
    cards = cs;

    players = new ArrayList<player>();
    players.add(p1);
    players.add(p2);
    players.add(p3);
    players.add(p4);

    turnNum = 0;
    initialTurnNum = 0;

    stage = stages.distr;

    floorCards = new ArrayList<card>();
    lastHand = new ArrayList<card>();

    assessmentButtons = new ArrayList<button>();
    resetButton = new button(1, "rest", width/2, height*3/4, null);

    for (player p : players)
      if (p instanceof humanPlayer) {
        float x = 0;
        float y = 0;
        if (p.pos == position.bottom) {
          x = width/2;
          y = height - 150;
        }
        if (p.pos == position.right) {
          x = width - 100;
          y = height/2;
        }
        if (p.pos == position.top) {
          x = width/2;
          y = 100;
        }
        if (p.pos == position.left) {
          x = 100;
          y = height/2;
        }
        assessmentButtons.add(new button(2, "2", x - 150, y, p));
        assessmentButtons.add(new button(3, "3", x - 100, y, p));
        assessmentButtons.add(new button(4, "4", x - 50, y, p));
        assessmentButtons.add(new button(5, "5", x, y, p));
        assessmentButtons.add(new button(6, "6", x + 50, y, p));
        assessmentButtons.add(new button(7, "7", x + 100, y, p));
        assessmentButtons.add(new button(8, "8", x + 150, y, p));
        assessmentButtons.add(new button(9, "9", x + 200, y, p));
      }

    tarneeb = type.values()[floor(random(4))];
    for (int i = 0; i < cards.cards.size(); i++) {
      if (cards.cards.get(i).t == tarneeb) {
        cards.cards.get(i).tarneeb = true;
      }
    }
  }

  player checkTurn() {
    switchTurn(turnNum);
    return turn;
  }

  void nextTurn() {
    turnNum++;
    turnNum %= 4;
  }

  void checkFloorCount() {
    if (floorCards.size() == 4) {
      for (card c : lastHand) {
        c.state = cardState.finished;
      }
      finishedCards += 4;
      for (card c : floorCards) {
        c.state = cardState.lastHand;
        lastHand.add(c);
      }

      //println("type: "+roundType);

      int biggest = 0;
      card biggestCard = null;
      for (int i = 0; i < floorCards.size(); i++) {
        card c = floorCards.get(i);

        if (c.t == tarneeb) { 
          c.val = c.number+13;
        } else if (c.t == roundType) { 
          c.val = c.number;
        } else { 
          c.val = -1;
        }
        print(c.val+" ");
        if (c.val > biggest) {
          biggestCard = c;
          biggest = c.val;
        }
      }
      println();
      if (biggestCard != null) {
        biggestCard.belong.score++;
        turnNum = biggestCard.belong.pos.ordinal();
        //println("win: "+biggestCard.number+biggestCard.t);
        //println("win: "+biggestCard.belong.pos);
      }

      //println("right: "+players.get(0).score, 
      //  "top: "+players.get(1).score, 
      //  "left: "+players.get(2).score, 
      //  "bottom: "+players.get(3).score);


      roundType= null;
      floorCards.clear();
      //println("cleared");
    }
  }
  type checkType(card c) {
    if (floorCards.size() == 0) {
      return null;
    }
    return c.t;
  }

  void markTurn() {
    fill(255, 100, 100);
    switch(turnNum) {
    case 0:
      ellipse(width - 100, height/2, 20, 20);
      break;
    case 1:
      ellipse(width/2, 100, 20, 20);
      break;
    case 2:
      ellipse(100, height/2, 20, 20);
      break;
    case 3:
      ellipse(width/2, height - 100, 20, 20);
      break;
    }
  }

  void checkRoundEnd() {
    if (finishedCards == 52) {
      stage = stages.showScore;
    }
    //println(finishedCards);
  }

  void playersRequest() {
    for (button b : assessmentButtons) {
      b.display();
    }
  }

  void showScore() {
    int pos = 50;
    textSize(12);
    for (player p : players) {
      p.addScore();
      text(p.log, pos, 50);
      pos += 100;
    }

    resetButton.display();
    //TODO
    //noLoop();
  }

  void restart() {
    for (player p : players) {
      p.cards.clear();
    }
    initialTurnNum++;
    initialTurnNum %= 4;
    turnNum = initialTurnNum;
    cards.cardReset();
    lastHand.clear();
    finishedCards = 0;
    tarneeb = type.values()[floor(random(4))];
    cards.distr(players.get(0), 
      players.get(1), 
      players.get(2), 
      players.get(3));

    tarneeb = type.values()[floor(random(4))];
    for (int i = 0; i < cards.cards.size(); i++) {
      if (cards.cards.get(i).t == tarneeb) {
        cards.cards.get(i).tarneeb = true;
      }
    }
    stage = stages.assessment;
  }

  //change player turn
  private void switchTurn(int n) {
    for (int i = 0; i < players.size(); i++) {
      if (n == i) {
        players.get(i).turn = true;
        turn = players.get(i);
      } else {
        players.get(i).turn = false;
      }
    }
  }
}
