import processing.serial.*;

Serial port;

void setup() {
  printArray(Serial.list());
  port = new Serial(this, Serial.list()[1], 9600);
  size(700, 700);
}

void draw() {
  
  if(keyPressed) {
    if(key == 'a') {
     port.write('o'); 
    } else {
     port.write('p'); 
    }
  }
  
  //serialRect(50, 50, 600, 100, 'o', "ON");
  // serialRect(50, 50, 600, 200, 'o', "ON");
}
/*
void serialRect(int x; int y; int wide, int high, char data; String text) {
  fill(150);
  rect(x, y, wide, high);
  fill(0);
  text(text, x+2, y+high/2);
  if(mouseX > x && mouseX < x + wide && mouseY > y && y < y + high) {
   port.write(data); 
  }
}
*/