int r = 100;
int streifen = 54;
int l = 600/streifen;
int a = 0;
void setup(){
  println(l);
 size(600, 200); 
 noLoop();
 background(120);
}


void draw(){
  
 for(int i = 0; i< streifen; i++){ 
   r = (int)random(10, streifen);
   a = (int)map(r, 10, 40, 80, 255);
   if(a<100)
     fill(0,a);
   else
     fill(255,a);
   noStroke();
   ellipse(i*l, height+((r/4)),  r *1.5, r);
   drawCloud(r,i*l);
   drawStar(r, i*l, a);
   drawFlower(r, i*l, a);
 } 
  
}

void drawStar(float radius, int x, int a){
  radius = map(r, 60,200,2,5);
  
  pushMatrix();
  translate(x, height/4+random(-10,10));

int numPoints=5;
float angle=TWO_PI/(float)numPoints;
   
     stroke(0,0,255,a);
   


for(int i=0;i<numPoints;i++)
{
  line(0,0,radius*sin(angle*i)*1,radius*cos(angle*i)*1);
}  
  popMatrix();
}


void drawCloud(int r, int x){
  noFill();
  stroke(255);
  r = (int)map(r, 60, 200, 30, 120);
 for(int rr = 5; rr < r; rr +=5){
    ellipse(x, height/2-r, rr*1.5, rr);
 } 
}
 
 
 void drawFlower(int r,int x, int a ){
   pushMatrix();
      if(a<100)
     stroke(0,a);
   else
     stroke(255,a);
   r = (int)map(r, 60, 200, 50, 140);
   translate(x, height-r);
  line(0,height,0,0);
 int numPoints=(int)random(3,15);
float angle=(PI/(float)numPoints);

fill(255,0,0);
rotate(-PI/2);
for(int i=0;i<numPoints;i++)
{
  line(0,0,15*sin(angle*i)*1,15*cos(angle*i)*1);
}   
popMatrix();
 }
  

