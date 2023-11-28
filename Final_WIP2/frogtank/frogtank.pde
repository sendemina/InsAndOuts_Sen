
PShape frogtank;
PShape frogbullet;
float rotX, rotY;
PVector move,bulletmove;
int size = 50;
int X = 50;
int Y = 50;
Cube[][] cubes = new Cube[X][Y];

float shotangle;
PImage img;

float elevation;
float xOff, yOff;
Gun gun;
//SoundFile sencraft; 

void setup()
{
  size(1000, 600, P3D);
  frogtank = loadShape("frogtank.obj");
  frogbullet = loadShape("frogbullet.obj");
  img = loadImage("char1.jpg");
  frogtank.rotateX(PI);
  frogbullet.rotateX(PI);
  //frogtank.texture(img);
  //frogtank.setSpecular(0xff0000ff);
  lightSpecular(128, 128, 128);
  frogtank.setFill(color(100, 200, 100));
  frogbullet.setFill(color(200, 100, 100));
  gun = new Gun();
  move = new PVector(0, 0, 0);
  bulletmove = new PVector(0,0,0);
  for(int i = 0; i < X; i++)
  {
    for(int j = 0; j < Y; j++)
    {
      cubes[i][j] = new Cube(i*size, j*size, 0);
    }
  }
  calculateElevation();
  shapeMode(CENTER); 
  //sencraft = new SoundFile(this, "sencraft_draft.mp3"); 
  //sencraft.amp(0.1);
  //sencraft.loop();
}

void draw()
{
  background(150, 200, 250);
  noFill();
  stroke(1);
  strokeWeight(1);
  translate(width/2, height/2, 500);  
  //rotateX(rotX);
  
  
  rotateY(rotY);
  pushMatrix();
  rotateY(-rotY);
  translate(0,0,-50);
  line(0,0,0,0,height,0);
  line(sin(rotY)*width,0,-sin(rotY)*width,0);
  popMatrix();
  //sphere(20);
 
  
  
  pushMatrix();
  //translate(bulletmove.x,0,bulletmove.y);
  
 gun.update();
  //// Horizonal light.
  spotLight(0, 127, 255, -size, -sin(rotY) * size, 0,1, 0, 0, PI/2, 25);
  //  //println(frameCount);
  //// Vertical light.
  spotLight(0, 255, 127, -cos(rotY) * size, size, 0, 0, 1, 0, PI, 25);

  //// Flash light.
  //spotLight(191, 170, 133, 0, 0, size, mouseX, mouseY, -100, 100, 100);
  if(keyPressed)
  {
    if(keyCode== SHIFT){gun.bullet();};
    if(keyCode==UP) { move.add(new PVector(-sin(rotY)*3, 0, cos(rotY)*3)); }
    
    if(keyCode==DOWN) {  move.add(new PVector(sin(rotY)*3, 0, -cos(rotY)*3)); }
    if (keyCode==LEFT) { rotY-=PI/100; }
    if(keyCode==RIGHT) { rotY+=PI/100; }
  }
  
  
  //stroke(100, 100, 200);
  //lights();
  //spotLight(200, 150, 100, 0, size, 0, sin(rotY)*3, 0, -cos(rotY)*3, PI/2, 100);
  ambientLight(100, 100, 200);
  noStroke();
  strokeWeight(5);
  //println(elevation);
  translate(0, 0, 0);

  //elevation = 0;
  for(int i = 0; i < X; i++)
  {
    
    pushMatrix();
    for(int j = 0; j < Y; j++)
    {
      pushMatrix();
      translate(-size*X/2, 100, -size*Y/2);
      //cubes[i][j].drawCube();
      //cubes[i][j].x = move.x+size*i;
      //cubes[i][j].y = move.z+size*j;
      cubes[i][j].drawCube();
      popMatrix();
      
      translate(0, 0, size);
      
      if(cubes[i][j].isAtOrigin())
      {
        elevation = 50-cubes[i][j].elevation+size;
      }
      
      //else elevation-=0.1;
      //println(elevation);
    }
    
    popMatrix();
    translate(size, 0, 0);
  } 
  popMatrix();
  
  
  
  //gun.bullX = bulletmove.x;
  //gun.bullY = bulletmove.y;
  
  
  
  if(elevation < -2000)
  {
    textSize(50);
    textMode(CENTER);
    background(200, 100, 100);
    stroke(1);
    strokeWeight(5);
    text("YOU FOOL", 0, 0, 50, 50);
    circle(0, 0, 50);
    //println("ded");
  }
  frogtank.rotateY(PI/36);
  frogbullet.rotateY(PI/2);
}

