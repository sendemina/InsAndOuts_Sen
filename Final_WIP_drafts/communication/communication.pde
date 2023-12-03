import processing.serial.*; 

Serial myPort; 
int val = 0;

enum axisState { Xa, Ya, Za };
axisState currentAxis;
 
float valX, valY, valZ;

void setup()
{
  size(300, 300);
  
  //String portName = Serial.list()[0]; //for windows
  String portName = Serial.list()[5];   //for mac
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  if(myPort.available() > 0) 
  {                     
    val = myPort.read();
    
    switch(val)
    {
      case 0:
        currentAxis = axisState.Xa;
        //println("state is now X "+millis());
        break;
      case 1:
        currentAxis = axisState.Ya;
        //println("state is now Y "+millis());
        break;
      case 2:
        currentAxis = axisState.Za;
        //println("state is now Z"+millis());
        break;
      default:
        handleInputAxes();
        //println(val);
    }
  }
  //else { println("port unavailable"); }
}

void handleInputAxes()
{
  if(currentAxis == axisState.Xa) 
  {  
    valX = val;
    //rotX += map(valX, 3, 255, -0.1, 0.1);
    println("valX="+valX);
  }    
  
  else if (currentAxis == axisState.Ya) 
  {  
    valY = val;
    //rotY += map(valY, 3, 255, -0.1, 0.1);
    println("valY="+valY);
  }
  
  else if(currentAxis == axisState.Za) 
  {  
    valZ = val;
    println("valZ="+valZ);
  }
  
  else { println("state error"); }

  //println("axisState="+currentAxis);
  println("x="+valX+" y="+valY+" z="+valZ);
}
