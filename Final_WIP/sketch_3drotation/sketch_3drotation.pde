import processing.sound.*;

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
}

void draw()
{
  background(100, 150, 200);
  noFill();
  stroke(1);
  strokeWeight(1);
  translate(width/2, height/2+size, 500);  
  //rotateX(rotX);
  rotateY(rotY);
  //sphere(20);
  
  pushMatrix();
  //stroke(200, 100, 100);
  //strokeWeight(10);
  //line(-width, 0, width, 0);
  //line(0, -height, 0, height);

  //if(mousePressed)
  //{
  //  if(mouseX - pmouseX > 0) { rotX+=PI/36; }
  //  else if (mouseX - pmouseX < 0) { rotX-=PI/36; }
  //  if(mouseY - pmouseY > 0) { rotY-=PI/36; }
  //  else if (mouseY - pmouseY < 0) { rotY+=PI/36; }
  //}
  
  if(keyPressed)
  {
    //
    if(keyCode==UP) { move.add(new PVector(-sin(rotY)*3, 0, cos(rotY)*3)); }
    if(keyCode==DOWN) {  move.add(new PVector(sin(rotY)*3, 0, -cos(rotY)*3)); }
    if (keyCode==LEFT) { rotY-=PI/36; }
    if(keyCode==RIGHT) { rotY+=PI/36; }
    //if(keyCode==SHIFT) { elevation += size*1.5; }
  }
  
  //move.x -= sin(rotX)*2;
  //move.x -= sin(rotX)*2;
  //move.z -= sin(rotY)*2;
  //move.z -= sin(rotY)*2;
  
  //move.normalize();
  //move.add(PVector.fromAngle(rotX));
  //println(degrees(rotY));
  //

  //line(0, 0, 0, PVector.fromAngle(rotX).x*100);
  //println(degrees(rotX));
  //move.x *= cos(90-degrees(rotX));
  //move.y *= cos(90-degrees(rotY));
  //move.mult(10);
  //move.add(PVector.fromAngle(rotY).normalize());

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
