float rot;
int size = 10;

PVector move;

void setup()
{
  size(600, 600, P3D);
  move = new PVector(0, 0);
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
  //move.x += sin(rot)*2;
  //move.y += cos(rot)*2;
  circle(0, 0, 50);
  
  stroke(200, 100, 100);
  strokeWeight(5);
  line(-width, 0, width, 0);
  line(0, -height, 0, height);
  
  if(mousePressed)
  {
    if(mouseX - pmouseX > 0) { rot+=PI/36; }
    else if (mouseX - pmouseX < 0) { rot-=PI/36; }
  }
  if(keyPressed)
  {
    if(keyCode==UP) { move.add(new PVector(sin(rot)*2, cos(rot)*2)); }
    else if(keyCode==DOWN) { move.add(new PVector(-sin(rot)*2, -cos(rot)*2)); }
    //else if (keyCode==LEFT) { move.add(new PVector(sin(rot)*2, cos(rot)*2)); }
    //else if(keyCode==RIGHT) { move.add(new PVector(1, 0)); }
  }
  
  stroke(100, 100, 200);
  fill(250);
  strokeWeight(5);
  translate(move.x, move.y);
  for(int i = 0; i < 10; i++)
  {
    translate(0, size);
    rect(0, 0, size, size);
  }
}
