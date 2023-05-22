class Pellet {
 int posX;
 int posY;
 color myColor;
 
 public Pellet() {
   posX = int(random(width));
   posY = int(random(height));
   myColor = color(random(255),random(255),random(255));
   drawPellet();
   
 }
 
 void drawPellet() {
  noStroke();
  fill(myColor);
  circle(posX, posY, 10);  
 }
 
 
}
