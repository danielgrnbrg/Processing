void setup()
{
  size(200, 200);  
}

void draw()
{
  int multiplyer=20;
  float[] xyPos={1.6,1.8};//target (x,y) position
  float l1=2.5;//length of arm1
  float l2=2.5;//length of arm2
  float c2=(float)(Math.pow(xyPos[0],2)+Math.pow(xyPos[1], 2)-Math.pow(l1,2)-Math.pow(l2,2))/(2*l1*l2);
  float s2=(float)Math.sqrt(1-Math.pow(c2, 2));
  float theta2=(float)Math.acos((Math.pow(xyPos[0], 2)+Math.pow(xyPos[1],2)-Math.pow(l1, 2)-Math.pow(l2,2))/(2*l1*l2));//arm1 target angle
  float theta1=(float)(Math.asin((xyPos[1]*(l1+l2*c2)-xyPos[0]*l2*s2)/(Math.pow(xyPos[0],2)+Math.pow(xyPos[1],2)))); //arm2 target angle
  
  background(0);
  stroke(255);
  lineAngle(50,125, theta1, l1*multiplyer);
  float x=l1*(multiplyer)*cos(theta1);
  float y=l1*(multiplyer)*sin(theta1);
  ellipse(50,125,15,15);
  ellipse(50+x,125-y,10,10);
  float x2=l1*(multiplyer)*cos(theta2+theta1);
  float y2=l1*(multiplyer)*sin(theta2+theta1);
  lineAngle(50+x,125-y,theta2+theta1,l2*multiplyer);
  lineAngle(50+x+x2,125-y-y2,(theta1+theta2)-(theta1+theta2),.5*multiplyer);
}

void lineAngle(float x, float y, float angle, float length)
{
  line(x, y, x+cos(angle)*length, y-sin(angle)*length);
}
