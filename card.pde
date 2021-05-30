class card implements Comparable<card> {
  //display info
  int w, h;            //width & height
  float posX;          //x axis
  float posY;          //y axis
  boolean fliped;      //flipped
  boolean notAllowed;  //show if card can played
  boolean tarneeb;     //if it tarneeb
  int zIndex;           //oredr based on number & kind

  //identity
  int number;          //number of card
  type t;              //kind of card
  int val;

  //state
  //0 before playing
  //1 human hand hand
  //2 bot hand
  //3 on floor
  //4 finished
  cardState state;
  player belong;


  card(int n, type c) {
    //set type and number
    this.number = n;
    this.t = c;

    //set display info
    w = 40;
    h = 60;
    fliped = false;

    tarneeb = false;

    //initial state
    state = cardState.initial;
  }

  void display() {
    if (state != cardState.initial && state != cardState.finished) {
      if (fliped) {
        fill(125);
        rect(posX, posY, w, h);
      } else {
        if (tarneeb) fill(#F9FF5A);
        else if (notAllowed) fill(200);
        else fill(255);

        rect(posX, posY, w, h);
        if (t == type.H || t == type.D)
          fill(255, 0, 0);
        if (t == type.M || t == type.S)
          fill(0);
        textAlign(CENTER, CENTER);
        textSize(8);
        text(number + t.toString(), posX + 10, posY + h/10);
      }

      if (state == cardState.onFloor) {
        if (belong.pos == position.right) {
          setPos(width/2 + 50, height/2);
        }     
        if (belong.pos == position.top) {
          setPos(width/2, height/2 - 50);
        }     
        if (belong.pos == position.left) {
          setPos(width/2 - 50, height/2);
        }     
        if (belong.pos == position.bottom) {
          setPos(width/2, height/2 + 50);
        }
      }

      if (state == cardState.lastHand) {
        float x = width - 100;
        float y = height - 100;

        if (belong.pos == position.right) {
          setPos(x + 50, y);
        }     
        if (belong.pos == position.top) {
          setPos(x, y - 50);
        }     
        if (belong.pos == position.left) {
          setPos(x - 50, y);
        }     
        if (belong.pos == position.bottom) {
          setPos(x, y + 50);
        }
      }
      
    }
  }

  void setPos(float x, float y) {
    Ani.to(this, .5, "posX", x, Ani.ELASTIC_OUT);
    Ani.to(this, .5, "posY", y, Ani.ELASTIC_OUT);

    posX = x;
    posY = y;
  }

  public int compareTo(card c) {
    if (zIndex > c.zIndex) return 1;
    else if (zIndex < c.zIndex) return -1;
    else return 0;
  }
}
