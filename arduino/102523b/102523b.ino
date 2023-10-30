
const int ledPins[] = { 11, 10,9, 6, 5, 3};
const int ledCount = 6;

const int buttonPin = 2;

bool buttonState = LOW;

void setup() 
{
  for (int i = 0; i < ledCount - 1; i++)
  {
    pinMode(ledPins[i], OUTPUT);
  }
    
  pinMode(buttonPin, INPUT);
}

void loop() 
{
  buttonState = digitalRead(buttonPin);

  if (buttonState == HIGH)
  {
    for (int i = 0; i < ledCount; i++)
    {
       analogWrite(ledPins[i], (i+1)*20);      
       delay(1000);
    }
  }
  else
  {
    for (int i = 0; i < ledCount; i++)
    {
       digitalWrite(ledPins[i], LOW);
    }
  }
}
