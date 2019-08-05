PVector pos = new PVector();
PVector v = new PVector();
PVector a = new PVector();
PVector mouse = new PVector(mouseX, mouseY);
float V_FACTOR = 0.01;
float A_FACTOR = 1000;
float GRAVITY = 0.1;
int RADIUS = 25;
int oldTime, deltaTime;
boolean gameover = true;
int START_DELAY = 3000;
int timer;
int endtime, gametimer;

PVector rectPos = new PVector();
PVector rectV = new PVector();
float RECT_V_FACTOR = 0.05 ;
int START_AREA = 1000;
float areasize = START_AREA;
float SHRINK_FACTOR = 0.05;


boolean recttest = false;
void setup() {
  size(1000, 1000);
  pos.set(width/2, height/5);

  rectPos.set(width/2, height/2);
  oldTime = millis();
  textAlign(CENTER);
  rectMode(CENTER);

  background(0);
}


void draw() {
  int deltaTime = millis()-oldTime;
  oldTime = millis();
 // deltaTime *=2;

  timer += deltaTime;
  if (!gameover) {
    background(0);
    fill(255);
    rect(rectPos.x, rectPos.y, areasize, areasize);
    fill(0);
    circle(pos.x, pos.y, RADIUS*2);

    if (timer>= START_DELAY) {
      gametimer += deltaTime;

      if (areasize > 500) {
        areasize -= deltaTime*SHRINK_FACTOR;
      } else if (!recttest) {
        recttest =true;
        rectV.set (random(-1, 1), random(-1, 1));
        rectV.setMag(1);
        //areasize = 500;
      } else {
        rectPos.x += deltaTime*RECT_V_FACTOR*rectV.x;
        rectPos.y += deltaTime*RECT_V_FACTOR*rectV.y;
        areasize -= deltaTime*SHRINK_FACTOR/4;
      }

      if (rectPos.x > width-areasize/2 || rectPos.x <= 0+areasize/2) {
        rectPos.x -= deltaTime*RECT_V_FACTOR*rectV.x;
        rectV.x *= -1;
        rectV.rotate(random(-PI/4, PI/4));
      }
      if (rectPos.y > height-areasize/2 || rectPos.y <= 0+areasize/2) {
        rectPos.y -= deltaTime*RECT_V_FACTOR*rectV.y;
        rectV.y *= -1;
        rectV.rotate(random(-PI/4, PI/4));
      }
      println(areasize);


      mouse.set(mouseX, mouseY);
      a.set(PVector.sub(pos, mouse));
      a.setMag(1/sq(a.mag()));
      //   a.setMag(1/a.mag());
      v.add(PVector.mult(a, deltaTime*A_FACTOR));
      v.y += GRAVITY*deltaTime;
      pos.add(PVector.mult(v, deltaTime*V_FACTOR));

      if (pos.x >= rectPos.x +areasize/2 - RADIUS || pos.x <= rectPos.x-areasize/2+RADIUS || pos.y >= rectPos.y+areasize/2-RADIUS|| pos.y <= rectPos.y-areasize/2+RADIUS) {

        gameover = true;
        endtime = gametimer;
      }
    } else {
      float resttime = float((START_DELAY-timer)/100)/10;
      println(resttime);
      text(int (resttime) + "." + (int(resttime *10))%10, width/2, height/2);
    }
  } else {
    fill(255);
    background(0);
    textSize(100);
    text("GAMEOVER", width/2, height/2);
    textSize(50);
    text("SCORE: " + endtime, width/2, height/2+100);
  }
}
void keyPressed() {
  if ( key == ' ' && gameover) {
    gameover = false;
    pos.set(width/2, height/5);
    v.set(0, 0);
    a.set(0, 0);
    timer = 0;
    gametimer = 0;
    areasize = START_AREA;
    rectPos.set(width/2, height/2);

    recttest = false;
  }
}
