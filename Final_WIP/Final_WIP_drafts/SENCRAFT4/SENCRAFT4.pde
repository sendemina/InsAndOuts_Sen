import processing.sound.*;
import processing.serial.*;
import java.util.ArrayList;

Serial myPort; 
int val = 0;

enum inputState { Xa, Ya, Za, Sel, Vert, Horz };
inputState currentInput;
 
int valX, valY, valZ, valS, valV, valH;

//float nextRotX, nextRotY;
int rotToX, rotToY;
float rotX, rotY;

PVector move;
//PVector moveTo;
int moveToX, moveToY;

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
  //moveTo = new PVector(0, 0, 0);
  
  for(int i = 0; i < X; i++)
  {
    for(int j = 0; j < Y; j++)
    {
      cubes[i][j] = new Cube(i, j, 0);
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
  //println(currentInput);
  switch(currentInput)
  {
    case Xa:
      valX = val;
      if(valX > 135) { rotToY = 1; }
      else if(valX < 127) { rotToY = -1; }
      else { rotToY = 0; }
      
      //nextRotY = -(PI/3+valX/255.0*2*PI);
      //if(nextRotY - rotY > 0) { rotToPosY = true; }
      //else { rotToPosY = false; }
      //rotY = -(PI/3+valX/255.0*2*PI);
      break;
    case Ya:
      valY = val;
      if(valY > 135) { rotToX = 1; }
      else if(valY < 127) { rotToX = -1; }
      else { rotToX = 0; }
      println(valY);
      //nextRotX = -(PI/2-valY/255.0*PI);
      //if(nextRotX - rotX > 0) { rotToPosX = true; }
      //else { rotToPosX = false; }
      //rotX = PI/2-valY/360.0*PI;
      break;
    case Za:
      valZ = val;
      break;
    case Sel: 
      println("sel=" + val);
      break;
    case Vert:
      if(val == 127) { moveToY = 0; }
      else if(val > 127) { moveToY = 1; }
      else { moveToY = -1; }
      break;
    case Horz:
      if(val == 127) { moveToX = 0; }
      else if(val > 127) { moveToX = 1; }
      else { moveToX = -1; }
      break;
    default:
      println("state error");
  }
  
  println("x="+valX+" y="+valY+" z="+valZ);
  //println("x="+rotX+" y="+rotY+" z="+valZ);
  //println("vert="+move.y+" horz="+move.x+" sel=");
}

void rotateTowards()
{
  rotY += incr*rotToY;
  rotX += incr*rotToX;
  if(rotX>PI/2) { rotX = PI/2; }
  else if(rotX<-PI/2) { rotX = -PI/2; }
  //if(abs(nextRotY - rotY) > incr)
  //{
  //  if(rotToPosY) { rotY += incr; }
  //  else { rotY -= incr; }
  //}
  
  //if(abs(nextRotX - rotX) > incr)
  //{
  //  if(rotToPosX) { rotX += incr; }
  //  else { rotX -= incr; }
  //}
}

void moveTowards()
{
  //println("move to x: " + moveToX + " move to y: " + moveToY);
  move.add(new PVector(-sin(rotY)*walkSpeed*moveToY, 0, cos(rotY)*walkSpeed*moveToY));
  move.add(new PVector(-sin(rotY-PI/2)*walkSpeed*moveToX, 0, cos(rotY-PI/2)*walkSpeed*moveToX));
}

void keyboardControls()
{
  rotX = -mouseY*PI/200;
  rotY = mouseX*PI/200;
  
  if(keyPressed)
  {
    if(key == 'w') { move.add(new PVector(-sin(rotY)*walkSpeed, 0, cos(rotY)*walkSpeed)); }
    if(key == 's') {  move.add(new PVector(sin(rotY)*walkSpeed, 0, -cos(rotY)*walkSpeed)); }
    if(key == 'a') { move.add(new PVector(-sin(rotY-PI/2)*walkSpeed, 0, cos(rotY-PI/2)*walkSpeed)); }
    if(key == 'd') { move.add(new PVector(-sin(rotY+PI/2)*walkSpeed, 0, cos(rotY+PI/2)*walkSpeed)); }
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
      cubes[i][j].x_pos = move.x+cubeSize*i;
      cubes[i][j].y_pos = move.z+cubeSize*j;
      cubes[i][j].drawCube();
      popMatrix();
      
      translate(0, 0, cubeSize);
      //println(cubes[i][j].isAtOrigin());
      if(cubes[i][j].isAtOrigin())
      {
        elevation = 50-cubes[i][j].elevation;
        ArrayList treesNearby = cubes[i][j].cubesHaveTrees();
        for(int k = 0; k < treesNearby.size(); k++)
        {
          Cube cube = (Cube)treesNearby.get(k);
          println(cube.x);
          // when moving, check if tree in that direction
        }
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
  int x, y;
  float x_pos, y_pos;
  int elevation;
  boolean hasTree;
  Tree tree;
  
  Cube(int _x, int _y, int _elevation)
  {
    x = _x;
    y = _y;
    x_pos = x*cubeSize;
    y_pos = y*cubeSize;
    
    elevation = _elevation;
    if(int(random(30))==0) { hasTree = true; }
    if(hasTree)
    {
      println("cube["+x+"]["+y+"] has tree");
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
    if(x_pos >= 0 && x_pos <= cubeSize && y_pos >= 0 && y_pos <= cubeSize)
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
  
  ArrayList<Cube> cubesHaveTrees()
  {
    ArrayList<Cube> cubesWithTrees = new ArrayList<Cube>();
    if(x > 0 && x < X && y > 0 && y < Y)
    {
      for(int i = -1; i < 2; i++)
      {
        for(int j = -1; j < 2; j++)
        {
          int xpos = x+i;
          int ypos = y+j;
          if(cubes[xpos][ypos].hasTree) 
          { 
            cubesWithTrees.add(cubes[xpos][ypos]);
            //println("tree near at " + xpos + " " + ypos);
          }
        }
      }
    }
    return cubesWithTrees;
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
