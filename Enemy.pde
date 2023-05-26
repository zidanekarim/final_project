class Enemy extends Blob {



  public Enemy(int posX, int posY, int size, color myColor) {
    super(posX, posY, size, myColor);
  }

  void display() {
    stroke(0);
    fill(myColor);
    circle(posX, posY, size);
  }
  
  void checkBoundary() {
    if (this.posX < 0) {
      this.posX = 0;
    } else if (this.posX > width) {
      this.posX = width;
    }

    if (this.posY < 0) {
      this.posY = 0;
    } else if (this.posY > height) {
      this.posY = height;
    }
    
    
  }



  void moveEnemy(Blob target) {
    float targetX = target.posX;
    float targetY = target.posY;
    float easing = (1.0 / size);
    if (size >= target.size) {
      

      float dx = targetX - posX;
      float dy = targetY - posY;

      posX += dx * easing;
      posY += dy * easing;
    } else {

      float dx = posX - targetX;
      float dy = posY - targetY;

      posX += dx * easing;
      posY += dy * easing;
    }
  }
}
