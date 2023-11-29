PShape frogtank;
float rot;

void setup() 
{
  size(512, 512, P3D);
  frogtank = loadShape("frogtank.obj");
  frogtank.rotateX(PI);
}

void draw() 
{
  background(0xffffffff);
  lights();
  translate(width/2, height/2, 0);
  rect(0, 0, 50, 50);
  shape(frogtank);
  rotateY(rot);
  rot+=PI/36;
}
