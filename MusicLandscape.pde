
Table data;

int streifen;
int scale = 2;
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
  size(w*scale, 250*scale, P2D); 
  noLoop();
  background(255);
}


void draw() {
  //scale(5);
  drawStuff(this.g);
  save("pic.tiff");
  
}

void drawStuff(PGraphics pg){
  
 //scale(2);
  for (int i = 0; i< data.getRowCount(); i++) { 
    TableRow row = data.getRow(i);

    drawHill(i, row, pg);
    drawFlower(i*l, row, pg);
    drawCloud( i*l, row, pg);
    drawStar(i*l, row, pg);
  
  }
 
  save("pic.tif");  
}


void importTable() {
  data = loadTable("beyonce.csv", "header");
  streifen = data.getRowCount(); 
 /* TableRow max = data.getRow(0);
  lowMax = max.getFloat("minmaxlow");
  midMax= max.getFloat("minmaxmid");
  highMax = max.getFloat("minmaxhigh");
  high2Max = max.getFloat("minmaxhigh2");
  TableRow min = data.getRow(1);
  lowMin = min.getFloat("minmaxlow");
  midMin= min.getFloat("minmaxmid");
  highMin = min.getFloat("minmaxhigh");
  high2Min = min.getFloat("minmaxhigh2");
  */
  w = streifen*(l);
}


void drawHill(int i, TableRow row, PGraphics pg) {
  float dp = row.getFloat("low");
  float rad = map(dp, lowMin, lowMax, 10*scale,100*scale);    
  float alpha = map(dp, lowMin, lowMax, 10, 120);
  
  pg.fill(0, alpha);
  pg.noStroke();
  pg.ellipse(i*l, height+((r/4)), rad *1.5, rad);
}

void drawStar(int x, TableRow row, PGraphics pg) {
  //r and a depending on value

  float dp = row.getFloat("high2");
  float rad = map(dp, high2Min, high2Max, 1*scale,5*scale); 
  float alpha = map(dp, high2Min, high2Max, 10, 255);

  pushMatrix();
  translate(x, height/4+rad);
  int numPoints=5;
  float angle=TWO_PI/(float)numPoints;

  pg.stroke(166, 215, 255);

  for (int i=0; i<numPoints; i++)
  {
    pg.line(0, 0, rad*sin(angle*i)*1, rad*cos(angle*i)*1);
  }  
  popMatrix();
}


void drawCloud(int x, TableRow row, PGraphics pg) {
  float dp = row.getFloat("high");
  float rad = map(dp, highMin, highMax, 10*scale,40*scale); 
  float alpha = map(dp, highMin, highMax, 100, 255);

  //r and a depending on value
  pg.noFill();
   if(dp < 0)
    pg.stroke(166, 215, 255);
  else
    pg.stroke(0);
  for (int rr = 5; rr < rad; rr +=5*scale) {
    pg.ellipse(x, height/2-rad, rr*1.5, rr);
  }
}


void drawFlower(int x, TableRow row, PGraphics pg) {
  pushMatrix();


  float dp = row.getFloat("mid");
  float rad = map(abs(dp), midMin, midMax, 50*scale,90*scale);    
  float alpha = map(abs(dp), highMin, highMax, 10, 255);
  int points = (int)(map(abs(dp), highMin, highMax, 3,10));
  
  if(dp < 0)
    pg.stroke(166, 215, 255);
  else
    pg.stroke(0);
    

  translate(x, height-rad);
  pg.line(0, height, 0, 0);

  //depending on value
  int numPoints=(int)random(3, 15);

  float angle=(PI/(float)points);
  rotate(-PI/2);
  for (int i=0; i<points; i++)
  {
    pg.line(0, 0, 15*sin(angle*i)*1, 15*cos(angle*i)*1);
  }   
  popMatrix();
}

void drawTree(int r, int x, int a, TableRow row) {
  pushMatrix();

  //a depending on value
  stroke(255, a);
  r = (int)map(r, 60, 200, 50, 140);

  //r also depending on value????
  translate(x, height-r);
  line(0, height, 0, 0);

  //depending on value
  int numPoints=(int)random(3, 15);

  float angle=(PI/(float)numPoints);
  rotate(-PI/2);
  for (int i=0; i<numPoints; i++)
  {    
    line(0-i*3, 0, 15*sin(angle*i)*3, 15*cos(angle*i));
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






