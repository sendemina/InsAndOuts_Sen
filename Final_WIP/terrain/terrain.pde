int X = 100;
int Y = 100;
int size = 20;

int elevation[][] = new int[X][Y]; 
float xOff, yOff;
float time;

float rotX;
float rotY;
float walk;
float speed = 10;
float rotSpeed = 0.05;

float oX, oY, oZ;

float camX, camY, camZ;

void setup()
{
  size(1000, 600, P3D);
  calculateElevation();
  camX = width/2;
  camY = height/2;
  camZ = 475;
}

void draw()
{
  background(130, 200, 250);
  fill(200, 100, 100);  

  box(50);

  translate(camX, camY, camZ);
 
  translate(0, 0, walk);
  rotateX(rotX);
  rotateY(rotY);
  pushMatrix();

  fill(200, 100, 100);
  stroke(10);
  sphere(10);
  popMatrix();



  pushMatrix();
  //translate(0, 0, -1000);
  drawSky();
  //calculateElevation();
  if(keyPressed)
  {
    if(keyCode==UP) { rotX +=rotSpeed; }
    else if(keyCode==DOWN) { rotX-=rotSpeed; }
    
    if (keyCode==LEFT) { rotY-=rotSpeed; }
    else if(keyCode==RIGHT) { rotY+=rotSpeed; }
    
    if(keyCode==SHIFT) { walk+=speed; }
    else if(keyCode==ALT) { walk-=speed; }
  }
  popMatrix();
  //println(frameRate);
  println(speed);
  
  drawTerrain();
  

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
      elevation[i][j] = int(map(noise(xOff, yOff), 0, 1, -40, 40))*size;
      
      
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
  rotateX(PI/2);
  //translate(-width/2, -height/2, -width/2);
 
  lights();  
  fill(100, 150, 200);
  rect(0, 0, X*size, Y*size);
  fill(150, 180, 130);
  noStroke();
  //stroke(50);

  for(int i = 0; i < Y; i++)
  {
    pushMatrix();
    for(int j = 0; j < X; j++)
    {    
      if(elevation[j][i] >= 0)
      {
      pushMatrix();
      
//was 0
      translate(0, 0, elevation[j][i]);

      box(size);
      pushMatrix();
       
        for(int k = 0; k < 3; k++)
        {
//was 0        
          translate(0, 0, -size);
          box(size);
        }
      
      popMatrix();

      popMatrix();
      }
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

//void mousePressed()
//{
//  translate(100, 0, 0);
  
  
//}



void checkFill(int i, int j)
{
      if(i > 0 && i < Y-1 && j > 0 && j < X-1)
      {
        //check every side, save the largest difference
        int depth = 0;
        int[] sides = new int[4];

        sides[0] = elevation[j][i]-elevation[j-1][i];
        sides[1] = elevation[j][i]-elevation[j+1][i];
        sides[2] = elevation[j][i]-elevation[j][i-1];
        sides[3] = elevation[j][i]-elevation[j][i+1];
        println(elevation[j][i]-elevation[j][i-1]);
        
        for(int q = 1; q < sides.length; q++)
        {
          if(sides[q] > sides[q-1])
          {
            depth = int(sides[q]/size);
          }
        }
        
        //if(elevation[j][i]-elevation[j+1][i] > size) 
        //{ 
        //  xr
        //  depth = int(elevation[j][i]-elevation[j+1][i] / size);
        //}
        //else if(elevation[j][i]-elevation[j][i+1] > size)
        //{
        //  depth = int(elevation[j][i]-elevation[j][i+1] / size);
        //}
        //else if(elevation[j][i]-elevation[j-1][i] > size)
        //{
        //  depth = int(elevation[j][i]-elevation[j-1][i] / size);
        //}
        //else if(elevation[j][i]-elevation[j][i-1] > size)
        //{
        //  depth = int(elevation[j][i]-elevation[j][i-1] / size);
        //}
          //println(elevation[j][i]-elevation[j+1][i]);
          pushMatrix();
          for(int k = 0; k < depth; k++)
          {
            translate(0, 0, -size);
            box(size);
          }
          popMatrix();
        
      }
}
