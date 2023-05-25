class Enemy extends Blob {
  
  
  
  public Enemy(int posX, int posY, int size, color myColor) {
    super(posX, posY, size, myColor); 
  }
  
  void display() {
    stroke(0);
    fill(myColor);
    circle(posX, posY, size);
  }
  
  
  void moveEnemy(Blob target) {
   if (size >= target.size) {
    float targetX = target.posX;
    float targetY = target.posY;
    float easing = (1.0 / size);

    float dx = targetX - posX;
    float dy = targetY - posY;

    posX += dx * easing;
    posY += dy * easing;
   }
   else {
    float targetX = target.posX*-1;
    float targetY = target.posY*-1;
    float easing = (1.0 / size);

    float dx = targetX - posX;
    float dy = targetY - posY;

    posX += dx * easing;
    posY += dy * easing;
   }
    
  }
  
}
