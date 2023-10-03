/* Faraway Hill by Sen Demina

Instuctions:
- click on the paint brush => new sky canvas
- click on the paint bucket => shift the hue
- click on the arrow => return to the original sky
- click on the door => it will open

*/

boolean originalSky = true;
boolean openDoor = false;
float redTint = random(100, 255), 
      blueTint = random(100, 255), 
      greenTint = random(100, 255);
      
PImage apple;
PImage hills;
PImage house;
PImage granny;

PImage brush;
PImage bucket;
PImage arrow;

PFont font;

int timeOfOpenedDoor;
float grannyPos = 660;

SmokePuff[] smokePuffs = new SmokePuff[20];


void setup()
{
  size(1080, 720);
  
  apple = loadImage("apple.png");
  hills = loadImage("hills.png");  
  house = loadImage("house.png"); 
  granny = loadImage("granny.png");
  
  brush = loadImage("brush.png"); 
  bucket = loadImage("bucket.png"); 
  arrow = loadImage("arrow.png");
  
  font = createFont("lemon.ttf", 32);
  textFont(font);
  
  for (int i = 0; i < smokePuffs.length - 1; i++)
  {
    smokePuffs[i] = new SmokePuff(800, 280 + i*20);
  }
}

void draw()
{
  //println(frameRate);
  println(mouseX, mouseY);
  //println(millis());
  //println(timeOfOpenedDoor);
  
  noStroke();
  
  if (originalSky)
  {  
    background(255);
    fill(210, 240, 250, 80);
    noStroke();
    gradientSky();
    
    // SUN 
    for (int i = 1; i <= width/2; i+= 50) 
    {     
      fill(250, 50);
      ellipse(70, 50, i, i);
    }
    
    //clouds
    fill(250, 250, 255);
    ellipse(300 - frameCount/15, 200, 200, 200);
    ellipse(500 - frameCount/15, 300, 400, 400);
    ellipse(300 - frameCount/15, 500, 300, 300);
    ellipse(800 - frameCount/15, 500, 500, 500);
    
    //smoke
    for (int i = 0; i < smokePuffs.length - 1; i++)
    {
      smokePuffs[i].drawSmokePuff();
    }
  }
  else
  {
    paintClouds();
  }
  

  // HOUSE   
  image(house, 0, 0);
  drawDoor();

  // HILLS
  image(hills, 0, 0);
  // apples
  image(apple, 880, 180, 100, 100);
  image(apple, 940, 220, 100, 100);
  image(apple, 950, 160, 100, 100);
  
  // UI
  image(brush, 0, height - 80, 80, 80);
  image(bucket, 80, height - 80, 80, 80);
  image(arrow, 160, height - 80, 80, 80);
}

class SmokePuff
{
  float xPos;
  float yPos;
  float size = 10;
  float tone = 50;
  
  SmokePuff(float _xPos, float _yPos)
  {
    xPos =_xPos;
    yPos = _yPos;
  }
  
  void drawSmokePuff()
  {
    if (yPos <= 0) yPos = 280;
    tone = 255 - yPos/3;
    size = (280 - yPos)/2;
    //println(xPos, yPos);
    fill(tone, tone - 10, tone - 20);
    if (frameCount % 5 == 0)
    {
      xPos = (int)random(750 + yPos/5, 850 - yPos/5);
      yPos -= 2;
    }
    circle(xPos, yPos, size);
  }
}

void mouseClicked()
{
  if(mouseX>700 && mouseX<750 && mouseY>390 && mouseY<450)
  {
    openDoor = true;
    drawDoor();
    grannyPos = 660;
    timeOfOpenedDoor = millis();
  }
  else if(mouseX>0 && mouseX<80 && 
          mouseY>height-80 && mouseY<height)
  {
    background(210, 240, 250);
    originalSky = false;
  }
  else if(mouseX>80 && mouseX<160 && 
          mouseY>height-80 && mouseY<height)
  {
    redTint = random(0, 255); 
    blueTint = random(0, 255);
    greenTint = random(0, 255);  
    fill(redTint, blueTint, greenTint, 50);
    gradientSky();
  }
  else if(mouseX>160 && mouseX<220 && 
          mouseY>height-80 && mouseY<height)
  {
    originalSky = true;
    openDoor = false;
  }
}


void gradientSky()
{
  noStroke();
  for (int i = 1; i <= 10; i++)
  {
    rect(0, 0, width, height/i);
  }
}


void paintClouds()
{
  stroke(250, 250, 255);
  float mouseSpeed = abs(mouseX - pmouseX);
  strokeWeight(mouseSpeed);
  line(pmouseX, pmouseY, mouseX, mouseY);
}


void drawDoor()
{ 
  if(openDoor)
  {
    noStroke();
    fill(100, 100, 150);
    ellipse(710, 390, 30, 50);
    fill(110, 150, 150);
    strokeWeight(10);
    stroke(230, 130, 60);
    ellipse(690, 390, 10, 50);
    noStroke();
    fill(150, 70, 50);
    ellipse(695, 390, 10, 50);

    //Character
    if (grannyPos >= 580)
    {
      grannyPos -= 0.5;
    }
    image(granny, grannyPos, 350, 100, 100);
    fill(150, 70, 50);
    textSize(22);
    if(millis() - timeOfOpenedDoor > 3000)
    {
      text("Oh! The apples have ripened!", 420, 350, 200, 100);
    }  
  }
  else
  {
    fill(110, 150, 150);
    strokeWeight(10);
    stroke(230, 130, 60);
    ellipse(710, 390, 30, 50);
  }
}
