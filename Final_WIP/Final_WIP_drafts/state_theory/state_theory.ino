
int buttonVal = 10;
int potVal = 20;
int lightVal = 30;

enum state { button, pot, light };
state currentState = button;

void setup() 
{
  Serial.begin(9600);
}

void loop() 
{
  currentState = button;
  Serial.print(currentState);
  Serial.println(buttonVal);
  
  currentState = pot;
  Serial.print(currentState);
  Serial.println(potVal);
  
  currentState = light;
  Serial.print(currentState);
  Serial.println(lightVal);

  delay(1000);
}
