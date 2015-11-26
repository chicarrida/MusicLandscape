
Table data;

int streifen;
int l = 40;
int w;
int r = 0;
int a = 0;
float lowMax = 0;
float lowMin = 0;
float midMax = 0;
float midMin = 0;
float highMax = 0;
float highMin = 0;
float high2Max = 0;
float high2Min = 0;
void setup() {
  importTable();
  size(w, 250); 
  noLoop();
  background(120);
}


void draw() {

  for (int i = 0; i< data.getRowCount(); i++) { 
    TableRow row = data.getRow(i);

    r = (int)random(10, 1.5*l);
    a = (int)map(r, 10, 40, 80, 255);
    drawHill(i, a, r, row);
    drawCloud(r, a, i*l, row);
    drawStar(r, i*l, a, row);
    drawFlower(r, i*l, a, row);
  }
}


void importTable() {
  data = loadTable("amy.csv", "header");
  streifen = data.getRowCount(); 
  TableRow max = data.getRow(0);
  lowMax = max.getFloat("minmaxlow");
  midMax= max.getFloat("minmaxmid");
  highMax = max.getFloat("minmaxhigh");
  high2Max = max.getFloat("minmaxhigh2");
  TableRow min = data.getRow(1);
  lowMin = min.getFloat("minmaxlow");
  midMin= min.getFloat("minmaxmid");
  highMin = min.getFloat("minmaxhigh");
  high2Min = min.getFloat("minmaxhigh2");
  
  w = streifen* l;
}


void drawHill(int i, int a, int r, TableRow row) {
  float dp = row.getFloat("low");
  float rad = map(dp, lowMin, lowMax, 10,70);    //find a common range instead of lowMin, lowMax
  float alpha = map(dp, lowMin, lowMax, 10, 255);
  
  fill(255, alpha);
  noStroke();
  ellipse(i*l, height+((r/4)), rad *1.5, rad);
}

void drawStar(float radius, int x, int a, TableRow row) {
  //r and a depending on value

  float dp = row.getFloat("high2");
  float rad = map(dp, high2Min, high2Max, 1,5);    //find a common range instead of lowMin, lowMax
  float alpha = map(dp, high2Min, high2Max, 10, 255);

  radius = map(r, 60, 200, 2, 5);
  pushMatrix();
  translate(x, height/4+random(-10, 10));
  int numPoints=5;
  float angle=TWO_PI/(float)numPoints;

  stroke(166, 215, 255, alpha);

  for (int i=0; i<numPoints; i++)
  {
    line(0, 0, rad*sin(angle*i)*1, rad*cos(angle*i)*1);
  }  
  popMatrix();
}


void drawCloud(int r, int a, int x, TableRow row) {
  float dp = row.getFloat("high");
  float rad = map(dp, highMin, highMax, 10,40);    //find a common range instead of lowMin, lowMax
  float alpha = map(dp, highMin, highMax, 100, 255);

  //r and a depending on value
  noFill();
  stroke(255, alpha);
  r = (int)map(r, 10, 200, 10, 120);
  for (int rr = 5; rr < rad; rr +=5) {
    ellipse(x, height/2-rad, rr*1.5, rr);
  }
}


void drawFlower(int r, int x, int a, TableRow row) {
  pushMatrix();


  float dp = row.getFloat("mid");
  float rad = map(abs(dp), midMin, midMax, 50,90);    //find a common range instead of lowMin, lowMax
  float alpha = map(abs(dp), highMin, highMax, 10, 255);
  int points = (int)(map(abs(dp), highMin, highMax, 3,10));
  
  if(dp < 0)
    stroke(166, 215, 255, alpha);
  else
    stroke(255, alpha);
    
  r = (int)map(r, 60, 200, 50, 140);

  translate(x, height-rad);
  line(0, height, 0, 0);

  //depending on value
  int numPoints=(int)random(3, 15);

  float angle=(PI/(float)points);
  rotate(-PI/2);
  for (int i=0; i<points; i++)
  {
    line(0, 0, 15*sin(angle*i)*1, 15*cos(angle*i)*1);
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




