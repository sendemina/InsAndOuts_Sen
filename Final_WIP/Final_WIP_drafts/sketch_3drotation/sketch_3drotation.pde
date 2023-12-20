import processing.sound.*;
import processing.serial.*; 

Serial myPort; 
int val = 0;

enum axisState { Xa, Ya, Za };
axisState currentAxis;
 
float valX, valY, valZ;


float rotX, rotY;
PVector move;
int size = 50;
int X = 50;
int Y = 50;
Cube[][] cubes = new Cube[X][Y];

float elevation;
float xOff, yOff;
SoundFile sencraft; 

void setup()
{
  size(1000, 600, P3D);
  
  //String portName = Serial.list()[0]; //for windows
  String portName = Serial.list()[5];   //for mac
  myPort = new Serial(this, portName, 9600);
  
  move = new PVector(0, 0, 0);
  for(int i = 0; i < X; i++)
  {
    for(int j = 0; j < Y; j++)
    {
      cubes[i][j] = new Cube(i*size, j*size, 0);
    }
  }
  calculateElevation();
  shapeMode(CENTER); 
  sencraft = new SoundFile(this, "sencraft_draft.mp3"); 
  sencraft.amp(0.1);
  sencraft.loop();
  lightSpecular(128, 128, 128);
  rotY= 2.25*PI/3;
}

void draw()
{
  background(100, 150, 200);
  noFill();
  stroke(1);
  strokeWeight(1);
  translate(width/2, height/2+size, 500);  
  rotateX(rotX);
  rotateY(rotY);
  //sphere(20);
  
  if(myPort.available() > 0) 
  {                     
    val = myPort.read();
    switch(val)
    {
      case 0:
        currentAxis = axisState.Xa;
        break;
      case 1:
        currentAxis = axisState.Ya;
        break;
      case 2:
        currentAxis = axisState.Za;
        break;
      default:
        handleInputAxes();
    }
  
  pushMatrix();
  }
  
  if(keyPressed)
  {
    //
    if(keyCode==UP) { move.add(new PVector(-sin(rotY)*3, 0, cos(rotY)*3)); }
    if(keyCode==DOWN) {  move.add(new PVector(sin(rotY)*3, 0, -cos(rotY)*3)); }
    if (keyCode==LEFT) { rotY-=PI/36; }
    if(keyCode==RIGHT) { rotY+=PI/36; }
    if (key=='w') { rotX+=PI/36; }
    if (key=='s') { rotX-=PI/36; }
      rotateX(rotX);
    //if(keyCode==SHIFT) { elevation += size*1.5; }
  }
  

  //stroke(100, 100, 200);
  //lights();
  spotLight(200, 150, 100, 0, size, -100, sin(rotY)*3, 0, -cos(rotY)*3, PI/2, 100);
  ambientLight(50, 50, 200);
  noStroke();
  strokeWeight(5);
  //println(elevation);
  translate(move.x, elevation, move.z);

  //elevation = 0;
  
  for(int i = 0; i < X; i++)
  {
    pushMatrix();
    for(int j = 0; j < Y; j++)
    {
      pushMatrix();
      translate(0, cubes[i][j].elevation, 0);
      cubes[i][j].drawCube();
      cubes[i][j].x = move.x+size*i;
      cubes[i][j].y = move.z+size*j;
      cubes[i][j].drawCube();
      popMatrix();
      
      translate(0, 0, size);
      //println(cubes[i][j].isAtOrigin());
      if(cubes[i][j].isAtOrigin())
      {
        elevation = 50-cubes[i][j].elevation;
      }
      //else elevation-=0.1;
      //println(elevation);
    }
    popMatrix();
    translate(size, 0, 0);
  } 
  popMatrix();
  
  if(elevation < -2000)
  {
    textSize(50);
    textMode(CENTER);
    background(200, 100, 100);
    stroke(1);
    strokeWeight(5);
    text("YOU FOOL", 0, 0, 50, 50);
    circle(0, 0, 50);
    println("ded");
  }
}

void handleInputAxes()
{
  if(currentAxis == axisState.Xa) 
  {  
    valX = val;
    rotX += map(valX, 3, 255, -0.1, 0.1);
  }    
  
  else if (currentAxis == axisState.Ya) 
  {  
    valY = val;
    rotY += map(valY, 3, 255, -0.1, 0.1);
  }
  
  else if(currentAxis == axisState.Za) 
  {  
    valZ = val;
  }
  
  else { println("state error"); }

  println("x="+valX+" y="+valY+" z="+valZ);
}

class Cube
{
  float x, y;
  int elevation;
  boolean hasTree;
  Tree tree;
  
  Cube(float _x, float _y, int _elevation)
  {
    x = _x;
    y = _y;
    elevation = _elevation;
    if(int(random(30))==0) { hasTree = true; }
    if(hasTree)
    {
      tree = new Tree(this, int(random(8, 20)));
    }
  }
  
  void drawCube()
  {
    fill(100, 200, 100);
    box(size);
    if(hasTree) { tree.drawTree(); }
  }
  
  boolean isAtOrigin()
  {
    if(x >= 0 && x <= size && y >= 0 && y <= size)
    {
      //println("at origin");
      return true;
    }
    else 
    { 
      //println("NOOOOOOOOOT at origin");
      return false; 
    }
  }
}

class Tree
{
  Cube cube;
  int tall;
  
  Tree(Cube _cube, int _tall)
  {
    cube = _cube;
    tall = _tall;
    //println("made tree");
  }
  
  void drawTree()
  {
    fill(100, 100, 50);
    pushMatrix();
    for(int i = 0; i < tall; i++)
    {
      translate(0, -size, 0);
      box(size);
    }
    fill(100, 200, 100);
    sphere(150);
    popMatrix();
  }
}
void calculateElevation()
{
  xOff = 0; 
  for(int i = 0; i < X; i++)
  {
    yOff = 0;
    for (int j = 0; j < Y; j++)
    {
      cubes[i][j].elevation = int(map(noise(xOff, yOff), 0, 1, 0, 10))*size;
      //elevation[i][j] = int(random(-2, 2))*size;
      //println("elevation["+i+"]"+"["+j+"]"+" = "+cubes[i][j].elevation);               
      yOff += 0.1;
    }
    xOff += 0.1;
  }
  //println("elevation calculated");
}
