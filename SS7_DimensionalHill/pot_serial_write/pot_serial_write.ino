
const int potPin = A0;  
int reading = 0; 

void setup() 
{
  pinMode (potPin, INPUT);
  
  Serial.begin(9600);
}

void loop() 
{
  reading = analogRead(potPin); 
  reading = reading/4;
  delay(100);              
  
  Serial.write(reading);
}
