/*
Arduino Turn LED On/Off using Serial Commands
Created April 22, 2015
Hammad Tariq, Incubator (Pakistan)

It's a simple sketch which waits for a character on serial
and in case of a desirable character, it turns an LED on/off.

Possible string values:
a (to turn the LED on)
b (tor turn the LED off)
*/

char inputChar;
String inputString = "";
byte motor[][4] = { //Q1, Q2, Q3, Q4
  {1, 2, 3, 4},     /*LeftMotor*/
  {5, 6, 7, 8},     /*RightMotor*/
};

void motorForward(byte forwardPins[]) {
  resetPins();
  digitalWrite(forwardPins[0], HIGH);
  digitalWrite(forwardPins[3], HIGH);
}

void motorReverse(byte reversePins[]) {
  resetPins();
  digitalWrite(reversePins[1], HIGH);
  digitalWrite(reversePins[2], HIGH);
}

void motorNeutral() {
  resetPins();
}

void motorBrake(byte brakePins[]) {
  resetPins();
  digitalWrite(brakePins[1], HIGH);
  digitalWrite(brakePins[3], HIGH);
}

void bluetoothRead() {
  if (Serial.available()) {
    while (Serial.available()) {
      char inChar = (char)Serial.read(); //read the input
      inputString += inChar;        //make a string of the characters coming on serial
      Serial.println("IN: " + inputString + "OVER");
    }

    while (Serial.available() > 0) {
      inputChar = Serial.read() ;  // clear the serial buffer
    }
  }
}

void resetPins() {
  for (byte i = 0; i < sizeof(motor)/sizeof(motor[0]); i++) {
    for (byte b = 0; b < sizeof(motor[0]); b++) {
      digitalWrite(motor[i][b], LOW);
    }
  }
}

void checkOutputs() {
  for (byte i = 0; i < sizeof(motor)/sizeof(motor[0]); i++) {
    for (byte b = 0; b < sizeof(motor[0]); b++) {
      Serial.print("Pin ");
      Serial.print(i);
      Serial.print("-");
      Serial.println(b + ": " + digitalRead(motor[i][b]));
    }
  }
}

void attackSequence() { //********************WEAPONIZE IF DOING BATTLEBOT********************

}

void setup()                    // run once, when the sketch starts
{
  Serial.begin(9600);            // set the baud rate to 9600, same should be of your Serial Monitor
  pinMode(13, OUTPUT);
  for (byte i = 0; i < 1; i++) {
    for (byte b = 0; b < 3; b++) {
      pinMode(motor[i][b], OUTPUT);
    }
  }
}

void loop() {
  //Read bluetooth input, if any
  //bluetoothRead();

  if (Serial.available() > 0) {
    char inputCharacter = (char)Serial.read();
    Serial.println(inputCharacter);
    Serial.println("AFIOAOEF");

    //LED testing for visual feedback
    if (inputCharacter == 'o') {       //in case of 'a' turn the LED on
      digitalWrite(13, HIGH);
    } else if (inputCharacter == 'f') { //incase of 'b' turn the LED off
      digitalWrite(13, LOW);
    }

    //move car based on input
    //f = forward, b = backwards, l = left, r = right, s = stop, a = attack, n = neutral

    if (inputCharacter == 'f') {              //If input is f move forwards
      motorForward(motor[0]);
      motorForward(motor[1]);
    } else if (inputCharacter == 'b') {       //If input is b move backwards
      motorReverse(motor[0]);
      motorReverse(motor[1]);
    } else if (inputCharacter == 'l') {       //If input is l turn left
      motorBrake(motor[0]);
      motorForward(motor[1]);
    } else if (inputCharacter == 'r') {       //If input is r turn right
      motorForward(motor[0]);
      motorBrake(motor[1]);
    } else if (inputCharacter == 'a') {       //If input is a attack
      attackSequence();                       //Should it stop when attacking?
    } else if (inputCharacter == 's') {       //If input is s stop
      motorBrake(motor[0]);
      motorBrake(motor[1]);
    } else if (inputCharacter == 'n') {
      motorNeutral();
    }
  }
  //checkOutputs();

  inputString = "";
}
