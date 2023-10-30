const int LEDpin1 = 11;
const int LEDpin2 = 10;
const int LEDpin3 = 9;
const int LEDpin4 = 6;
const int LEDpin5 = 5;
const int LEDpin6 = 3;

const int buttonPin = 2;

bool buttonState = LOW;

void setup() 
{
  pinMode(LEDpin1, OUTPUT);
  pinMode(LEDpin2, OUTPUT);
  pinMode(LEDpin3, OUTPUT);
  pinMode(LEDpin4, OUTPUT);
  pinMode(LEDpin5, OUTPUT);
  pinMode(LEDpin6, OUTPUT);
  
  pinMode(buttonPin, INPUT);
}

void loop() 
{
  buttonState = digitalRead(buttonPin);



  if (buttonState == HIGH)
  {
    digitalWrite(LEDpin1, HIGH);  
    delay(1000);
    digitalWrite(LEDpin2, HIGH);
    delay(1000);
    digitalWrite(LEDpin3, HIGH);
    delay(1000);
    digitalWrite(LEDpin4, HIGH);  
    delay(1000);
    digitalWrite(LEDpin5, HIGH);
    delay(1000);
    digitalWrite(LEDpin6, HIGH);
    delay(1000);
  }
  
  if (buttonState == LOW)
  {
    digitalWrite(LEDpin1, LOW);
    digitalWrite(LEDpin2, LOW);
    digitalWrite(LEDpin3, LOW);
    digitalWrite(LEDpin4, LOW);
    digitalWrite(LEDpin5, LOW);
    digitalWrite(LEDpin6, LOW);
  }
}
