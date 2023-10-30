//Sen Demina
//Endurance
//Keep pressing the button long enough to fill the bar!

const int ledPins[] = { 11, 10,9, 6, 5, 3 };
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
  Serial.begin(9600);
}

void loop() 
{
  buttonState = digitalRead(buttonPin);

  for (int i = 0; i < ledCount; i++)
  {
    if(buttonState == HIGH)
    {
      analogWrite(ledPins[i], map(i, 0, ledCount-1, 10, 255));
      delay(1000);
      buttonState = digitalRead(buttonPin);

      if(i == ledCount-1)
      {
        bool state = LOW;
        for (int k = 0; k < 7; k++)
        {
          for (int j = 0; j < ledCount; j++)
          {
            digitalWrite(ledPins[j], state);
          }          
          state = !state;
          delay(700);
        }
      }
    }
    else
    {
      analogWrite(ledPins[i], 0);
    }
  }
 }
