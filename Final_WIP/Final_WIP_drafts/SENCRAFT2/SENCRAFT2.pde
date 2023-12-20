import processing.sound.*;
import processing.serial.*; 

Serial myPort; 
int val = 0;

enum inputState { Xa, Ya, Za, Sel, Vert, Horz };
inputState currentInput;
 
int valX, valY, valZ, valS, valV, valH;

float nextRotX, nextRotY;
boolean rotToPosX, rotToPosY;
float rotX, rotY;

PVector move;
PVector moveTo;
boolean moveToPosX, moveToPosY;

float incr = 0.05;

float walkSpeed = 5;
int cubeSize = 50;
int X = 50;
int Y = 50;
Cube[][] cubes = new Cube[X][Y];

float elevation;
float xOff, yOff;
SoundFile sencraft; 

void setup()
{
  size(1000, 600, P3D);
  //soundtrack();
  setupSerial();
  
  move = new PVector(0, 0, 0);
  moveTo = new PVector(0, 0, 0);
  
  for(int i = 0; i < X; i++)
  {
    for(int j = 0; j < Y; j++)
    {
      cubes[i][j] = new Cube(i*cubeSize, j*cubeSize, 0);
    }
  }
  calculateElevation();
  shapeMode(CENTER); 
  
  lightSpecular(128, 128, 128);
  //rotY = PI;
  noCursor();
}

void soundtrack()
{
  sencraft = new SoundFile(this, "sencraft_draft.mp3"); 
  sencraft.amp(0.1);
  sencraft.loop();
}

void setupSerial()
{
  //String portName = Serial.list()[0]; //for windows
  String portName = Serial.list()[5];   //for mac
  myPort = new Serial(this, portName, 9600);
}

void handleSerialInput()
{
  if(myPort.available() > 0) 
  {                     
    val = myPort.read();
    
    switch(val)
    {
      case 0:
        currentInput = inputState.Xa;
        //println("state is now X "+millis());
        break;
      case 1:
        currentInput = inputState.Ya;
        //println("state is now Y "+millis());
        break;
      case 2:
        currentInput = inputState.Za;
        //println("state is now Z "+millis());
        break;
      case 3:
        currentInput = inputState.Sel;
        //println("state is now S "+millis());
        break;
      case 4:
        currentInput = inputState.Vert;
        //println("state is now V "+millis());
        break;
      case 5:
        currentInput = inputState.Horz;
        //println("state is now H "+millis());
        break;
      default:
        handleInputAxes();
        //println(val);
    }
  }
  //else { println("port unavailable"); }
}

void handleInputAxes()
{
  switch(currentInput)
  {
    case Xa:
      valX = val;
      nextRotY = -(PI/3+valX/255.0*2*PI);
      if(nextRotY - rotY > 0) { rotToPosY = true; }
      else { rotToPosY = false; }
      //rotY = -(PI/3+valX/255.0*2*PI);
      break;
    case Ya:
      valY = val;
      nextRotX = -(PI/2-valY/255.0*PI);
      if(nextRotX - rotX > 0) { rotToPosX = true; }
      else { rotToPosX = false; }
      //rotX = PI/2-valY/360.0*PI;
      break;
    case Za:
      valZ = val;
      break;
    case Sel: break;
    case Vert:
    //println(val);
      moveTo.add(new PVector(-sin(rotY)*(val-125)*walkSpeed, 0, cos(rotY)*(val-125)*walkSpeed));
      if(moveTo.z > move.z) { moveToPosY = true; }
      else { moveToPosY = false; }
      //move.add(new PVector(-sin(rotY)*(val-125), 0, cos(rotY)*(val-125)));
      break;
    case Horz:
    //println(val);
      moveTo.add(new PVector(-sin(rotY-PI/2)*(val-132)*walkSpeed, 0, cos(rotY-PI/2)*(val-132)*walkSpeed));
      if(moveTo.x > move.x) { moveToPosX = true; }
      else { moveToPosX = false; }
      //move.add(new PVector(-sin(rotY-PI/2)*(val-132), 0, cos(rotY-PI/2)*(val-132)));
      break;
    default:
      println("state error");
  }
  
  //println("x="+valX+" y="+valY+" z="+valZ);
  //println("x="+rotX+" y="+rotY+" z="+valZ);
  //println("vert="+move.y+" horz="+move.x+" sel=");
}

