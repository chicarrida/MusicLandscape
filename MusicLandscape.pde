import processing.pdf.*;


Table data;


int streifen;
int scale = 3;
int l = 40*scale;
int w;
int r = 0;
int a = 0;
float lowMax = 3;
float lowMin = -0.2;
float midMax = 0.45;
float midMin = -0.25;
float highMax = -0.2;
float highMin = -0.7;
float high2Max = -0.9;
float high2Min = -0.7;
boolean white = true ;
String artist = "amy";

color c; 
void setup() {
 c = color(0,220,255);
  importTable();
  if (white)
    size(w*scale, 250*scale, PDF, artist+"_white_scale_"+scale+".pdf"); 
  else 
    size(w*scale, 250*scale, PDF, artist+"_grey_scale_"+scale+".pdf");
  noLoop();
  if (white)
    background(255);
  else 
    background(80);
}


void draw() {
  //scale(5);
  drawStuff(this.g);
  println("done...");
  exit();
}

void drawStuff(PGraphics pg) {
  pg.strokeWeight(6);
  for (int i = 0; i< data.getRowCount (); i++) { 
    TableRow row = data.getRow(i);

    drawHill(i, row, pg);
    drawFlower(i*l, row, pg);
    drawCloud( i*l, row, pg);
    drawStar(i*l, row, pg);
  }
}


void importTable() {
  data = loadTable(artist+".csv", "header");
  streifen = data.getRowCount();
  w = streifen*l;
}


void drawHill(int i, TableRow row, PGraphics pg) {
  float dp = row.getFloat("low");
  float rad = map(dp, lowMin, lowMax, 10*scale, 100*scale);    
  float alpha = map(dp, lowMin, lowMax, 50, 120);

  if (dp < 0) {
    pg.fill(c);
  } else {
    if (white)
      pg.fill(0, alpha);
    else
      pg.fill(255, alpha);
  }
  pg.noStroke();
  pg.ellipse(i*l+200, height+rad/10, rad *1.5, rad);
}


void drawFlower(int x, TableRow row, PGraphics pg) {
  pushMatrix();

  x = x+200;
  float dp = row.getFloat("mid");    
  float alpha = map(abs(dp), midMin, midMax, 50, 255);
  int points = (int)(map(abs(dp), midMin, midMax, 1, 14)+0.5);

  if (dp < 0) {
    pg.stroke(c, alpha);
  } else {
    if (white)
      pg.stroke(0, alpha);
    else
      pg.stroke(255, alpha);
  }

  translate(x, height-60*scale);
  pg.line(0, height, 0, 0);


  float angle=(PI/(float)points);
  rotate(-PI/2);
  int lenght = 20* scale;
  for (int i=0; i<points; i++)
  {
    pg.line(0, 0, lenght*sin(angle*i)*1, lenght*cos(angle*i)*1);
  }   
  popMatrix();
}





void drawCloud(int x, TableRow row, PGraphics pg) {

  float dp = row.getFloat("high");
  int numCircles = (int)(map(dp, highMin, highMax, 1, 10)+0.5);
  float alpha = map(dp, highMin, highMax, 50, 255);

  x = x +200;
  pg.noFill();
  if (dp < 0) {
    pg.stroke(c, alpha);
  } else {
    if (white)
      pg.stroke(0, alpha);
    else
      pg.stroke(255, alpha);
  }

  int rr = 7*scale;
  for (int i = 0; i <= numCircles; i++) {
    pg.ellipse(x, 2*height/3-numCircles*7*scale, rr*1.5, rr);
    rr +=7*scale;
  }
}

void drawStar(int x, TableRow row, PGraphics pg) {
  float dp = row.getFloat("high2");
  float rad = 5*scale; 
  float numPoints = (int)(map(dp, high2Min, high2Max, 1, 5)+0.5);
  float alpha = map(dp, high2Min, high2Max, 50, 255);

  pushMatrix();
  translate(x+200, height/4+rad);

  float angle=TWO_PI/(float)numPoints;

  pg.stroke(c, alpha);

  for (int i=0; i<numPoints; i++)
  {
    pg.line(0, 0, rad*sin(angle*i)*1, rad*cos(angle*i)*1);
  }  
  popMatrix();
}



void keyPressed()
{
  if (key == 's') {
    println("SAVING to test.png");
    int mySaveScale = scale;
    PGraphics pg = createGraphics(int(width*mySaveScale), int(height*mySaveScale), P2D);
    pg.beginDraw();
    pg.scale(mySaveScale);
    drawStuff(pg);
    pg.save("test.png");
    pg.endDraw();
  }
}

