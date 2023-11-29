import processing.serial.*; 

Serial myPort; 
int val = 0;

enum axisState { Xa, Ya, Za };
axisState currentAxis;
 
float x, y, z;

void setup()
{
  size(800, 600);

  printArray(Serial.list()); 
  
  //String portName = Serial.list()[0]; //for windows
  String portName = Serial.list()[5];   //for mac
  myPort = new Serial(this, portName, 9600); 
  //myPort = new Serial(this, "/dev/cu.usbmodem14601", 9600);

}

void draw()
{
  background(10);
  fill(200);
  noStroke();
  
  if(myPort.available() > 0) 
  {                     
    val = myPort.read();
    
    switch(val)
    {
      case 0:
        currentAxis = axisState.Xa;
        break;
      case 1:
        currentAxis = axisState.Ya;
        break;
      case 2:
        currentAxis = axisState.Za;
        break;
      default:
        handleInputAxes();
    }
    //println(val);
  }
}


void handleInputAxes()
{
  if(currentAxis == axisState.Xa) 
  {  
    x = val;
  }    
  
  else if (currentAxis == axisState.Ya) 
  {  
    y = val;
  }
  
  else if(currentAxis == axisState.Za) 
  {  
    z = val;
  }
  
  else { println("state error"); }

  println("x="+x+" y="+y+" z="+z);
}



  


 
