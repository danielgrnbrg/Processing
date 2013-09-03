import processing.serial.*;

/**
 * Keyboard. 
 * 
 * Click on the image to give it focus and press the letter keys 
 * to create forms in time and space. Each key has a unique identifying 
 * number. These numbers can be used to position shapes in space. 
 */

int rectWidth;
Serial port;

void setup() {
  size(640, 360);
  noStroke();
  background(0);
  rectWidth = width/4;
  String portName = Serial.list()[0];
  port = new Serial(this, portName, 9600);
}

void draw() { 
  // keep draw() here to continue looping while waiting for keys
  if(port.read()!=-1){print(port.read());}
}

void keyPressed() {
  int keyIndex = -1;
  if (key >= 'A' && key <= 'Z') {
    switch(key){
      case 'a':
        port.write(0);
        break;
      case 's':
        port.write(1);
        break;
      case 'd':
        port.write(2);
        break;
    }
  } else if (key >= 'a' && key <= 'z') {
    switch(key){
      case 'a':
        port.write(0);
        break;
      case 's':
        port.write(1);
        break;
      case 'd':
        port.write(2);
        break;
    }
  }
  if (keyIndex == -1) {
    // If it's not a letter key, clear the screen
    background(0);
  } else { 
    // It's a letter key, fill a rectangle
    fill(millis() % 255);
    float x = map(keyIndex, 0, 25, 0, width - rectWidth);
    rect(x, 0, rectWidth, height);
  }
}
