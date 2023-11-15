import processing.serial.*; 

Serial myPort; 
int val = 0; 
Paddle left, right;
int padding = 10;
int padW = 20; 
int padH = 100;
int leftDir, rightDir;
float speed = 1;

void setup()
{
  size(800, 600);

  printArray(Serial.list()); 
  //String portName = Serial.list()[5];   
  String portName = Serial.list()[0]; 
  myPort = new Serial(this, portName, 9600);
  
  left = new Paddle(padding, height/2, padW, padH);
  right = new Paddle(width-padW-padding, height/2, padW, padH);

}

void draw()
{
  background(10);
  fill(200);
  noStroke();
  
  if ( myPort.available() > 0) 
  {                     
    val = myPort.read();
    //HANDLE LEFT PADDLE INPUT
    if(val < 2) { leftDir = val; }    
    //HANDLE SPEED INPUT
    else if (val<100) { speed = val/2; }
    //HANDLE RIGHT PADDLE INPUT
    else if(val < 200) { rightDir = 0; }
    else { rightDir = 1; }

    println(val);
  }
    left.moveDigital(leftDir);
    left.checkBorders();
    left.display();
    
    right.moveDigital(rightDir);
    right.checkBorders();
    right.display();
}

class Paddle
{
  float x, y, w, h;
  
  Paddle(float _x, float _y, float _w, float _h)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  void moveDigital(int dir)
  {
    if(dir < 1)
    {
      //println("down");
      y += speed;
      //println(y);
    }
    else 
    { 
      //println("up");
      y -= speed; 
      //println(y);
    }
  }
  
  void checkBorders()
  {
    if (y <= 0) { y = 0; }
    else if (y+h >= height) { y = height - h; } 
  }
  
  void display()
  {
    rect(x, y, w, h);
  }
  
  void shangeSpeed(float newSpeed)
  {
    speed = newSpeed;
  }
  
  void shoot()
  {
    //make projectile class, determine direction
  }

}

class Ball
{
  float x, y;
  int size = 20;
  int dirX;
  
  Ball(float _x, float _y)
  {
    x = _x;
    y = _y;
  }
  
  void moveBall()
  {
    x += speed * dirX;
  }
  
  void checkCollision()
  {
    if((x - size <= left.x + padW) && (y <= left.y && y <= left.y+padH))
    {
      dirX *= -1;
      
    }
    
  }
  
  void displayBall()
  {
    circle(x, y, size);
  }
}


  


 
