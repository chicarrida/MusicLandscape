import processing.pdf.*;


Table data;


int streifen;
int scale = 1;
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

void setup() {

  importTable();
  size(w*scale, 250*scale);//, PDF, "file.pdf"); 
  noLoop();
  background(255);
}


void draw() {
  //scale(5);
  drawStuff(this.g);
  // exit();
}

void drawStuff(PGraphics pg) {
  strokeWeight(1.5);
  for (int i = 0; i< data.getRowCount (); i++) { 
    TableRow row = data.getRow(i);

    drawHill(i, row, pg);
    drawFlower(i*l, row, pg);
    drawCloud( i*l, row, pg);
    drawStar(i*l, row, pg);
  }
}


void importTable() {
  data = loadTable("amy.csv", "header");
  streifen = data.getRowCount();
  w = streifen*l;
}


void drawHill(int i, TableRow row, PGraphics pg) {
  float dp = row.getFloat("low");
  float rad = map(dp, lowMin, lowMax, 10*scale, 100*scale);    
  float alpha = map(dp, lowMin, lowMax, 10, 120);

  if (dp < 0) {
    pg.fill(166, 215, 255);
  } else {
    pg.fill(0, alpha);
  }
  pg.noStroke();

  pg.ellipse(i*l, height+rad/10, rad *1.5, rad);
  stroke(255, 0, 0);
}

void drawStar(int x, TableRow row, PGraphics pg) {
  float dp = row.getFloat("high2");
  float rad = 5; 
  float numPoints = (int)(map(dp, high2Min, high2Max, 1, 5)+0.5);
  float alpha = map(dp, high2Min, high2Max, 10, 255);

  pushMatrix();
  translate(x, height/4+rad);

  float angle=TWO_PI/(float)numPoints;

  pg.stroke(166, 215, 255, alpha);

  for (int i=0; i<numPoints; i++)
  {
    pg.line(0, 0, rad*sin(angle*i)*1, rad*cos(angle*i)*1);
  }  
  popMatrix();
}


void drawCloud(int x, TableRow row, PGraphics pg) {

  float dp = row.getFloat("high");
  int rad = (int)(map(dp, highMin, highMax, 1, 10)+0.5);
  float alpha = map(dp, highMin, highMax, 100, 255);



  pg.noFill();
  if (dp < 0)
    pg.stroke(166, 215, 255, alpha);
  else
    pg.stroke(0, alpha);

  int rr = 5;
  for (int i = 0; i <= rad; i++) {
    pg.ellipse(x, height/2-rad, rr*1.5, rr);
    rr +=5*scale;
  }
}


void drawFlower(int x, TableRow row, PGraphics pg) {
  pushMatrix();


  float dp = row.getFloat("mid");
  float rad = map(abs(dp), midMin, midMax, 50*scale, 90*scale);    
  float alpha = map(abs(dp), midMin, midMax, 10, 255);
  int points = (int)(map(abs(dp), midMin, midMax, 1, 14)+0.5);


  if (dp < 0)
    pg.stroke(166, 215, 255, alpha);
  else
    pg.stroke(0, alpha);


  translate(x, height-rad);
  pg.line(0, height, 0, 0);


  float angle=(PI/(float)points);
  rotate(-PI/2);
  for (int i=0; i<points; i++)
  {
    pg.line(0, 0, 15*sin(angle*i)*1, 15*cos(angle*i)*1);
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

