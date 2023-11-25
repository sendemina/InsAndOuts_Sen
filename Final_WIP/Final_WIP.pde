int size = 10;
float zOffs = 0; 
float zOffm = 100; 
float time = 0;

float[][] elevation;

//procedural terrain
//procedural clouds
//water? (to animate - recalculate noise)


void setup()
{
  size(600, 600, P3D); 
  elevation = new float[width/2][height/2]; 
}

void draw()
{
  background(130, 200, 250);
  //for(int i = height; i > 100; i-=5)
  //{
  //  noStroke();
  //  fill(250, 20);
  //  rect(0, i, width, i);
  //}
  
  lights();
  stroke(150, 180, 130);
  noStroke();
  strokeWeight(2);
  //noFill();
  fill(150, 180, 130);
  
  calculateTerrain();
  drawTerrain();
  println(frameRate);
}

void calculateTerrain()
{
  time+=0.01;
  zOffs = time;
  for(int i = 0; i < width/size; i++)
  {
    zOffs = 0;
    for (int j = 0; j < height/size; j++)
    {
      //elevation[i][j] = random(-10, 10);
      elevation[i][j] = map(noise(zOffs, zOffm), 0, 1, -20, 20);
      zOffs += 0.01;
    }
    zOffm += 0.01;
  }
}

void drawTerrain()
{  
  pushMatrix();
  
  translate(0, height/2); 
  rotateX(PI/3);
  
  //circle(0, 0, 50);
  
  beginShape();
  for(int i = 0; i < width-size-1; i+=size)
  {
    for(int j = 0; j < height; j+=size)
    {  
      //vertex(i, j, elevation[i/size][j/size]);
      //vertex(i+size, j, elevation[i/size+1][j/size]);
      //vertex(i, j, elevation[i/size][j/size]);
      //vertex(i, j+size, elevation[i/size][j/size+1]);
    }
  }
  endShape();
  
  popMatrix();
}
