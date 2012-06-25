// The Nature of Code
// Daniel Shiffman
// Draft book

// Example 1-3: Vector magnitude

void setup() {
  size(800,200);
  smooth();
}

void draw() {
  background(255);
  
  PVector mouse = new PVector(mouseX,mouseY);
  PVector center = new PVector(width/2,height/2);
  mouse.sub(center);

  float m = mouse.mag();
  fill(0);
  rect(0,0,m,10);
  
  translate(width/2,height/2);
  line(0,0,mouse.x,mouse.y);
  
}


