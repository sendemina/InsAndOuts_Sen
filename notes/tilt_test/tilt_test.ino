const int tiltPin = 4;
const int lightPin = A0;
const int pressurePin = A1;

int tiltVal = 0;
int lightVal = 0;
int pressureVal = 0;

void setup() 
{
  pinMode(tiltPin, INPUT);
  pinMode(lightPin, INPUT);
  pinMode(pressurePin, INPUT);

  Serial.begin(9600);
}

void loop() 
{
  tiltVal = digitalRead(tiltPin);
  lightVal = analogRead(lightPin);
  pressureVal = analogRead(pressurePin);
  delay(100);
  Serial.write(tiltVal);
  Serial.write(map(lightVal, 0, 600, 100, 255));
  Serial.write(map(pressureVal, 0, 1023, 2, 99));
  //Serial.println(val);
}
