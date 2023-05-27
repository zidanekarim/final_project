class Enemy extends Blob {



  public Enemy(int posX, int posY, int size, color myColor) {
    super(posX, posY, size, myColor);
  }

  void display() {
    stroke(0);
    fill(myColor);
    circle(posX, posY, size);
  }
  
  void eatPellet() {
    for (int i = pellets.size() - 1; i >= 0; i--) {
      int pelletX = pellets.get(i).posX;
      int pelletY = pellets.get(i).posY;

      float distance = dist(this.posX, this.posY, pelletX, pelletY);
      int blobRadius = this.size / 2;
      int pelletRadius = 10;

      if (distance <= blobRadius - pelletRadius) {
        pellets.remove(i);
        this.size += 5; // Increase the size of the blob when eating a pellet
      }
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
