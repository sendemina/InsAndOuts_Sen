int X = 100;
int Y = 60;
int size = 20;

int elevation[][] = new int[X][Y]; 
float xOff, yOff;
float time;

void setup()
{
  size(1000, 600, P3D);
}

void draw()
{
  background(130, 200, 250);
  pushMatrix();
  translate(0, 0, -1000);
  drawSky();
  calculateElevation();
  drawTerrain();
  popMatrix();
  println(frameRate);
}

void calculateElevation()
{
  time -= 0.01;
  xOff = 0; 
  for(int i = 0; i < X; i++)
  {
    yOff = time;
    for (int j = 0; j < Y; j++)
    {
      elevation[i][j] = int(map(noise(xOff, yOff), 0, 1, -20, 20))*size;
      //elevation[i][j] = int(random(-2, 2))*size;
      //println("elevation["+i+"]"+"["+j+"]"+" = "+elevation[i][j]);               
      yOff += 0.01;
    }
    xOff += 0.01;
  }
  //println("elevation calculated");
}

void drawTerrain()
{
  pushMatrix();
  translate(width/X-500, height/2);
  rotateX(PI/2.5);
 
  lights();  
  fill(150, 180, 130);
  stroke(50);
  
  for(int i = 0; i < Y; i++)
  {
    pushMatrix();
    for(int j = 0; j < X; j++)
    {      
      pushMatrix();
      translate(0, 0, elevation[j][i]);
      box(size);
      popMatrix();
      translate(size, 0, 0);
    }
    popMatrix();
    translate(0, size, 0);
  }
  //sphere(size);
  popMatrix();
}

void drawSky()
{  
  for(int i = height; i > 0; i-=5)
  {
    noStroke();
    fill(250, 20);
    rect(-width, i, width*4, i);
  }
}