class Cube
{
  float x, y;
  int elevation;
  boolean hasTank;
  boolean hasCacti;
  Tank tank;
  Cacti cacti;
  
  Cube(float _x, float _y, int _elevation)
  {
    x = _x;
    y = _y;
    elevation = _elevation;
    if(int(random(500))==0) { hasTank = true;}
    if(int(random(1000)) == 0 && hasTank == false)
    {
      hasCacti = true;
    }
    if(hasCacti){
      cacti = new Cacti(this,int(random(2,5)));
    }
    if(hasTank)
    {
      tank = new Tank(this, 3);
    }
  }
  
  void drawCube()
  {
    fill(200, 200, 100);
    box(size);
    if(hasTank) { tank.drawTank(); }
    if(hasCacti){ cacti.drawCacti();}
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
class Gun{
  //boolean shot = false;
  float bullX;
  float bullY;
  float bullZ;
  Gun(){}
  void bullet(){
    bulletmove.x=0;
    bulletmove.z=0;
    shotangle = rotY;
    
    
    
  }
  void shoot(){
    
    
  }
  void update(){
    
    pushMatrix();
    bullX = bulletmove.x;
    bullZ = bulletmove.z;
    //rotateY(-rotY);
    translate(bulletmove.x+size,size,bulletmove.z);
    shape(frogbullet);
    //sphere(20);
    
    bulletmove.add(new PVector(sin(shotangle)*10, 0, -cos(shotangle)*10));
    //bulletmove.add(new PVector(0, 0, 0));
    popMatrix();
    
    
  }
    
  
}
class Tank
{
  Cube cube;
  int tall;
  boolean alive;
  
  Tank(Cube _cube, int _tall)
  {
    cube = _cube;
    tall = _tall;
    //println("made tree");
  }
  
  void drawTank()
  {
    fill(255, 50, 50);
    pushMatrix();
    
      translate(0, size/2, 0);
      //box(size);
      shape(frogtank);
    
    //fill(100, 200, 100);
    //sphere(150);
    popMatrix();
  }
}
class Cacti
{
  Cube cube;
  int tall;
  float x, z;
  boolean hit = false;
  Cacti(Cube _cube, int _tall)
  {
   
    cube = _cube;
    x = cube.x;
    z = cube.y;
    tall = _tall;
    //println("made cacti");
  }
  
  void drawCacti()
  {
    if(isHit() == false && hit == false){
      fill(50, 200, 50);
      pushMatrix();
      for(int i = 0; i < tall; i++){
        translate(0, -size, 0);
        box(size);
       
      }
     
      popMatrix();
    }
    else{
      hit = true;
    }
    
    
  }
  
  boolean isHit()
  {
    if(x >= gun.bullX-100 && x <= gun.bullX+100 && z >= gun.bullZ-100 && z <= gun.bullZ+100)
    {
      //println("ded cacti");
      return true;
    }
    else 
    { 
      //println(gun.bullX + " " + x);
      //println( gun.bullZ + " " + z);
       //println("ALIVE");
      return false; 
    }
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
      cubes[i][j].elevation = int(map(noise(xOff, yOff), 0, 1, 0, 5))*size;
      //elevation[i][j] = int(random(-2, 2))*size;
      //println("elevation["+i+"]"+"["+j+"]"+" = "+cubes[i][j].elevation);               
      yOff += 0.1;
    }
    xOff += 0.1;
  }
  //println("elevation calculated");
}
