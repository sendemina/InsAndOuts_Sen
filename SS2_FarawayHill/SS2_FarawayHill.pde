/* Faraway Hill by Sen Demina

Instuctions:
- mouse click => clear the sky
- press any key => shift the hue
- press the up key => start a sky rave (also happens if you shift the hue too much)

The calm hill is now more colorful.
*/

boolean originalSky = true;
boolean skyRave = false;
int limitOfTints = (int) random(0, 10);
int currentNumOfTints = 0;
float redTint = random(100, 255), 
      blueTint = random(100, 255), 
      greenTint = random(100, 255);

void setup()
{
  size(1080, 720);
  background(210, 240, 250);  
}

void draw()
{
  //println(frameRate);
  noStroke();
  
  if (originalSky)
  {  
    background(210, 240, 250);
    
    //clouds
    fill(250, 250, 255);
    ellipse(300 - frameCount/15, 200, 200, 200);
    ellipse(500 - frameCount/15, 300, 400, 400);
    ellipse(300 - frameCount/15, 500, 300, 300);
    ellipse(800 - frameCount/15, 500, 500, 500);
    triangle(500, 300, 540, 340, -20, 50);  
    
    //smoke
    stroke(250, 250, 255);
    noFill();
    strokeWeight(5);
    ellipse(800, 250 - frameCount/5 + 200, 30, 30);
    strokeWeight(7);
    ellipse(780, 200 - frameCount/5 + 200, 40, 40);
    strokeWeight(10);
    ellipse(810, 150 - frameCount/5 + 200, 50, 50);
    strokeWeight(15);
    ellipse(750, 100 - frameCount/5 + 200, 80, 80);
  }
  else if (skyRave)
  {
    redTint = random(100, 255); 
    blueTint = random(100, 255);
    greenTint = random(100, 255);  
    fill(redTint, blueTint, greenTint, 30);
    rect(0, 0, width, height);
  }
  else
  {
    paintClouds();
  }
  

  
  noStroke();
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
  
  println(mouseX, mouseY);
}

void mouseClicked()
{
  background(210, 240, 250);
  originalSky = false;
}

void keyPressed()
{
  redTint = random(0, 255); 
  blueTint = random(0, 255);
  greenTint = random(0, 255);  
  fill(redTint, blueTint, greenTint, 50);
  rect(0, 0, width, height);
  
  currentNumOfTints++;
  if(keyCode == UP || currentNumOfTints >= limitOfTints)
  {
    skyRave = true;
  }
}

void paintClouds()
{
  stroke(250, 250, 255);
  float mouseSpeed = abs(mouseX - pmouseX);
  strokeWeight(mouseSpeed);
  line(pmouseX, pmouseY, mouseX, mouseY);
}
