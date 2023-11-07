import processing.serial.*; //imports Serial library from Processing

Serial myPort; // creates object from Serial class
int val=0; // creates variable for data coming from serial port
float cloudX;

void setup()
{
  size(1080, 720);
  noStroke();

  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[3]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  if ( myPort.available() > 0) 
  {                      // If data is available,
    val = myPort.read(); // read it and store it in val
  }
  println(val);
  
  background(210, 240, 250);
  
  cloudX = map(val, 0, 255, -200, 300);

  //clouds
  fill(250, 250, 255);
  ellipse(300+cloudX, 200, 200, 200);
  ellipse(500+cloudX, 300, 400, 400);
  ellipse(300+cloudX, 500, 300, 300);
  ellipse(800+cloudX, 500, 500, 500);
  triangle(500+cloudX, 300, 540+cloudX, 340, -20+cloudX, 50);
  
  
  //==============   HOUSE   ===============
  //house
  //lit
  fill(250, 240, 200);
  triangle(700, 300, 600, 500, 800, 500);
  //in shadow
  fill(150, 150, 190);
  quad(700, 300, 600, 500, 620, 500, 720, 300);
  
  //door
  fill(110, 150, 150);
  strokeWeight(10);
  stroke(190, 120, 120);
  ellipse(710, 390, 30, 50);
  
  //roof
  //lit
  stroke(230, 100, 100);
  strokeWeight(10);
  line(700, 300, 600, 500);
  line(700, 300, 800, 500);
  //in shadow
  fill(150, 70, 100);
  quad(700, 300, 900, 300, 970, 400, 750, 400);
  noStroke();
  
  //chimney
  //in shadow
  fill(150, 150, 190);
  rect(790, 280, 20, 50);
  //lit
  fill(250, 240, 200);
  rect(790, 280, 15, 20);
  stroke(190, 120, 120);
  line(785, 280, 810, 280);
  
  //smoke
  stroke(250, 250, 255);
  noFill();
  strokeWeight(5);
  ellipse(800, 250, 30, 30);
  strokeWeight(7);
  ellipse(780, 200, 40, 40);
  strokeWeight(10);
  ellipse(810, 150, 50, 50);
  strokeWeight(15);
  ellipse(750, 100, 80, 80);
  noStroke();
  
  //=============    HILLS    =================
  //back hill 
  fill(180, 220, 150);
  triangle(0, 500, width, 350, width, height);
  
  //tree shadow
  fill(50, 120, 150);
  triangle(900, 500, 950, 480, 1200, 550);
  
  //tree trunk
  //in shadow
  fill(120, 90, 120);
  triangle (900, 500, 950, 480, 970, 200);
  //lit
  fill(200, 150, 50);
  triangle (900, 500, 930, 480, 970, 200);
  
  //tree crown
  //in shadow
  fill(50, 120, 150);
  ellipse(950, 200, 200, 200);
  ellipse(975, 300, 200, 100);
  //lit
  fill(180, 220, 150);
  ellipse(930, 180, 200, 200);
  ellipse(955, 280, 200, 100);
  
  //apples
  fill(230, 100, 100);
  ellipse(900, 200, 30, 30);
  ellipse(960, 250, 30, 30);
  ellipse(970, 180, 30, 30);
  
  //front hill
  fill(50, 120, 150);
  triangle(0, 400, 0, height, width, height);
  
  
  ////frame
  //strokeWeight(50);
  //stroke(250, 230, 200);
  //noFill();
  //rect(0, 0, width, height);
  
  
  
  //if(val < 100)
  //{
  //  fill(map(val, 0, 100, 150, 255), map(val, 0, 100, 50, 200), map(val, 0, 100, 50, 150), 80);
  //  rect(0, 0, width, height);
  //}
  
  for (int i = 0; i < width; i+=10)
  {
    for (int j = 0; j < height; j+=10)
    {
      if(red(get(i, j)) > 220)
      {
        fill(map(val, 0, 100, 150, 250), map(val, 0, 100, 150, 250), map(val, 0, 100, 100, 250));
        circle(i, j, 10);
      }
      else if (blue(get(i, j)) > 200)
      {
        fill(map(val, 0, 100, 150, 200), map(val, 0, 100, 100, 200), map(val, 0, 100, 200, 250));
        circle(i, j, 10);
      }
      else if (red(get(i, j)) < 100)
      {
        fill(map(val, 0, 100, 50, 100), map(val, 0, 100, 50, 100), map(val, 0, 100, 50, 150));
        circle(i, j, 10);
      }
      else if (green(get(i, j)) > 100)
      {
        fill(map(val, 0, 100, 150, 255), map(val, 0, 100, 50, 200), map(val, 0, 100, 50, 150));
        circle(i, j, 10);
      }
    }
  }
  
  
  //if (val>80 && val<90)
  //{
  //  fill(100, 50, 60);
  //  circle(width/2, height/2, (90-val)*5);
  //}
  
  if (val<50) 
  { 
    text("evening", width/2, 20); 
  }
}