void rotateTowards()
{
  if(abs(nextRotY - rotY) > incr)
  {
    if(rotToPosY) { rotY += incr; }
    else { rotY -= incr; }
  }
  
  if(abs(nextRotX - rotX) > incr)
  {
    if(rotToPosX) { rotX += incr; }
    else { rotX -= incr; }
  }
}

void moveTowards()
{
  println(moveTo.x + " " + moveTo.y + " | " + move.x + " " + move.y);
  if(abs(moveTo.x - move.x) > incr*10)
  { 
    if(moveToPosX) { move.add(walkSpeed, 0, 0); }
    else { move.add(-walkSpeed, 0, 0); }
  }
  else { move.x = moveTo.x; }
  
  if(abs(moveTo.z - move.z) > incr*10)
  {
    if(moveToPosY) { move.add(0, 0, walkSpeed); }
    else { move.add(0, 0, -walkSpeed); }
  }
  else { move.z = moveTo.z; }
}

void keyboardControls()
{
  rotX = -mouseY*PI/200;
  rotY = mouseX*PI/200;
  
  if(keyPressed)
  {
    if(keyCode==UP) { move.add(new PVector(-sin(rotY)*walkSpeed, 0, cos(rotY)*walkSpeed)); }
    if(keyCode==DOWN) {  move.add(new PVector(sin(rotY)*walkSpeed, 0, -cos(rotY)*walkSpeed)); }
    if(keyCode==LEFT) { move.add(new PVector(-sin(rotY-PI/2)*walkSpeed, 0, cos(rotY-PI/2)*walkSpeed)); }
    if(keyCode==RIGHT) { move.add(new PVector(-sin(rotY+PI/2)*walkSpeed, 0, cos(rotY+PI/2)*walkSpeed)); }
    //if(keyCode==SHIFT) { elevation += cubeSize*1.5; }
  }
}

void draw()
{
  background(100, 150, 200);
  noFill();
  stroke(1);
  strokeWeight(1);
  translate(width/2, height/2+cubeSize, 500);  
  rotateX(rotX);
  rotateY(rotY);
  //sphere(20);
  
  pushMatrix();
  
  //keyboardControls();
  
  //=====ARDUINO CONTROLS===
  handleSerialInput();
  rotateTowards();
  moveTowards();
  
  

  //stroke(100, 100, 200);
  //lights();
  spotLight(200, 150, 100, 0, cubeSize, -100, sin(rotY)*3, 0, -cos(rotY)*3, PI/2, 100);
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
      cubes[i][j].x = move.x+cubeSize*i;
      cubes[i][j].y = move.z+cubeSize*j;
      cubes[i][j].drawCube();
      popMatrix();
      
      translate(0, 0, cubeSize);
      //println(cubes[i][j].isAtOrigin());
      if(cubes[i][j].isAtOrigin())
      {
        elevation = 50-cubes[i][j].elevation;
      }
      //else elevation-=0.1;
      //println(elevation);
    }
    popMatrix();
    translate(cubeSize, 0, 0);
  } 
  popMatrix();
  
  //handleFalling(); //doesn't work
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
    box(cubeSize);
    if(hasTree) { tree.drawTree(); }
  }
  
  boolean isAtOrigin()
  {
    if(x >= 0 && x <= cubeSize && y >= 0 && y <= cubeSize)
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
      translate(0, -cubeSize, 0);
      box(cubeSize);
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
      cubes[i][j].elevation = int(map(noise(xOff, yOff), 0, 1, 0, 10))*cubeSize;
      //elevation[i][j] = int(random(-2, 2))*cubeSize;
      //println("elevation["+i+"]"+"["+j+"]"+" = "+cubes[i][j].elevation);               
      yOff += 0.1;
    }
    xOff += 0.1;
  }
  //println("elevation calculated");
}

void handleFalling()
{
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
