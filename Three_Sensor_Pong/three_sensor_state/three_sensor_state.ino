const int buttonPin = 4;
const int potPin = A0;
const int lightPin = A1;

int buttonVal = 0;
int potVal = 0;
int lightVal = 0;

enum state { button, pot, light };
state currentState;

void setup() 
{
  pinMode(buttonPin, INPUT);
  pinMode(potPin, INPUT);
  pinMode(lightPin, INPUT);

  Serial.begin(9600);
}

void loop() 
{
  buttonVal = digitalRead(buttonPin);
  potVal = analogRead(potPin);
  lightVal = analogRead(lightPin);
  delay(100);

  currentState = button;
  Serial.write(currentState);
  Serial.write(map(buttonVal, 0, 1, 3, 255));
  
  currentState = pot;
  Serial.write(currentState);
  Serial.write(map(potVal, 0, 1023, 3, 255));
  
  currentState = light;
  Serial.write(currentState);
  Serial.write(map(lightVal, 0, 1023, 3, 255));
//  
//  Serial.print("Button=");
//  Serial.print(buttonVal);
//  Serial.print("  Pot=");
//  Serial.print(potVal);
//  Serial.print("  Light=");
//  Serial.println(lightVal);
}
