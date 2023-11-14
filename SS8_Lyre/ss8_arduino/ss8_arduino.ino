
const int BUZZER = 5; 
const int LED = 10;
int val = 0; 

void setup() 
{
  pinMode(BUZZER, OUTPUT); 
  pinMode(LED, INPUT);
  Serial.begin (9600); 
}

void loop() 
{
  if (Serial.available()) 
  { 
    val = Serial.read(); 
    delay (10);
    
    analogWrite(LED, val);
    tone (BUZZER, val, 100);  
    delay (1);
  }   
}
