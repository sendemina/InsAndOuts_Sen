//pentatonic lyre


//string is plucked when mouse hovers over => release?(very low frequency?)
//string length corresponds to tone
//image of lyre
//animate string vibration?

int val=0; //to send over Serial
//PImage piano;
LyreString[] strings = new LyreString[5];

//pentatonic: C D E G A, octave 3
//float[] frequencies = { 130.81, 146.83, 164.81, 196, 220 };
int[] frequencies = { 131, 147, 165, 196, 220 };


import processing.serial.*;  //import Serial library

Serial myPort;  // create object from Serial class

void setup() 
{
  size(600, 400); 
  //piano = loadImage("piano.png");
  
  for (int i = 0; i < strings.length; i++)
  {
    strings[i] = new LyreString(i);
  }
  
  textSize (44);
  textAlign (CENTER, CENTER);

  //set up Serial communication
  printArray(Serial.list()); // prints port list to the console
  String portName = Serial.list()[0]; //change to match your port
  myPort = new Serial(this, portName, 9600); //initialize Serial communication at 9600 baud
}

void draw() 
{  
  background(200);
  stroke(10);
  
  //move the strings within the frame of the lyre
  for (int i = 0; i < strings.length; i++)
  {
    if (strings[i].isPlucked()) 
    { 
      strings[i].playNote(); 
      println("string n" + i + " is plucked");
    }
    strings[i].drawString();
  }
      

  //background (mouseX, mouseY, mouseX/2);

  //image(piano, 0, -60);
  fill (mouseY+100, 0, mouseX);
  //text ("PRESS AND MOVE", width/2, height/2);

  if (mousePressed) 
  {
    //mouse location controls communication to Serial 
    val= int (map (mouseX, 0, width, 0, 255)); //remaps mouseY to 0-255  
    myPort.write(val); //write to Serial
    println(val);  //print to console

    //NOTE: SENDING VALUES 0-255 as Arduino receives byte-sized data over port
  }
}

//map each frequency to 0-255 => convert back in arduino (hardcoded switch statements)
class LyreString
{
  float posX;
  int freq;
  
  LyreString(int degree)
  {
    freq = frequencies[degree];
    posX = map(width/5 * degree, 0, width, 50, width-50);
  }
  
  //make it vibrate(two lines)
  void drawString()
  {
    line(posX, height, posX, freq);
  }
  
  boolean isPlucked()
  {
    if(mouseX == posX)
    {
      return true;
    }
    else { return false; }
  }
  
  void playNote()
  {
    val = freq;
    //myPort.write(val);
    println("frequency of " + val + " is sent");
  }
}
