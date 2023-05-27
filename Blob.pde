class Blob {
  public int posX;
  public int posY;
  public int size;
  public color myColor;
  public boolean touching = false; 

  public Blob(int posX, int posY, int size, color myColor) {
    this.posX = posX;
    this.posY = posY;
    this.size = size;
    this.myColor = myColor;
  }

  void update() {
    checkBoundary();
  }

void checkBoundary() {
  if (posX < -size/2) {
    posX = width + size/2;
  } else if (posX > width + size/2) {
    posX = -size/2;
  }

  if (posY < -size/2) {
    posY = height + size/2;
  } else if (posY > height + size/2) {
    posY = -size/2;
  }
}


  void followMouse() {
    float targetX = mouseX;
    float targetY = mouseY;
    float easing = (1.0 / size);

    float dx = targetX - posX;
    float dy = targetY - posY;

    posX += dx * easing;
    posY += dy * easing;
  }

  void eatPellet() {
    for (int i = pellets.size() - 1; i >= 0; i--) {
      int pelletX = pellets.get(i).posX;
      int pelletY = pellets.get(i).posY;

      float distance = dist(posX, posY, pelletX, pelletY);
      int blobRadius = size / 2;
      int pelletRadius = 10;

      if (distance <= blobRadius - pelletRadius) {
        pellets.remove(i);
        size += 5; // Increase the size of the blob when eating a pellet
        score += 10;
      }
    }
  }
  
void eatEnemy() {
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Blob enemy = enemies.get(i);
    float distance = dist(posX, posY, enemy.posX, enemy.posY);
    int blobRadius = size / 2;
    int enemyRadius = enemy.size / 2;

    if (distance <= (blobRadius + enemyRadius)/2) {
      if (blobRadius > enemyRadius) {
        enemies.remove(i);
        size += enemyRadius;
        score += 100;
        println("Blob ate an enemy!");
      } else {
        // Blob is smaller or equal in size, it gets eaten
        println("Blob got eaten by an enemy!");
        myBlobs.remove(this);
        gameOver = true;
      }
    }
  }
}


  void display() {
    stroke(0);
    fill(myColor);
    circle(posX, posY, size);
  }
  void checkCollision() {
    for (Blob other : myBlobs) {
      if (other != this) {
        float minDist = size / 2 + other.size / 2;
        float actualDist = dist(posX, posY, other.posX, other.posY);
        if (actualDist < minDist) {
          PVector direction = PVector.sub(new PVector(other.posX, other.posY), new PVector(posX, posY));
          direction.normalize();
          PVector correction = direction.mult((minDist - actualDist) / 2);
          posX -= correction.x;
          posY -= correction.y;

          touching = true;  // Set the touching variable to true
        }
      }
    }
  }
}
