


//string is plucked when mouse hovers over => release?(very low frequency?)


int val=0;
LyreString[] strings = new LyreString[12];

//pentatonic: C D E G A, octave 3
//float[] frequencies = { 130.81, 146.83, 164.81, 196, 220 };
//int[] frequencies = { 131, 147, 165, 196, 220 };
int[] frequencies = { 131, 139, 147, 156, 165, 175, 185, 196, 208, 220, 233, 247 };


import processing.serial.*; 

Serial myPort;
PImage lyre;
int tail = 580;

void setup() 
{
  size(500, 650); 
  lyre = loadImage("lyre.png");
  
  for (int i = 0; i < strings.length; i++)
  {
    strings[i] = new LyreString(i);
  }

  //set up Serial communication
  printArray(Serial.list()); // prints port list to the console
  String portName = Serial.list()[5]; //change to match your port
  myPort = new Serial(this, portName, 9600); //initialize Serial communication at 9600 baud
}

void draw() 
{  
  background(50, 80, 80);

  image(lyre, 0, 0);
  //println(mouseX);//166 - 313
  //println(mouseY);//580
   
  stroke(240, 230, 230);
  strokeWeight(4);
  for (int i = 0; i < strings.length; i++)
  {
    if (strings[i].isPlucked()) 
    { 
      strings[i].playNote(); 
      println("string n" + i + " is plucked");
    }
    strings[i].drawString();
  }
}

class LyreString
{
  float posX;
  int freq;
  float vib;
  int peg;
  int timeOfPluck;
  float pluckY;
  
  LyreString(int degree)
  {
    freq = frequencies[degree];
    posX = map(width/12 * degree, 0, width, 160, 330);
    peg = 280-freq;
  }
  
  void drawString()
  {
    if(!isPlucked() && (millis() - timeOfPluck >= 2000))
    {
      line(posX, tail, posX, peg);
    }
    else
    {
      line(posX, tail, posX+vib, pluckY);
      line(posX+vib, pluckY, posX, peg);
      vib *= -0.9;
    }
  }
  
  boolean isPlucked()
  {
    if(mouseX>=posX-10 && mouseX<=posX+10 && mouseY>=peg && mouseY<=tail)
    {      
      timeOfPluck = millis();
      pluckY = mouseY;
      vib = map(mouseX-pmouseX, 0, width, 0, 100);
      println(posX);
      return true;
    }
    else { return false; }
  }
  
  void playNote()
  {
    val = freq;
    myPort.write(val);
    //println("frequency of " + val + " is sent");
  }
}
