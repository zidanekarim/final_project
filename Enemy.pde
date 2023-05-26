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
  float easing = 0.05; // Adjust the easing value to control the speed of movement

  float dx = targetX - posX;
  float dy = targetY - posY;

  // Calculate the distance between the enemy and the target
  float distance = sqrt(dx * dx + dy * dy);

  if (distance != 0) {
    // Normalize the direction vector
    dx /= distance;
    dy /= distance;
  }

  if (size >= target.size) {
    // Move towards the target
    posX += dx * easing * size;
    posY += dy * easing * size;
  } else {
    // Move away from the target
    posX -= dx * easing * size;
    posY -= dy * easing * size;
  }
}

  
  
  
  
}
