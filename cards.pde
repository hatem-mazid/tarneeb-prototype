//TODO
//improve graphic
//  lay out
//  cards
//  anime
//program the bot

import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

cardSys cards;

ArrayList<player> players;

rulesT rules;

void setup() {
  size(600, 500);
  pixelDensity(2);

  players = new ArrayList<player>();

  Ani.init(this);

  players.add(new bot(position.right));
  players.add(new bot(position.top));
  players.add(new bot(position.left));
  players.add(new humanPlayer(position.bottom));

  cards = new cardSys();

  cards.distr(players.get(0), 
    players.get(1), 
    players.get(2), 
    players.get(3));

  rules = new rulesT(cards, players.get(0), 
    players.get(1), 
    players.get(2), 
    players.get(3));

  rules.stage = stages.assessment;
}

void draw() {
  background(225);
  if (rules.stage == stages.distr) {
    rules.restart();
  }
  if (rules.stage == stages.assessment) {
    rules.playersRequest();
    for (player p : players) {
      p.display();
    }
  }
  if (rules.stage == stages.playing) {
    for (player p : players) {
      p.display();
    }
    rules.markTurn();
    rules.checkRoundEnd();
  }

  if (rules.stage == stages.showScore) { //<>//
    rules.showScore();
  }
}

void mousePressed() {
  if (rules.stage == stages.assessment) {
    player p = rules.checkTurn();
    if (p instanceof humanPlayer) {
      for (button b : rules.assessmentButtons) {
        int a = b.click(mouseX, mouseY);
        if (a != 0) {
          b.belong.assessment = a;
          rules.nextTurn();
        }
      }
    } else if (p instanceof bot)
      if (p.assessment == 0) {
        p.assess();
        rules.nextTurn();
      }

    if (rules.players.get(0).assessment != 0 && 
      rules.players.get(1).assessment != 0 && 
      rules.players.get(2).assessment != 0 && 
      rules.players.get(3).assessment != 0) {
      rules.stage = stages.playing;
    }
  }

  if (rules.stage == stages.playing) {
    player p = rules.checkTurn();
    if (rules.floorCards.size() != 0) {
      rules.roundType = rules.floorCards.get(0).t;
    }
    card c = null;
    if (p instanceof bot) {
      c = p.autoPlay(rules.roundType);
    } else if (p instanceof humanPlayer) {
      c = cards.select(mouseX, mouseY, rules.roundType);
    }
    if (c != null) {
      rules.floorCards.add(c);
      if (rules.floorCards.size() != 4)
        rules.nextTurn();
      rules.checkFloorCount();
    }
    rules.checkRoundEnd();
  }
  if (rules.stage == stages.showScore) {
    rules.showScore();
    if (rules.resetButton.click(mouseX, mouseY) == 1) {
      rules.stage = stages.distr;
    }
  }
}
