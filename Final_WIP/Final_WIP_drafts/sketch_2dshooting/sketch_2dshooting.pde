float rot;
int size = 10;

PVector move;
Bullet bullet;
float bulletX, bulletY;
//float shootAngle;

int tankNum;
Tank[] tanks;

void setup()
{
  size(600, 600, P3D);
  move = new PVector(0, 0);
  bullet = new Bullet();
  
  tankNum = int(random(1, 10));
  tanks = new Tank[tankNum];
  for(int i = 0; i < tankNum; i++)
  {
    tanks[i] = new Tank(random(0, width), random(0, height));
  }
}

void draw()
{
  background(200);
  //line(width/2, 0, width/2, height/2);
  noFill();
  stroke(1);
  strokeWeight(1);
  translate(width/2, height/2); 
  circle(0, 0, 100);
  rotate(rot);
  println(cos(rot));
  line(0, 0,  sin(rot)*100, cos(rot)*100);
  //line(0, 0,  sin(rot)*100), sin(rot)*100,;
  
  move.x += bulletX;
  move.y -= bulletY;
  //move.x += -sin(shootAngle)*2;
  //move.y -= -cos(shootAngle)*2;
  
  circle(0, 0, 50);
  
  stroke(200, 100, 100);
  strokeWeight(5);
  line(-width, 0, width, 0);
  line(0, -height, 0, height);
  
  //if(mousePressed)
  //{
  //  if(mouseX - pmouseX > 0) { rot+=PI/36; }
  //  else if (mouseX - pmouseX < 0) { rot-=PI/36; }
  //}
  if(keyPressed)
  {
    //if(keyCode==UP) { move.add(new PVector(sin(rot)*2, cos(rot)*2)); }
    //else if(keyCode==DOWN) { move.add(new PVector(-sin(rot)*2, -cos(rot)*2)); }
    if (keyCode==LEFT) { rot+=PI/36;; }
    else if(keyCode==RIGHT) { rot-=PI/36; }
    
    if(keyCode==SHIFT) { bullet.shoot(); }
    
    //else if (keyCode==LEFT) { move.add(new PVector(sin(rot)*2, cos(rot)*2)); }
    //else if(keyCode==RIGHT) { move.add(new PVector(1, 0)); }
  }
  
  stroke(100, 100, 200);
  fill(250);
  strokeWeight(5);
  
  pushMatrix();
  translate(move.x, move.y);
  bullet.update();
  bullet.display();
  popMatrix();
  
  //for(int i = 0; i < 10; i++)
  //{
  //  translate(0, size);
  //  rect(0, 0, size, size);
  //}
  for(int i = 0; i < tankNum; i++)
  {
    pushMatrix();
    translate(tanks[i].x, tanks[i].y);
    tanks[i].drawTank();
    popMatrix();
  }
}

class Bullet
{
  float x, y;
  
  void shoot()
  {
    x = 0;
    y = 0;
    bulletX = sin(rot)*2;
    bulletY = cos(rot)*2;
    //shootAngle = rot;
  }
  
  void update()
  {
    x+=move.x;
    y+=move.y;
  }
  
  void display()
  {
    circle(0, 0, size);
  }
}

class Tank
{
  float x, y;
  
  Tank(float _x, float _y)
  {
    x = _x;
    y = _y;
  }
  
  void drawTank()
  {
    circle(0,0,size);
  }
}
