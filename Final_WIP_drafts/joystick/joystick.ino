const int selectPin = 3;
const int vertPin = A0;
const int horzPin = A1;

int selectVal = 0;
int vertVal = 0;
int horzVal = 0;

void setup() 
{
  pinMode(selectPin, INPUT);
  pinMode(vertPin, INPUT);
  pinMode(horzPin, INPUT);

  Serial.begin(9600);
}

void loop() 
{
  selectVal = digitalRead(selectPin);
  vertVal = analogRead(vertPin);
  horzVal = analogRead(horzPin);

  Serial.print("select = ");
  Serial.print(selectVal);
  Serial.print("  vert = ");
  Serial.print(vertVal);
  Serial.print("  horz = ");
  Serial.println(horzVal);
}
