import processing.serial.*; 

Serial myPort; 
int val = 0; 
int absVal = 0;

PImage hills;

float red, green, blue;
Star[] stars = new Star[200];


void setup()
{
  size(1080, 720, P3D);
  //hills = loadImage("faraway_hill.png");
  for(int i = 0; i < 200; i++)
  {
    stars[i] = new Star(random(0-width/2, width*2), random(0-height/2, height), random(5, 15));
  }
  

  printArray(Serial.list()); 
  String portName = Serial.list()[5]; 
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  if ( myPort.available() > 0) 
  {                     
    val = myPort.read();
    absVal = abs(val - 255/2);
    //println(val);
    println(absVal);
  }
  
  //println("x:" + mouseX + " y:" + mouseY);
  //tint(255, 80);
  //image(hills, 0, 0, 1080, 720);
  
  background(red, green, blue);
  
  for(int i = 0; i < 100; i++)
  {
    stars[i].drawStar(absVal-50);
  }
  
  noStroke();
  
 
  fill(250, 240, 230);
  textSize(50);
  if(absVal > 100)
  {
    red = map(absVal, 100, 127, 200, 50);
    green = map(absVal, 100, 127, 80, 10);
    blue = map(absVal, 100, 127, 120, 20);
    
    if(val<100) 
    { 
      text("Morning", 0, 50); 
    }
    else 
    { 
      text("Evening", 0, 50); 
    }
  }
  else if(absVal>50)
  {
    red = map(absVal, 50, 100, 150, 200);
    green = map(absVal, 50, 100, 100, 80);
    blue = map(absVal, 50, 100, 200, 120); 
    if(val>100)
    {
      text("Afternoon", 0, 50);
    }
    else { text("Morning", 0, 50); }
  }
  else
  {
    red = map(absVal, 0, 50, 220, 150);
    green = map(absVal, 0, 50, 200, 100);
    blue = map(absVal, 0, 50, 250, 200);    
    text("Noon", 0, 50);
  }

 
  lights();
  ambientLight(red, green, blue*2);
  directionalLight(red*2, green, blue, 
    map(val, 0, 255, 5, 0), map(val, 0, 255, 5, 0), map(val, 0, 255, 1, -1));

  
  //clouds
  pushMatrix(); 
  fill(255);
  translate(100, 100, -300);
  sphere(50);
  translate(150, -50);
  sphere(100);
  translate(150, 50);
  sphere(60);
  popMatrix();
  
  //house
  fill(150, 50, 50);
  pushMatrix();  
  
  //back roof
  beginShape();
  vertex(800, 300, -300);
  vertex(700, 500, -400);
  vertex(900, 500, -500);
  vertex(900, 300, -500);
  endShape(CLOSE);
  
  //wall
  fill(200, 200, 150);
  beginShape();
  vertex(850, 300, -350);
  vertex(1100, 500, -200);
  vertex(750, 500, -400);
  endShape(CLOSE);
  
  fill(150, 50, 50);
  //front roof
  beginShape();
  vertex(800, 300, -300);
  vertex(1000, 300, -400);
  vertex(1100, 500, -200);
  vertex(900, 500, -100);
  endShape(CLOSE);
  
  popMatrix();
  
  //foliage
  fill(100, 150, 80);
  //back hill
  pushMatrix();
  translate(700, 600, -200);
  rotateX(-0.1);
  rotateZ(-0.1);
  box(2000, 300, 500);
  popMatrix();
  
  //front hill
  pushMatrix();
  translate(700, 600, 200);
  rotateX(0.1);
  rotateZ(0.1);
  box(2000, 100, 300);
  popMatrix();
  
  //tree crown
  pushMatrix();
  translate(950, 250, -100);
  sphere(100);
  popMatrix();
  
  //tree trunk
  fill(150, 100, 50);
  pushMatrix();
  translate(950, 400, -100);
  box(30, 300, 30);
  popMatrix();
}

 void drawStars(int num)
 {
   for(int i = 0; i < num; i++)
   {
     circle(random(0, width), random(0, height), random(5, 15));
   }
 }
 
 class Star
 {
   float x, y, r;
   
   Star(float _x, float _y, float _r)
   {
     x = _x;
     y = _y;
     r = _r;
   }
   
   void drawStar(float tint)
   {  
     pushMatrix();
     translate(0, 0, -400);
     noStroke();
     fill(250, tint/1000*r*r*r);
     circle(x, y, r);
     popMatrix();
   }
   
 }
 
