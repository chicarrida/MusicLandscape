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
  size(w, 200); 
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
  lowMin = max.getFloat("minmaxlow");
  midMin= max.getFloat("minmaxmid");
  highMin = max.getFloat("minmaxhigh");
  high2Min = max.getFloat("minmaxhigh2");
  w = streifen* l;
}



void drawHill(int i, int a, int r, TableRow row) {
  //r and a depending on value
  fill(255, a);
  noStroke();
  ellipse(i*l, height+((r/4)), r *1.5, r);
}

void drawStar(float radius, int x, int a, TableRow row) {
  //r and a depending on value

  radius = map(r, 60, 200, 2, 5);
  pushMatrix();
  translate(x, height/4+random(-10, 10));
  int numPoints=5;
  float angle=TWO_PI/(float)numPoints;

  stroke(0, 0, 255, a);

  for (int i=0; i<numPoints; i++)
  {
    line(0, 0, radius*sin(angle*i)*1, radius*cos(angle*i)*1);
  }  
  popMatrix();
}


void drawCloud(int r, int a, int x, TableRow row) {

  //r and a depending on value
  noFill();
  stroke(255);
  r = (int)map(r, 10, 200, 10, 120);
  for (int rr = 5; rr < r; rr +=5) {
    ellipse(x, height/2-r, rr*1.5, rr);
  }
}


void drawFlower(int r, int x, int a, TableRow row) {
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
    line(0, 0, 15*sin(angle*i)*1, 15*cos(angle*i)*1);
  }   
  popMatrix();
}

