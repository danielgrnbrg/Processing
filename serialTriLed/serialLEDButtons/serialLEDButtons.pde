import processing.serial.*;

int rectX, rectY;      // Position of square button
int rectX2,rectY2;
int circleX, circleY;  // Position of circle button
int rectSize = 90;     // Diameter of rect
int rectSize2= 90;
int circleSize = 93;   // Diameter of circle
int currMessage = -1;
color rectColor, rectColor2, circleColor, baseColor;
color rectHighlight, circleHighlight, rectHighlight2;
color currentColor;
boolean rectOver = false;
boolean circleOver = false;
boolean rectOver2 = false;
boolean redOn = false;
boolean greenOn = false;
boolean blueOn = false;
Serial port;

void setup() {
  String portName = Serial.list()[0];
  port = new Serial(this, portName, 9600);
  size(640, 360);
  rectColor = color(100,0,0);
  circleColor = color(0,100,0);
  rectColor2 = color(0,0,100);
  rectHighlight = color(255,0,0);
  circleHighlight = color(0,255,0);
  rectHighlight2 = color(0,0,255);
  baseColor = color(255);
  currentColor = baseColor;
  circleX = width/2+circleSize/2+50;
  circleY = height/2;
  rectX = width/2-rectSize-10+30;
  rectY = height/2-rectSize/2;
  rectX2 = width/2-rectSize-10-rectSize-20;
  rectY2 = height/2-rectSize/2;
  ellipseMode(CENTER);
}

void draw() {
  port.write(currMessage);
  update(mouseX, mouseY);
  background(currentColor);
  
  if(redOn){
    int count=15;
    for(int i=count;i>0;i--){
      stroke((255-count*2)+i*2,(255-pow(count,2))+pow(i,2),(255-pow(count,2))+pow(i,2));
      rect(rectX-i,rectY-i,rectSize+i*2,rectSize+i*2);
    }
  }
  if(rectOver||redOn) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(0);
  rect(rectX, rectY, rectSize, rectSize);
  
  if(blueOn){
    int count=15;
    for(int i=count;i>0;i--){
      stroke((255-pow(count,2))+pow(i,2),(255-pow(count,2))+pow(i,2),(255-count*2)+i*2);
      rect(rectX2-i,rectY2-i,rectSize2+i*2,rectSize2+i*2);
    }
  }
  if(rectOver2||blueOn){
    fill(rectHighlight2);
  }else{
    fill(rectColor2);
  }
  stroke(0);
  rect(rectX2,rectY2,rectSize2,rectSize2);
  
  if(greenOn){
    int count=10;
    for(int i=count;i>0;i--){
      stroke((255-pow(count,2))+pow(i,2),(255-count*2)+i*2,(255-pow(count,2))+pow(i,2));
      ellipse(circleX,circleY,circleSize+i*2,circleSize+i*2);
    }
  }
  if(circleOver||greenOn) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
}

void update(int x, int y) {
  if( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
    rectOver2=false;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver = false;
    rectOver2=false;
  } else if( overRect(rectX2,rectY2,rectSize2,rectSize2) ){
    rectOver2 = true;
    circleOver=false;
    rectOver=false;
  }else {
    circleOver = rectOver = rectOver2 = false;
  }
}

void mousePressed() {
  if(circleOver) {
    if(greenOn){
      currMessage=8;
      greenOn=false;
    }
    else{
      currMessage=0;
      greenOn=true;
    }
    //currentColor = circleColor;
  }
  else if(rectOver) {
    if(redOn){
      currMessage=9;
      redOn=false;
    }
    else{
      currMessage = 1;
      redOn=true;
    }
    //currentColor = rectColor;
  }else if(rectOver2){
    if(blueOn){
      currMessage=10;
      blueOn=false;
    }else{
      currMessage=2;
      blueOn=true;
    }
  }
  else{
    currMessage = 7;
    redOn=false;
    greenOn=false;
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
