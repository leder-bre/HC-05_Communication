import processing.serial.*;

byte directionL = 0;
byte directionR = 0;
byte L = 0;
byte R = 0;
boolean light = false;
String direction = "Brake";
Serial port;

void setup() {
  printArray(Serial.list());
  port = new Serial(this, Serial.list()[1], 9600);
  size(700, 700);
  textSize(50);
  textAlign(CENTER);
}

void draw() {
  background(255);
  if (keyPressed) {
    if (key == 'w') {
      port.write('f');
      directionL = 1;
      directionR = 1;
      direction = "Drive";
    } else if (key == 'a') {
      port.write('r');
      directionR = 1;
      directionL = 2;
      direction = "Left";
    } else if (key == 'd') {
      port.write('l');
      directionR = 2;
      directionL = 1;
      direction = "Right";
    } else if (key == 's') {
      port.write('b');
      directionR = 2;
      directionL = 2;
      direction = "Reverse";
    } else {
      port.write('s');
      directionR = 0;
      directionL = 0;
      direction = "Brake";
    }
  }
  if (directionR == 2) {
   R += 1;
   if (R > 11) {
    R = 0; 
   }
  } else if (directionR == 1) {
   R -= 1; 
    if (R < 0) {
     R = 11; 
    }
  }
  
  if (directionL == 2) {
   L += 1;
   if (L > 11) {
    L = 0; 
   }
  } else if (directionL == 1) {
   L -= 1; 
    if (L < 0) {
     L = 11; 
    }
  }
  
  fill(80);
  rect(width/8, height/2 + 267, width/8, 40);
  rect(width/8, height/2 + -14, width/8, 40);
  fill(0);
  for(int i = 0; i < width/8 + 1; i += 13) {
    rect(85 + i + R, height/2 - 16, 2, 44);
  }
  for(int i = 0; i < width/8 + 1; i += 13) {
    rect(85 + i + L, height/2 + 265, 2, 44);
  }
  pushMatrix();
  translate(430, 0);
  fill(80);
  rect(width/8, height/2 + 267, width/8, 40);
  rect(width/8, height/2 + -14, width/8, 40);
  fill(0);
  for(int i = 0; i < width/8 + 1; i += 13) {
    rect(85 + i + R, height/2 - 16, 2, 44);
  }
  for(int i = 0; i < width/8 + 1; i += 13) {
    rect(85 + i + L, height/2 + 265, 2, 44);
  }
  popMatrix();
  fill(200);
  rect(width/8, height/2 + 30, 6*width/8, height/3);
  if (light == true) {
    fill(255, 0, 0);
    stroke(0);
    ellipse(float(width)/4, float(height)/2 + float(height)/8, float(height)/20, float(height)/20);
    fill(255, 0, 0, 20);
    noStroke();
    ellipse(float(width)/4, float(height)/2 + float(height)/8, float(height)/10, float(height)/10);
  } else {
    fill(100, 0, 0);
    stroke(0);
    ellipse(float(width)/4, float(height)/2 + float(height)/8, float(height)/20, float(height)/20);
  }
  serialRect(50, 50, 600, 100, 'o', "ON");
  serialRect(50, 200, 600, 100, 'p', "OFF");
  text(direction, width/2, height/2 + height/5);
}

void serialRect(int x, int y, int wide, int high, char data, String text) {
  fill(150);
  noStroke();
  rect(x, y, wide, high, 5);
  fill(0);
  text(text, x+wide/2, y+high/2);
  if (mousePressed) {
    if (mouseX > x && mouseX < x + wide && mouseY > y && mouseY < y + high) {
      port.write(data);
      if (data == 'o') {
        light = true;
      } else {
        light = false;
      }
    }
  }
}